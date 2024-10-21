const NAME: &str = "hardware";

pub fn command() -> Box<dyn crate::cli::ExecCommand> {
    struct C;

    impl crate::cli::ExecCommand for C {
        fn name(&self) -> &str {
            NAME
        }

        fn command(&self) -> clap::Command {
            clap::Command::new(NAME).about("Copy hardware configuration files")
        }

        fn callback(&self) -> crate::cli::CommandFn {
            Box::new(|_: &clap::ArgMatches| -> anyhow::Result<()> {
                crate::core::hardware::generate_hardware_file()
            })
        }
    }

    Box::new(C {})
}
