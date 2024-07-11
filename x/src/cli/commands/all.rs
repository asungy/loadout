use crate::cli::error::CliResult;
use crate::core::system;
use crate::core::home;
use clap::{
    Arg,
    ArgAction,
    ArgGroup,
    ArgMatches,
    Command,
};

pub(super) const NAME: &str = "all";

pub fn cli() -> Command {
    Command::new(NAME)
        .about("Build Home Manager and NixOS system configurations.")
        .arg(Arg::new("test")
            .long("test")
            .action(ArgAction::SetTrue)
            .help("Test build")
        )
        .arg(Arg::new("boot")
            .long("boot")
            .action(ArgAction::SetTrue)
            .help("Rebuild and activate on next boot")
        )
        .arg(Arg::new("sway")
            .long("sway")
            .action(ArgAction::SetTrue)
            .help("Build Sway output")
        )
        .group(ArgGroup::new("outputs")
            .args(["sway"])
            .required(true)
        )
        .group(ArgGroup::new("build_options")
            .args(["test", "boot"])
            .required(false)
        )
}

pub fn exec(matches: &ArgMatches) -> CliResult {
    if !matches.contains_id("outputs") {
        return Err(anyhow::anyhow!("No outputs provided").into());
    }

    let build_option = match matches.get_one::<clap::Id>("build_options").unwrap().as_str() {
        "test" => system::BuildOption::Test,
        "boot" => system::BuildOption::Boot,
        _ => system::BuildOption::Switch,
    };

    match matches.get_one::<clap::Id>("outputs").unwrap().as_str() {
        "sway" => system::exec(system::Output::Sway, build_option)?,
        _ => unreachable!("Unexpected flag in arg group."),
    };

    home::exec()?;

    Ok(())
}
