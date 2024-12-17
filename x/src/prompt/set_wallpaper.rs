use crate::prompt::Prompt;

pub fn f() -> anyhow::Result<Option<Prompt>> {
    const ELDEN_RING: &str = "Elden Ring";
    const SKYRIM: &str = "Skyrim";
    const MUSASHI: &str = "Musashi Miyamoto";
    const NIXOS_HONEYCOMBS: &str = "NixOS Honeycombs";

    let wallpaper_dir = {
        let dir = std::env::current_dir()?.join("wallpapers");
        std::fs::canonicalize(dir)?
    };

    let wallpaper_file = match inquire::Select::new("Choose a wallpaper:", vec![
        ELDEN_RING,
        SKYRIM,
        MUSASHI,
        NIXOS_HONEYCOMBS,
    ])
        .with_vim_mode(true)
        .prompt()?
    {
        ELDEN_RING => std::path::Path::new(&wallpaper_dir).join("elden_ring.png"),
        SKYRIM => std::path::Path::new(&wallpaper_dir).join("skyrim.jpg"),
        MUSASHI => std::path::Path::new(&wallpaper_dir).join("miyamoto-musashi.png"),
        NIXOS_HONEYCOMBS => std::path::Path::new(&wallpaper_dir).join("nixos_honeycombs.png"),
        _ => unreachable!(),
    };

    // Copy wallpaper.
    {
        let dest = home::home_dir().unwrap().join(".wallpaper");
        let output = std::process::Command::new("cp")
            .args([
                wallpaper_file.to_str().unwrap(),
                dest.to_str().unwrap(),
            ])
            .output()?;

        if output.status.success() {
            println!("{}", std::str::from_utf8(&output.stdout).unwrap());
            println!(
                "Copied `{wallpaper}` to `{dest}`.",
                wallpaper = wallpaper_file.to_str().unwrap(),
                dest = dest.to_str().unwrap(),
            );
        } else {
            eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
            return Err(anyhow::anyhow!("Error copying wallpaper"))
        }
    }

    // Reload configuration.
    {
        let output = std::process::Command::new("swaymsg")
            .args(["reload"])
            .output()?;
        if output.status.success() {
            println!("{}", std::str::from_utf8(&output.stdout).unwrap());
            println!("Reloaded sway configuration.");
        } else {
            eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
            return Err(anyhow::anyhow!("Error copying wallpaper"))
        }
    }

    Ok(None)
}
