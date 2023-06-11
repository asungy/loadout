#!/usr/bin/env bash

# NixOS helper build script.

# Shows the output of every command
set +x

rebuild_home() {
    nix build .#homeConfigurations.asungy.activationPackage
}

rebuild_system() {
    sudo nixos-rebuild switch --flake .#dell-g5
}

rebuild_vm() {
    sudo nixos-rebuild build-vm --flake .#dell-g5
}

main() {
    case $1 in
        "home")
            rebuild_home;;
        "system")
            rebuild_system;;
        "vm")
            rebuild_vm;;
        *)
            echo 'Expected "system", "vm".';;
    esac
}

main "$@" || exit 1
