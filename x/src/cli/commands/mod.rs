use crate::cli::error::CliResult;
use clap::{ArgMatches, Command};

mod all;
mod home;
mod system;

pub fn builtin() -> Vec<Command> {
    vec![
        all::cli(),
        home::cli(),
        system::cli(),
    ]
}

pub type Exec = fn(&ArgMatches) -> CliResult;

pub fn builtin_exec(cmd: &str) -> Option<Exec> {
    let f = match cmd {
        all::NAME => all::exec,
        home::NAME => home::exec,
        system::NAME => system::exec,
        _ => return None,
    };

    Some(f)
}
