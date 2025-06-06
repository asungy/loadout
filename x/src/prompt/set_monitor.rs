use crate::prompt::Prompt;
use std::io::Write;

const COMMENTED: &str = "\n# output \"eDP-1\" disable";
const UNCOMMENTED: &str = "\noutput \"eDP-1\" disable";
const SWAY_CONFIG_FILE: &str = "home/config/sway/config";

pub fn f() -> anyhow::Result<Option<Prompt>> {
    const EXTERNAL: &str = "external monitor";
    const LAPTOP: &str = "laptop monitor";

    let config_path = std::env::current_dir()?.join(SWAY_CONFIG_FILE);
    let contents = std::fs::read_to_string(config_path.clone())?;
    println!("Note: This really only applies to laptop monitors.");
    let new_contents = match inquire::Select::new("Choose a monitor type: ", vec![LAPTOP, EXTERNAL])
        .with_vim_mode(true)
        .prompt()?
    {
        EXTERNAL => contents.replace(COMMENTED, UNCOMMENTED),
        LAPTOP => contents.replace(UNCOMMENTED, COMMENTED),
        _ => unreachable!(),
    };

    let mut file = std::fs::OpenOptions::new()
        .write(true)
        .truncate(true)
        .open(config_path)?;

    file.write(new_contents.as_bytes())?;

    match inquire::Confirm::new("Would you like to run home manager now?")
        .with_default(false)
        .prompt()
    {
        Ok(true) => crate::core::home_manager::build()?,
        Ok(false) => {}
        _ => unreachable!(),
    };

    Ok(None)
}
