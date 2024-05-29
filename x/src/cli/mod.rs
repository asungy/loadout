mod commands;

use self::error::{CliError, CliResult};
use clap::Command;

const NAME: &str = env!("CARGO_PKG_NAME");
const VERSION: &str = env!("CARGO_PKG_VERSION");

fn cli() -> Command {
    Command::new(NAME)
        .version(VERSION)
        .subcommand_required(true)
        .subcommands(self::commands::builtin())
}

pub fn exec() -> CliResult {
    let cmd = cli()
        .try_get_matches()
        .map_err(|error| match error.print() {
            Ok(_) => CliError::NoCommand,
            Err(error) => {
                let error = anyhow::Error::new(error).context("Could not print CLI message.");

                CliError::Other { error }
            }
        })?;

    match cmd.subcommand() {
        Some((name, matches)) => {
            let f = self::commands::builtin_exec(name)
                .expect(&format!("Unrecognized subcommand: \"{}\"", name));
            f(matches)
        }
        None => {
            cli().print_long_help().map_err(|error| CliError::Other {
                error: error.into(),
            })?;

            Err(CliError::NoCommand)
        }
    }
}

pub mod error {
    use std::fmt;
    use std::process::ExitCode;

    pub type CliResult = Result<(), CliError>;

    #[derive(Debug)]
    pub enum CliError {
        NoCommand,
        Other { error: anyhow::Error },
    }

    impl CliError {
        pub fn exit_code(&self) -> ExitCode {
            match &self {
                CliError::NoCommand          => ExitCode::from(1),
                CliError::Other { error: _ } => ExitCode::from(2),
            }
        }
    }

    impl std::error::Error for CliError {}

    impl fmt::Display for CliError {
        fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
            match &self {
                CliError::NoCommand => {
                    write!(f, "No command provided.")
                }
                CliError::Other { error } => error.fmt(f),
            }
        }
    }

    impl From<anyhow::Error> for CliError {
        fn from(error: anyhow::Error) -> Self {
            CliError::Other { error }
        }
    }
}
