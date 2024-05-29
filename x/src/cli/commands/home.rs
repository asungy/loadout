use crate::cli::error::CliResult;
use clap::{ArgMatches, Command};

pub(super) const NAME: &str = "home";

pub fn cli() -> Command {
    Command::new(NAME)
        .about("Build home manager.")
}

pub fn exec(_args: &ArgMatches) -> CliResult {
    crate::core::home::exec().map_err(|e| e.into())
}
