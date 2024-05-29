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
            .short('t')
            .long("test")
            .action(ArgAction::SetTrue)
            .help("Test build")
        )
        .arg(Arg::new("sway")
            .short('s')
            .long("sway")
            .action(ArgAction::SetTrue)
            .help("Build Sway output")
        )
        .group(ArgGroup::new("outputs")
            .args(["sway"])
            .required(true)
        )
}

pub fn exec(matches: &ArgMatches) -> CliResult {
    if !matches.contains_id("outputs") {
        return Err(anyhow::anyhow!("No outputs provided").into());
    }

    let test = *matches.get_one::<bool>("test").unwrap();

    home::exec()?;
    match matches.get_one::<clap::Id>("outputs").unwrap().as_str() {
        "sway"     => system::exec(system::Output::Sway, test)?,
        _ => unreachable!("Unexpected flag in arg group."),
    };

    Ok(())
}