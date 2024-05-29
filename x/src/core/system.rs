use std::process::Command;

pub enum Output {
    Sway,
}

fn build_sway(test: bool) -> Result <(), anyhow::Error> {
    let subcommand = if test { "test" } else { "switch" };
    let command = format!(
        "sudo nixos-rebuild {} --upgrade --flake .#framework",
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

pub fn exec(output: Output, test: bool) -> Result<(), anyhow::Error> {
    match output {
        Output::Sway => build_sway(test),
    }
}
