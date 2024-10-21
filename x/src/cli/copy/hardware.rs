const NAME: &str = "hardware";

pub fn command() -> Box<dyn crate::cli::ExecCommand> {
    struct C;

    impl crate::cli::ExecCommand for C {
        fn name(&self) -> &str {
            NAME
        }

        fn command(&self) -> clap::Command {
            clap::Command::new(NAME)
                .about("Copy hardware configuration files")
                .arg(clap::Arg::new("default-config")
                    .short('d')
                    .long("default-config")
                    .help("Additionally copy the generated default NixOS configuration")
                    .action(clap::ArgAction::SetTrue)
                )
        }

        fn callback(&self) -> crate::cli::CommandFn {
            Box::new(|matches: &clap::ArgMatches| -> anyhow::Result<()> {
                let copy_default_config: &bool = matches.get_one("default-config").expect("At least a default value to be set");
                crate::core::hardware::generate_hardware_file(*copy_default_config)
            })
        }
    }

    Box::new(C {})
}
