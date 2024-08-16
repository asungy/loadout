use std::io::Write;

pub enum MonitorConfig {
    Laptop,
    ExternalMonitor,
}

const COMMENTED: &str = "\n# output \"eDP-1\" disable";
const UNCOMMENTED: &str = "\noutput \"eDP-1\" disable";
const SWAY_CONFIG_FILE: &str = "home/config/sway/config";

pub fn set_monitor(monitor_config: MonitorConfig) -> Result<(), std::io::Error> {
    let cwd = std::env::current_dir().unwrap();
    let mut config_path = String::new();
    config_path.push_str(cwd.to_str().unwrap());
    config_path.push('/');
    config_path.push_str(SWAY_CONFIG_FILE);

    let contents = std::fs::read_to_string(config_path.clone())?;
    let new_contents = match monitor_config {
        MonitorConfig::Laptop => contents.replace(UNCOMMENTED, COMMENTED),
        MonitorConfig::ExternalMonitor => contents.replace(COMMENTED, UNCOMMENTED),
    };

    let mut file = std::fs::OpenOptions::new()
        .write(true)
        .truncate(true)
        .open(config_path)?;

    file.write(new_contents.as_bytes())?;
    Ok(())
}

