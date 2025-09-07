use crate::prompt::Prompt;

fn generate_hardware_file(
    dest_dir: &std::path::Path,
    copy_default_config: bool,
) -> anyhow::Result<()> {
    let tempdir = tempfile::Builder::new()
        .prefix("nixos-generate-hardware")
        .tempdir()?;

    // Generate NixOS configuration files.
    |dir: &std::path::Path| -> anyhow::Result<()> {
        let output = std::process::Command::new("nixos-generate-config")
            .args([
                "--dir",
                dir.to_str().ok_or(anyhow::anyhow!(
                    "Could not get string reference to tempdir path"
                ))?,
            ])
            .output()?;

        if output.status.success() {
            println!("{}", std::str::from_utf8(&output.stdout).unwrap());
            Ok(())
        } else {
            eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
            Err(anyhow::anyhow!(
                "Error occurred generating new nixos configuration files."
            ))
        }
    }(&tempdir.path())?;

    // Copy hardware file.
    let source = tempdir.path().join("hardware-configuration.nix");
    |source: &std::path::Path| -> anyhow::Result<()> {
        let dest = dest_dir.join("hardware-configuration.nix");
        let output = std::process::Command::new("cp")
            .args([source.to_str().unwrap(), dest.to_str().unwrap()])
            .output()?;

        if output.status.success() {
            println!("{}", std::str::from_utf8(&output.stdout).unwrap());
            println!("Copied hardware file to `{}`.", dest.to_str().unwrap());
            Ok(())
        } else {
            eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
            Err(anyhow::anyhow!(
                "Error copying hardware configuration file."
            ))
        }
    }(&source)?;

    if copy_default_config {
        // Copy configuration file.
        let source = tempdir.path().join("configuration.nix");
        |source: &std::path::Path| -> anyhow::Result<()> {
            let dest = dest_dir.join("default.nix");
            let output = std::process::Command::new("cp")
                .args([source.to_str().unwrap(), dest.to_str().unwrap()])
                .output()?;

            if output.status.success() {
                println!("{}", std::str::from_utf8(&output.stdout).unwrap());
                println!("Copied configuration file to `{}`.", dest.to_str().unwrap());
                Ok(())
            } else {
                eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
                Err(anyhow::anyhow!("Error copying NixOS configuration file."))
            }
        }(&source)?;
    }

    Ok(())
}

pub fn f() -> anyhow::Result<Option<Prompt>> {
    // Check key file before proceeding.
    if !crate::core::sops::key_file_exists() {
        let password = inquire::Password::new(
            "Secrets key file does not exist. Please enter the password to generate the file: ",
        )
        .with_display_toggle_enabled()
        .with_display_mode(inquire::PasswordDisplayMode::Hidden)
        .without_confirmation()
        .with_help_message("Press <Ctrl-R> to toggle display")
        .prompt()?;

        match crate::core::sops::generate_key_file(password) {
            Ok(_) => println!("Secrets key file generated."),
            Err(e) => {
                eprintln!("Could not generate secrets key file: {}", e);
                return Err(anyhow::anyhow!(e));
            }
        };
    }

    // Check secrets file before proceeding.
    if !crate::core::sops::decrypted_secrets_dir_exists() {
        assert!(crate::core::sops::key_file_exists());
        println!("Secrets directory does not exist in home directory. Generating decrypted secrets files.");
        crate::core::sops::generate_secrets_files()?;
    }

    const FRAMEWORK: &str = "framework";
    const SPYTOWER: &str = "spytower";
    const VIRTUALBOX: &str = "virtualbox";
    let flake_output = match inquire::Select::new(
        "Which machine would you like to build?",
        vec![FRAMEWORK, SPYTOWER, VIRTUALBOX],
    )
    .with_vim_mode(true)
    .prompt()?
    {
        FRAMEWORK => FRAMEWORK,
        SPYTOWER => SPYTOWER,
        VIRTUALBOX => VIRTUALBOX,
        _ => unreachable!(),
    };

    const SWITCH: &str = "switch";
    const TEST: &str = "boot";
    const BOOT: &str = "test";
    let build_option =
        match inquire::Select::new("Select a build option:", vec![SWITCH, TEST, BOOT])
            .with_vim_mode(true)
            .prompt()?
        {
            SWITCH => SWITCH,
            TEST => TEST,
            BOOT => BOOT,
            _ => unreachable!(),
        };

    let command = format!(
        "sudo nixos-rebuild {subcommand} --upgrade --flake .#{output}",
        subcommand = build_option,
        output = flake_output,
    );

    println!("Running: {}", command);
    let output = std::process::Command::new("sh")
        .arg("-c")
        .arg(command)
        .output()
        .unwrap();
    if output.status.success() {
        println!("{}", std::str::from_utf8(&output.stdout).unwrap());
    } else {
        eprintln!("{}", std::str::from_utf8(&output.stderr).unwrap());
        return Err(anyhow::anyhow!(format!(
            "Error building {} output",
            flake_output.to_string(),
        )));
    }

    Ok(None)
}
