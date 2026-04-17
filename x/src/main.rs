mod core;
mod prompt;

use colored::Colorize;

fn main() -> anyhow::Result<()> {
    println!("{}", "NixOS configuration manager tool thing".bold());
    prompt::run()
}
