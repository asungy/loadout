use std::path::PathBuf;
use crate::prompt::Prompt;
use sha2::Digest;
use aes_gcm::{Aes256Gcm, Key, Nonce, AeadCore};
use aes_gcm::aead::{KeyInit, OsRng, Aead};
use std::io::Write;

pub fn get_ciphertext_filename() -> anyhow::Result<PathBuf> {
    Ok(std::env::current_dir()?.join("secrets/sops_key"))
}

pub fn get_nonce_filename() -> anyhow::Result<PathBuf> {
    Ok(std::env::current_dir()?.join("secrets/sops_key_nonce"))
}

pub fn f() -> anyhow::Result<Option<Prompt>> {
    let new_sops_plaintext = {
        let tempdir = tempfile::Builder::new()
            .prefix("nixos-sops-generation")
            .tempdir()?;

        let target = tempdir.path().join("key.txt");
        let age_command = format!("age-keygen -o {}", target.to_string_lossy());
        let output = std::process::Command::new("nix-shell")
            .args([
                "-p",
                "age",
                "--run",
                age_command.as_str(),
            ])
            .output()
            .unwrap();
        if output.status.success() {
            println!("{}", std::str::from_utf8(&output.stdout).unwrap());
            println!("Generated sops file at {}", target.to_string_lossy());
        } else {
            eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
            return Err(anyhow::anyhow!("Error generating age key file."));
        }

        let contents = std::fs::read_to_string(target)?;

        // The file that is produced has two lines of comments above the actual key.
        // We just want to return the actual key.
        String::from(contents.split('\n').collect::<Vec<&str>>()[2])
    };

    let password = inquire::Password::new("Enter a password:")
        .with_display_toggle_enabled()
        .with_display_mode(inquire::PasswordDisplayMode::Hidden)
        .with_custom_confirmation_message("Confirm password:")
        .with_custom_confirmation_error_message("The keys don't match.")
        .with_help_message("Press <Ctrl-R> to toggle display")
        .prompt()?;

    let hash = {
        let mut hasher = sha2::Sha256::new();
        hasher.update(password.into_bytes());
        hasher.finalize()
    };
    let key = Key::<Aes256Gcm>::from_slice(&hash);

    let cipher = Aes256Gcm::new(&key);
    let nonce = Aes256Gcm::generate_nonce(&mut OsRng);
    let ciphertext = cipher.encrypt(&nonce, new_sops_plaintext.as_bytes())
        .expect("Error generating ciphertext");

    // Generate ciphertext file.
    {
        let mut f = std::fs::File::create(get_ciphertext_filename()?)?;
        f.write_all(&ciphertext)?;
    }

    // Generate nonce file.
    {
        let mut f = std::fs::File::create(get_nonce_filename()?)?;
        f.write_all(&nonce)?;
    }

    Ok(None)
}
