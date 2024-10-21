use std::str::FromStr;

const NAME: &str = "wallpaper";
const WALLPAPER_GROUP_ID: &str = "wallpaper";

pub fn command() -> Box<dyn crate::cli::ExecCommand> {
    struct C;

    impl crate::cli::ExecCommand for C {
        fn name(&self) -> &str {
            NAME
        }

        fn command(&self) -> clap::Command {
            clap::Command::new(NAME)
                .about("Copy wallpaper to home directory.\n\nSway configurations are set to look for wallpaper in the home directory.")
                .args(vec![
                    clap::Arg::new("musashi")
                        .long("musashi")
                        .action(clap::ArgAction::SetTrue),
                    clap::Arg::new("skyrim")
                        .long("skyrim")
                        .action(clap::ArgAction::SetTrue),
                ])
                .group(clap::ArgGroup::new(WALLPAPER_GROUP_ID).args(["musashi", "skyrim"]).required(true))
        }

        fn callback(&self) -> crate::cli::CommandFn {
            Box::new(|matches: &clap::ArgMatches| -> anyhow::Result<()> {
                let wallpaper = crate::core::wallpaper::Wallpaper::from_str(
                    matches
                        .get_one::<clap::Id>(WALLPAPER_GROUP_ID)
                        .unwrap_or(&clap::Id::from(""))
                        .as_str(),
                )?;

                let wallpaper_dir = {
                    let dir = std::env::current_dir()?.join("wallpapers");
                    std::fs::canonicalize(dir)?
                };
                crate::core::wallpaper::copy_wallpaper(
                    wallpaper,
                    &wallpaper_dir,
                    &home::home_dir().unwrap(),
                )
            })
        }
    }

    Box::new(C {})
}
