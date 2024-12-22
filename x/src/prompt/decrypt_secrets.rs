use crate::prompt::Prompt;

pub fn f() -> anyhow::Result<Option<Prompt>> {
    if !crate::core::sops::key_file_exists() {
        return Err(anyhow::anyhow!("Sops key file does not exist."));
    }
    let _ = std::fs::remove_dir_all(crate::core::sops::decrypted_secrets_dir());
    crate::core::sops::generate_secrets_files()?;
    println!("Generated secrets files.");
    Ok(None)
}
