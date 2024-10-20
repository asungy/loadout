use crate::core::sway_config::{self, MonitorConfig};
use std::str::FromStr;

const NAME: &str = "home";

pub fn command() -> Box<dyn super::ExecCommand> {
    struct C;
    impl super::ExecCommand for C {
        fn name(&self) -> &str {
            NAME
        }

        fn command(&self) -> clap::Command {
            clap::Command::new(NAME)
                .about("Build home manager")
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
                .group(
                    clap::ArgGroup::new("monitor_config")
                        .args(["laptop", "external"])
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

                crate::core::home::exec()
            })
        }
    }
    Box::new(C {})
}