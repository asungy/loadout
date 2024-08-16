use crate::cli::error::CliResult;
use clap::{Arg, ArgMatches, ArgAction, ArgGroup, Command};
use crate::core::sway_config::{self, MonitorConfig};

pub(super) const NAME: &str = "home";

pub fn cli() -> Command {
    Command::new(NAME)
        .about("Build home manager.")
        .arg(Arg::new("laptop")
            .long("laptop")
            .action(ArgAction::SetTrue)
            .help("Set to use laptop monitor")
        )
        .arg(Arg::new("external")
            .long("external")
            .action(ArgAction::SetTrue)
            .help("Set to use external monitor")
        )
        .group(ArgGroup::new("monitor_config")
            .args(["laptop", "external"])
            .required(false)
        )
}


pub fn exec(matches: &ArgMatches) -> CliResult {
    let monitor_config = match matches.get_one::<clap::Id>("monitor_config").unwrap().as_str() {
        "laptop" => Some(MonitorConfig::Laptop),
        "external" => Some(MonitorConfig::ExternalMonitor),
        _ => None,
    };

    match monitor_config {
        Some(config) => sway_config::set_monitor(config).map_err(|err| anyhow::Error::new(err))?,
        _ => {},
    }

    crate::core::home::exec().map_err(|e| e.into())
}
