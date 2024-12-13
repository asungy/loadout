mod core;
mod prompt;

use colored::Colorize;

fn main() -> anyhow::Result<()> {
    println!("{}", "NixOS configuration manager tool thing".bold());

    let mut next_prompt: Option<prompt::Prompt> = prompt::initial()?;
    while let Some(ref prompt) = next_prompt {
        next_prompt = (*prompt.next)()?;
    }

    Ok(())
}
