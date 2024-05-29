use std::process::Command;

pub enum Output {
    Hyprland,
    I3,
    Sway,
}

fn build_sway(test: bool) -> Result <(), anyhow::Error> {
    let subcommand = if test { "test" } else { "switch" };
    let command = format!(
        "sudo nixos-rebuild {} --upgrade --flake .#sway",
        subcommand,
    );

    let output = Command::new("sh")
        .arg("-c")
        .arg(command)
        .output()
        .unwrap();
    if output.status.success() {
        println!("{}", std::str::from_utf8(&output.stdout).unwrap());
    } else {
        eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
        return Err(anyhow::anyhow!("Error building sway output."));
    }

    Ok(())
}

fn build_hyprland(test: bool) -> Result <(), anyhow::Error> {
    let subcommand = if test { "test" } else { "switch" };
    let command = format!(
        "sudo nixos-rebuild {} --upgrade --flake .#hyprland",
        subcommand,
    );

    let output = Command::new("sh")
        .arg("-c")
        .arg(command)
        .output()
        .unwrap();
    if output.status.success() {
        println!("{}", std::str::from_utf8(&output.stdout).unwrap());
    } else {
        eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
        return Err(anyhow::anyhow!("Error building hyprland output."));
    }

    Ok(())
}

fn build_i3(test: bool) -> Result <(), anyhow::Error> {
    let subcommand = if test { "test" } else { "switch" };
    let command = format!(
        "sudo nixos-rebuild {} --upgrade --flake .#i3",
        subcommand,
    );

    let output = Command::new("sh")
        .arg("-c")
        .arg(command)
        .output()
        .unwrap();
    if output.status.success() {
        println!("{}", std::str::from_utf8(&output.stdout).unwrap());
    } else {
        eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
        return Err(anyhow::anyhow!("Error building i3 output."));
    }

    Ok(())
}

pub fn exec(output: Output, test: bool) -> Result<(), anyhow::Error> {
    match output {
        Output::Hyprland => build_hyprland(test),
        Output::I3 => build_i3(test),
        Output::Sway => build_sway(test),
    }
}
