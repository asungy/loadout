mod build_home_manager;
mod build_system;
mod generate_hardware;
mod set_monitor;
mod set_wallpaper;

pub fn run() -> anyhow::Result<()> {
    const A: &str = "Build home manager";
    const B: &str = "Build system";
    const C: &str = "Set wallpaper";
    const D: &str = "Set monitor";
    const E: &str = "Generate hardware config";

    match inquire::Select::new("What would you like to do?", vec![A, B, C, D, E])
        .with_vim_mode(true)
        .prompt()?
    {
        A => build_home_manager::run(),
        B => build_system::run(),
        C => set_wallpaper::run(),
        D => set_monitor::run(),
        E => generate_hardware::run(),
        _ => unreachable!(),
    }
}
