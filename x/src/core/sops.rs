use sha2::Digest;
use aes_gcm::{Aes256Gcm, Key, Nonce, AeadCore};
use aes_gcm::aead::{KeyInit, OsRng, Aead};
use std::io::Write;

const KEY_FILE: &str = ".config/sops/age/keys.txt";
const ENCRYPTED_SECRETS_FILE: &str = "secrets/secrets.yaml";
const DECRYPTED_SECRETS_DIR: &str = ".secrets";

fn key_file() -> std::path::PathBuf {
    home::home_dir().unwrap().join(KEY_FILE)
}

fn encrypted_secrets_file() -> std::path::PathBuf {
    std::env::current_dir().unwrap().join(ENCRYPTED_SECRETS_FILE)
}

pub fn decrypted_secrets_dir() -> std::path::PathBuf {
    home::home_dir().unwrap().join(DECRYPTED_SECRETS_DIR)
}

pub fn key_file_exists() -> bool {
    key_file().exists()
}

pub fn decrypted_secrets_dir_exists() -> bool {
    decrypted_secrets_dir().exists()
}

pub fn generate_key_file(password: String) -> anyhow::Result<()> {
    let hash = {
        let mut hasher = sha2::Sha256::new();
        hasher.update(password.into_bytes());
        hasher.finalize()
    };
    let key = Key::<Aes256Gcm>::from_slice(&hash);

    let cipher = Aes256Gcm::new(&key);
    let ciphertext = {
        std::fs::read(crate::prompt::new_sops_key::get_ciphertext_filename()?)?
    };
    let nonce = {
        std::fs::read(crate::prompt::new_sops_key::get_nonce_filename()?)?
    };

    let plaintext = cipher.decrypt(Nonce::from_slice(nonce.as_slice()), ciphertext.as_ref())
        .map_err(|_| anyhow::anyhow!("Incorrect password"))?;

    // Create secrets key file.
    {
        let dir = home::home_dir().unwrap().join(std::path::PathBuf::from(KEY_FILE).parent().unwrap());
        std::fs::create_dir_all(dir)?;

        let mut f = std::fs::File::create_new(key_file())?;
        f.write_all(&plaintext)?;
    }

    Ok(())
}

fn yq_get_value(content: &str, key: &str) -> anyhow::Result<String> {
    let yq_command = format!("echo '{}' | yq -r '{}'", content, key);
    let output = std::process::Command::new("nix-shell")
        .args([
            "-p",
            "yq",
            "--run",
            yq_command.as_str(),
        ])
        .output()
        .unwrap();
    if output.status.success() {
        Ok(std::str::from_utf8(&output.stdout).unwrap().into())
    } else {
        eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
        Err(anyhow::anyhow!("Error getting value from key: {}", key))
    }
}

pub fn generate_secrets_files() -> anyhow::Result<()> {
    let sops_command = format!("sops -d {}", encrypted_secrets_file().to_string_lossy());
    let output = std::process::Command::new("nix-shell")
        .args([
            "-p",
            "sops",
            "--run",
            sops_command.as_str(),
        ])
        .output()
        .unwrap();
    let content = if output.status.success() {
        std::str::from_utf8(&output.stdout).unwrap()
    } else {
        eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
        return Err(anyhow::anyhow!("Error decrypting sops secrets file."));
    };

    // Create decrypted secrets directory.
    let dir = decrypted_secrets_dir();
    std::fs::create_dir_all(dir)?;

    // Create protonvpn nl private key secret.
    {
        let mut f = std::fs::File::create(decrypted_secrets_dir().join("protonvpn-nl-private-key"))?;
        let private_key = yq_get_value(content, ".\"nl-free-162-private-key\"")?;
        f.write_all(private_key.as_bytes())?;
    }

    Ok(())
}
