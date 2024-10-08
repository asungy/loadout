use crate::cli::error::CliResult;
use crate::core::system;
use clap::{
    Arg,
    ArgAction,
    ArgGroup,
    ArgMatches,
    Command,
};

pub(super) const NAME: &str = "system";

pub fn cli() -> Command {
    Command::new(NAME)
        .about("Build NixOS system configurations.")
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
            .required(false)
        )
        .group(ArgGroup::new("build_options")
            .args(["test", "boot"])
            .required(false)
        )
}

pub fn exec(matches: &ArgMatches) -> CliResult {
    let build_option = match matches.get_one::<clap::Id>("build_options").unwrap_or(&clap::Id::from("")).as_str() {
        "test" => system::BuildOption::Test,
        "boot" => system::BuildOption::Boot,
        _ => system::BuildOption::Switch,
    };

    match matches.get_one::<clap::Id>("outputs").unwrap_or(&clap::Id::from("")).as_str() {
        _ => system::exec(system::Output::Sway, build_option)?,
    };

    Ok(())
}
