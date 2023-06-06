#!/usr/bin/env bash

# This script copies the contents of the `nixos/` directory to /etc/nixos.

# Error if a variable is referenced before being set.
set -u

# Color settings
Bold='\033[1m'
BRed='\033[1;31m'
BGreen='\033[1;32m'
NC='\033[0m' # No Color

# Silence stdout of command.
silent() {
    "$@" > /dev/null
}

# Silence stdout and stderr of command.
silent_all() {
    "$@" 1> /dev/null 2> /dev/null
}

# Log an error.
err() {
    printf "${BRed}Error${NC}: $1\n" >&2
    exit 1
}

# Log info.
info() {
    printf "${BGreen}Info${NC}: $1\n" >&1
}

# Run a command that should never fail. If the command fails execution
# will immediately terminate with an error showing the failing
# command.
ensure() {
    if ! "$@"; then err "command failed: $*"; fi
}

# Remove all NixOS configuration files and regenerate defaults.
reset_nix_files() {
    sudo rm -fr /etc/nixos/*
    silent_all sudo nixos-generate-config
    sudo rm -f /etc/nixos/configuration.nix

    info "Reset NixOS files."
}

copy_nix_files() {
    local root=`dirname $(dirname $(realpath "$0"))`
    local nixos_dir="${root}/nixos"

    for file in "${nixos_dir}/*"; do
        ensure sudo cp -fr $file /etc/nixos
    done

    info "Copied NixOS files."
}

main() {
    reset_nix_files

    copy_nix_files

    echo "Done."
}


main "$@" || exit 1
