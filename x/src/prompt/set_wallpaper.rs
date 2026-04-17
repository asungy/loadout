use std::process::Stdio;

pub fn run() -> anyhow::Result<()> {
    let wallpaper_dir =
        std::fs::canonicalize(std::env::current_dir()?.join("wallpapers"))?;

    let mut entries: Vec<std::path::PathBuf> = std::fs::read_dir(&wallpaper_dir)?
        .filter_map(|e| e.ok())
        .map(|e| e.path())
        .filter(|p| p.is_file())
        .collect();
    entries.sort();

    let names: Vec<String> = entries
        .iter()
        .filter_map(|p| p.file_name())
        .filter_map(|n| n.to_str())
        .map(|s| s.to_string())
        .collect();

    if names.is_empty() {
        return Err(anyhow::anyhow!("No wallpapers found in wallpapers/"));
    }

    let selected = inquire::Select::new("Choose a wallpaper:", names)
        .with_vim_mode(true)
        .prompt()?;

    let src = wallpaper_dir.join(&selected);
    let dest = home::home_dir()
        .ok_or_else(|| anyhow::anyhow!("Could not determine home directory"))?
        .join(".wallpaper");

    std::fs::copy(&src, &dest)?;
    println!("Copied `{}` to `{}`.", src.display(), dest.display());

    let status = std::process::Command::new("swaymsg")
        .args(["reload"])
        .stdout(Stdio::inherit())
        .stderr(Stdio::inherit())
        .status()?;

    if !status.success() {
        return Err(anyhow::anyhow!("Error reloading sway configuration"));
    }

    println!("Reloaded sway configuration.");
    Ok(())
}
