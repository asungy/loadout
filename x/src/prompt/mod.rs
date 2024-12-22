mod build_home_manager;
mod build_system;
mod set_monitor;
mod set_wallpaper;
mod decrypt_secrets;
pub mod new_sops_key;

pub struct Prompt {
    pub next: Box<dyn Fn() -> anyhow::Result<Option<Prompt>>>,
}

pub fn initial() -> anyhow::Result<Option<Prompt>> {
    const A: &str = "Build home manager";
    const B: &str = "Build system";
    const C: &str = "Set wallpaper";
    const D: &str = "Create new sops key";
    const E: &str = "Decrypt secrets to home directory";
    const F: &str = "Set monitor";

    match inquire::Select::new("What would you like to do?", vec![A, B, C, D, E, F])
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
            next: Box::new(new_sops_key::f),
        })),
        E => Ok(Some(Prompt{
            next: Box::new(decrypt_secrets::f),
        })),
        F => Ok(Some(Prompt{
            next: Box::new(set_monitor::f)
        })),
        _ => unreachable!(),
    }
}
