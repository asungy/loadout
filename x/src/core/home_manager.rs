use std::process::Stdio;

pub fn build() -> anyhow::Result<()> {
    let status = std::process::Command::new("sudo")
        .args(["nix", "build", ".#homeConfigurations.asungy.activationPackage"])
        .stdout(Stdio::inherit())
        .stderr(Stdio::inherit())
        .status()?;

    if !status.success() {
        return Err(anyhow::anyhow!("Error building home manager."));
    }

    let status = std::process::Command::new("sh")
        .args(["-c", "result/activate"])
        .stdout(Stdio::inherit())
        .stderr(Stdio::inherit())
        .status()?;

    if !status.success() {
        return Err(anyhow::anyhow!("Error activating home manager."));
    }

    println!("Home manager successfully activated.");
    Ok(())
}
