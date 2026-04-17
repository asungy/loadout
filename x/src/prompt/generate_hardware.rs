use std::process::Stdio;

pub fn run() -> anyhow::Result<()> {
    const FRAMEWORK: &str = "framework";
    const SPYTOWER: &str = "spytower";
    const KVM: &str = "kvm";

    let machine = inquire::Select::new(
        "Which machine are you generating hardware config for?",
        vec![FRAMEWORK, SPYTOWER, KVM],
    )
    .with_vim_mode(true)
    .prompt()?;

    let dest_dir = std::env::current_dir()?
        .join("system/machine")
        .join(machine);

    let copy_default = inquire::Confirm::new("Also copy default configuration.nix?")
        .with_default(false)
        .prompt()?;

    generate_hardware_file(&dest_dir, copy_default)
}

fn generate_hardware_file(
    dest_dir: &std::path::Path,
    copy_default_config: bool,
) -> anyhow::Result<()> {
    let tempdir = tempfile::Builder::new()
        .prefix("nixos-generate-hardware")
        .tempdir()?;

    let status = std::process::Command::new("nixos-generate-config")
        .args([
            "--dir",
            tempdir
                .path()
                .to_str()
                .ok_or_else(|| anyhow::anyhow!("Could not get string reference to tempdir path"))?,
        ])
        .stdout(Stdio::inherit())
        .stderr(Stdio::inherit())
        .status()?;

    if !status.success() {
        return Err(anyhow::anyhow!(
            "Error occurred generating new nixos configuration files."
        ));
    }

    let hw_dest = dest_dir.join("hardware-configuration.nix");
    std::fs::copy(tempdir.path().join("hardware-configuration.nix"), &hw_dest)?;
    println!("Copied hardware file to `{}`.", hw_dest.display());

    if copy_default_config {
        let cfg_dest = dest_dir.join("default.nix");
        std::fs::copy(tempdir.path().join("configuration.nix"), &cfg_dest)?;
        println!("Copied configuration file to `{}`.", cfg_dest.display());
    }

    Ok(())
}
