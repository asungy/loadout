use std::process::Command;

pub enum Output {
    I3,
    Sway,
}

pub enum BuildOption {
    Boot,
    Switch,
    Test,
}

fn build(flake_output: &str, option: BuildOption) -> Result<(), anyhow::Error> {
    let subcommand = match option {
        BuildOption::Boot => "boot",
        BuildOption::Test => "test",
        BuildOption::Switch => "switch"
    };
    let command = format!(
        "sudo nixos-rebuild {subcommand} --upgrade --flake .#{output}",
        subcommand = subcommand,
        output = flake_output,
    );

    println!("Running: {}", command);
    let output = Command::new("sh")
        .arg("-c")
        .arg(command)
        .output()
        .unwrap();
    if output.status.success() {
        println!("{}", std::str::from_utf8(&output.stdout).unwrap());
    } else {
        eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
        return Err(anyhow::anyhow!(format!("Error building {} output", flake_output)));
    }

    Ok(())
}

pub fn exec(output: Output, option: BuildOption) -> Result<(), anyhow::Error> {
    match output {
        Output::Sway => build("sway", option),
        Output::I3 => build("i3", option),
    }
}
