pub fn generate_hardware_file(copy_default_config: bool) -> anyhow::Result<()> {
    let tempdir = tempfile::Builder::new()
        .prefix("nixos-generate-hardware")
        .tempdir()?;

    // Generate NixOS configuration files.
    |dir: &std::path::Path| -> anyhow::Result<()> {
        let output = std::process::Command::new("nixos-generate-config")
            .args([
                "--dir",
                dir.to_str().ok_or(anyhow::anyhow!(
                    "Could not get string reference to tempdir path"
                ))?,
            ])
            .output()?;

        if output.status.success() {
            println!("{}", std::str::from_utf8(&output.stdout).unwrap());
            Ok(())
        } else {
            eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
            Err(anyhow::anyhow!("Error occurred generating new nixos configuration files."))
        }
    }(&tempdir.path())?;

    // Copy hardware file.
    let source = tempdir.path().join("hardware-configuration.nix");
    |source: &std::path::Path| -> anyhow::Result<()> {
        let dest = std::env::current_dir()?.join("system/machine/framework/hardware-configuration.nix");
        let output = std::process::Command::new("cp")
            .args([
                source.to_str().unwrap(),
                dest.to_str().unwrap(),
            ])
            .output()?;

        if output.status.success() {
            println!("{}", std::str::from_utf8(&output.stdout).unwrap());
            Ok(())
        } else {
            eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
            Err(anyhow::anyhow!("Error copying hardware configuration file."))
        }
    }(&source)?;

    if copy_default_config {
        let source = tempdir.path().join("configuration.nix");
        |source: &std::path::Path| -> anyhow::Result<()> {
            let dest = std::env::current_dir()?.join("system/machine/framework/default.nix");
            let output = std::process::Command::new("cp")
                .args([
                    source.to_str().unwrap(),
                    dest.to_str().unwrap(),
                ])
                .output()?;

            if output.status.success() {
                println!("{}", std::str::from_utf8(&output.stdout).unwrap());
                Ok(())
            } else {
                eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
                Err(anyhow::anyhow!("Error copying NixOS configuration file."))
            }
        }(&source)?;
    }

    Ok(())
}
