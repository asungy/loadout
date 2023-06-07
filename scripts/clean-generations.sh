#!/usr/bin/env bash

# This script removes old NixOS generations.

# Exit if a command errors.
set -e

main() {
    # Delete unreachable store paths.
    sudo nix-collect-garbage -d

    # Clean out boot
    sudo /run/current-system/bin/switch-to-configuration boot

    echo "Done."
}

main "$@" || exit 1
