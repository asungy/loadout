mod hardware;
mod wallpaper;

const NAME: &str = "copy";

fn clap_command() -> clap::Command {
    clap::Command::new(NAME)
        .about("Copy files.\n\nBefore activating NixOS configurations, certain files must be placed in specific locations. Use the following subcommands to assist with this process.")
        .subcommands(
            subcommands()
                .iter()
                .map(|c| c.command()),
        )
        .subcommand_required(true)
}

fn subcommands() -> Vec<Box<dyn super::ExecCommand>> {
    vec![hardware::command(), wallpaper::command()]
}

pub fn command() -> Box<dyn super::ExecCommand> {
    struct C;

    impl super::ExecCommand for C {
        fn name(&self) -> &str {
            NAME
        }

        fn command(&self) -> clap::Command {
            clap_command()
        }

        fn callback(&self) -> super::CommandFn {
            Box::new(|matches: &clap::ArgMatches| -> anyhow::Result<()> {
                if let Some((name, arg_matches)) = matches.subcommand() {
                    subcommands()
                        .iter()
                        .find(|c| c.name() == name)
                        .unwrap()
                        .callback()(&arg_matches)
                } else {
                    clap_command().print_long_help().map_err(|e| e.into())
                }
            })
        }
    }

    Box::new(C {})
}
