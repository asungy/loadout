use std::str::FromStr;

const NAME: &str = "system";
const BUILD_OPTION_GROUP_ID: &str = "build_option";
const OUTPUT_GROUP_ID: &str = "output";

pub fn command() -> Box<dyn super::ExecCommand> {
    struct C;

    impl super::ExecCommand for C {
        fn name(&self) -> &str {
            NAME
        }

        fn command(&self) -> clap::Command {
            clap::Command::new(NAME)
                .about("Build system configurations")
                .args(vec![
                    clap::Arg::new("test")
                        .long("test")
                        .help("Test configurations without committing them")
                        .action(clap::ArgAction::SetTrue),
                    clap::Arg::new("boot")
                        .long("boot")
                        .help("Build and activate configurations on next boot")
                        .action(clap::ArgAction::SetTrue),
                ])
                .args(vec![clap::Arg::new("sway")
                    .long("sway")
                    .help("Activate sway configuration")
                    .action(clap::ArgAction::SetTrue)])
                .group(
                    clap::ArgGroup::new(OUTPUT_GROUP_ID)
                        .args(vec!["sway"])
                        .required(false),
                )
                .group(
                    clap::ArgGroup::new(BUILD_OPTION_GROUP_ID)
                        .args(vec!["test", "boot"])
                        .required(false),
                )
        }

        fn callback(&self) -> super::CommandFn {
            Box::new(|matches: &clap::ArgMatches| -> anyhow::Result<()> {
                let output = match crate::core::system::Output::from_str(
                    matches
                        .get_one::<clap::Id>(OUTPUT_GROUP_ID)
                        .unwrap_or(&clap::Id::from(""))
                        .as_str(),
                ) {
                    Ok(output) => output,
                    Err(_) => crate::core::system::Output::Sway,
                };

                let build_option = match crate::core::system::BuildOption::from_str(
                    matches
                        .get_one::<clap::Id>(BUILD_OPTION_GROUP_ID)
                        .unwrap_or(&clap::Id::from(""))
                        .as_str(),
                ) {
                    Ok(option) => option,
                    Err(_) => crate::core::system::BuildOption::Switch,
                };

                crate::core::system::build(output, build_option)
            })
        }
    }

    Box::new(C {})
}
