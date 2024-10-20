use std::process::Command;

pub fn exec() -> anyhow::Result<()> {
    let output = Command::new("sh")
        .arg("-c")
        .arg("sudo nix build .#homeConfigurations.asungy.activationPackage")
        .output()
        .unwrap();
    if output.status.success() {
        println!("{}", std::str::from_utf8(&output.stdout).unwrap());
    } else {
        eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
        return Err(anyhow::anyhow!("Error building home manager."));
    }

    let output = Command::new("sh")
        .arg("-c")
        .arg("result/activate")
        .output()
        .unwrap();
    if output.status.success() {
        println!("{}", std::str::from_utf8(&output.stdout).unwrap());
        println!("Home manager successfully activated.");
    } else {
        eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
        return Err(anyhow::anyhow!("Error activating home manager."));
    }

    Ok(())
}
