use crate::core::sway_config::{self, MonitorConfig};
use std::str::FromStr;

const NAME: &str = "all";
const MONITOR_CONFIG_GROUP_ID: &str = "monitor_config";
const OUTPUT_GROUP_ID: &str = "output";

pub fn command() -> Box<dyn super::ExecCommand> {
    struct C;

    impl super::ExecCommand for C {
        fn name(&self) -> &str {
            NAME
        }

        fn command(&self) -> clap::Command {
            clap::Command::new(NAME)
                .about("Build home manager and system configurations")
                .args(vec![
                    clap::Arg::new("laptop")
                        .long("laptop")
                        .action(clap::ArgAction::SetTrue)
                        .help("Set to use laptop monitor"),
                    clap::Arg::new("external")
                        .long("external")
                        .action(clap::ArgAction::SetTrue)
                        .help("Set to use external monitor"),
                ])
                .args(vec![clap::Arg::new("sway")
                    .long("sway")
                    .help("Activate sway configuration")
                    .action(clap::ArgAction::SetTrue)])
                .group(
                    clap::ArgGroup::new(MONITOR_CONFIG_GROUP_ID)
                        .args(["laptop", "external"])
                        .required(false),
                )
                .group(
                    clap::ArgGroup::new(OUTPUT_GROUP_ID)
                        .args(vec!["sway"])
                        .required(false),
                )
        }

        fn callback(&self) -> super::CommandFn {
            Box::new(|matches: &clap::ArgMatches| -> anyhow::Result<()> {
                let monitor_config = MonitorConfig::from_str(
                    matches
                        .get_one::<clap::Id>("monitor_config")
                        .unwrap_or(&clap::Id::from(""))
                        .as_str(),
                )
                .ok();

                match monitor_config {
                    Some(config) => sway_config::set_monitor(config)?,
                    _ => {}
                }

                crate::core::home::exec()?;

                let output = match crate::core::system::Output::from_str(
                    matches
                        .get_one::<clap::Id>(OUTPUT_GROUP_ID)
                        .unwrap_or(&clap::Id::from(""))
                        .as_str(),
                ) {
                    Ok(output) => output,
                    Err(_) => crate::core::system::Output::Sway,
                };

                crate::core::system::build(output, crate::core::system::BuildOption::Switch)?;

                Ok(())
            })
        }
    }

    Box::new(C {})
}
