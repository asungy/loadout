mod build_system;
mod build_home_manager;
mod set_wallpaper;
mod set_monitor;

pub struct Prompt {
    pub next: Box<dyn Fn() -> anyhow::Result<Option<Prompt>>>,
}

pub fn initial() -> anyhow::Result<Option<Prompt>> {
    const A: &str = "Build home manager";
    const B: &str = "Build system";
    const C: &str = "Set wallpaper";
    const D: &str = "Set monitor";

    match inquire::Select::new("What would you like to do?", vec![A, B, C, D])
        .with_vim_mode(true)
        .prompt()?
    {
        A => Ok(Some(Prompt{
            next: Box::new(build_home_manager::f),
        })),
        B => Ok(Some(Prompt{
            next: Box::new(build_system::f)
        })),
        C => Ok(Some(Prompt{
            next: Box::new(set_wallpaper::f)
        })),
        D => Ok(Some(Prompt{
            next: Box::new(set_monitor::f)
        })),
        _ => unreachable!(),
    }
}
