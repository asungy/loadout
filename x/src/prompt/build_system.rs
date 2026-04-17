use std::process::Stdio;

pub fn run() -> anyhow::Result<()> {
    const FRAMEWORK: &str = "framework";
    const SPYTOWER: &str = "spytower";
    const KVM: &str = "kvm";
    const LABBOI: &str = "labboi";

    let machine = inquire::Select::new(
        "Which machine would you like to build?",
        vec![FRAMEWORK, SPYTOWER, KVM, LABBOI],
    )
    .with_vim_mode(true)
    .prompt()?;

    const SWITCH: &str = "switch";
    const BOOT: &str = "boot";
    const TEST: &str = "test";

    let subcommand = inquire::Select::new("Select a build option:", vec![SWITCH, BOOT, TEST])
        .with_vim_mode(true)
        .prompt()?;

    let upgrade = inquire::Confirm::new("Update flake inputs before building?")
        .with_default(false)
        .prompt()?;

    let flake_target = format!(".#{machine}");
    let mut cmd = std::process::Command::new("sudo");
    cmd.arg("nixos-rebuild")
        .arg(subcommand)
        .arg("--flake")
        .arg(&flake_target);

    if upgrade {
        cmd.arg("--upgrade");
    }

    println!(
        "Running: sudo nixos-rebuild {subcommand} --flake {flake_target}{}",
        if upgrade { " --upgrade" } else { "" }
    );

    let status = cmd
        .stdout(Stdio::inherit())
        .stderr(Stdio::inherit())
        .status()?;

    if !status.success() {
        return Err(anyhow::anyhow!("Error building {machine} output"));
    }

    Ok(())
}
