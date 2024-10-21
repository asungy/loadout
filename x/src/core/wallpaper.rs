const WALLPAPER_FILE: &str = ".wallpaper";

pub enum Wallpaper {
    Musashi,
    Skyrim,
}

impl std::str::FromStr for Wallpaper {
    type Err = anyhow::Error;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "skyrim" => Ok(Wallpaper::Skyrim),
            "musashi" => Ok(Wallpaper::Musashi),
            _ => Err(anyhow::anyhow!(format!("Unrecognized wallpaper: {s}"))),
        }
    }
}

pub fn copy_wallpaper(
    wallpaper: Wallpaper,
    wallpaper_dir: &std::path::Path,
    dest: &std::path::Path,
) -> anyhow::Result<()> {
    let wallpaper_file = match wallpaper {
        Wallpaper::Musashi => std::path::Path::new(&wallpaper_dir).join("miyamoto-musashi.png"),
        Wallpaper::Skyrim => std::path::Path::new(&wallpaper_dir).join("skyrim.jpg"),
    };

    let output = std::process::Command::new("cp")
        .args([
            wallpaper_file.to_str().unwrap(),
            (dest.join(WALLPAPER_FILE)).to_str().unwrap(),
        ])
        .output()?;

    if output.status.success() {
        println!("{}", std::str::from_utf8(&output.stdout).unwrap());
        Ok(())
    } else {
        eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
        Err(anyhow::anyhow!("Error copying wallpaper"))
    }
}
