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
            .short('t')
            .long("test")
            .action(ArgAction::SetTrue)
            .help("Test build")
        )
        .arg(Arg::new("i3")
            .short('i')
            .long("i3")
            .action(ArgAction::SetTrue)
            .help("Build i3 output")
        )
        .arg(Arg::new("sway")
            .short('s')
            .long("sway")
            .action(ArgAction::SetTrue)
            .help("Build Sway output")
        )
        .group(ArgGroup::new("outputs")
            .args(["sway", "i3"])
            .required(true)
        )
}

pub fn exec(matches: &ArgMatches) -> CliResult {
    if !matches.contains_id("outputs") {
        return Err(anyhow::anyhow!("No outputs provided").into());
    }

    let test = *matches.get_one::<bool>("test").unwrap();

    match matches.get_one::<clap::Id>("outputs").unwrap().as_str() {
        "i3"   => system::exec(system::Output::I3, test)?,
        "sway" => system::exec(system::Output::Sway, test)?,
        _ => unreachable!("Unexpected flag in arg group."),
    };

    Ok(())
}
