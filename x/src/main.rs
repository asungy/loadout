#![allow(clippy::all, missing_debug_implementations)]

use std::process::ExitCode;

fn main() -> ExitCode {
    println!("hello world");
    ExitCode::FAILURE
}
