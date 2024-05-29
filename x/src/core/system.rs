use std::process::Command;

pub enum Output {
    I3,
    Sway,
}

fn build(flake_output: &str, test: bool) -> Result<(), anyhow::Error> {
    let subcommand = if test { "test" } else { "switch" };
    let command = format!(
        "sudo nixos-rebuild {subcommand} --upgrade --flake .#{output}",
        subcommand = subcommand,
        output = flake_output,
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
        return Err(anyhow::anyhow!(format!("Error building {} output", flake_output)));
    }

    Ok(())
}

pub fn exec(output: Output, test: bool) -> Result<(), anyhow::Error> {
    match output {
        Output::Sway => build("sway", test),
        Output::I3 => build("i3", test),
    }
}
