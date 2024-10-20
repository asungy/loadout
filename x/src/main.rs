#![allow(clippy::all, missing_debug_implementations)]

mod cli;
mod core;

use std::process::ExitCode;

fn main() -> ExitCode {
    match cli::exec() {
        Ok(_) => ExitCode::SUCCESS,
        Err(_) => ExitCode::FAILURE,
    }
}
