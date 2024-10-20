use std::process::Command;

pub enum Output {
    Sway,
}

impl std::str::FromStr for Output {
    type Err = anyhow::Error;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "sway" => Ok(Output::Sway),
            _ => Err(anyhow::anyhow!(format!("Unrecognized build option: {s}"))),
        }
    }
}

impl std::string::ToString for Output {
    fn to_string(&self) -> String {
        match &self {
            Output::Sway => "sway".into(),
        }
    }
}

pub enum BuildOption {
    Boot,
    Switch,
    Test,
}

impl std::str::FromStr for BuildOption {
    type Err = anyhow::Error;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "boot" => Ok(BuildOption::Boot),
            "test" => Ok(BuildOption::Test),
            "switch" => Ok(BuildOption::Switch),
            _ => Err(anyhow::anyhow!(format!("Unrecognized build option: {s}"))),
        }
    }
}

pub fn build(flake_output: Output, option: BuildOption) -> anyhow::Result<()> {
    let subcommand = match option {
        BuildOption::Boot => "boot",
        BuildOption::Test => "test",
        BuildOption::Switch => "switch",
    };
    let command = format!(
        "sudo nixos-rebuild {subcommand} --upgrade --flake .#{output}",
        subcommand = subcommand,
        output = flake_output.to_string(),
    );

    println!("Running: {}", command);
    let output = Command::new("sh").arg("-c").arg(command).output().unwrap();
    if output.status.success() {
        println!("{}", std::str::from_utf8(&output.stdout).unwrap());
    } else {
        eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
        return Err(anyhow::anyhow!(format!(
            "Error building {} output",
            flake_output.to_string(),
        )));
    }

    Ok(())
}
