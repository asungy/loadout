#!/usr/bin/env bash

# This script copies the contents of the `nvim/` directory to `$HOME/.config/nvim`.

# Error if a variable is referenced before being set.
set -u
# Exit if a command errors.
set -e

# Color settings
Bold='\033[1m'
BRed='\033[1;31m'
BGreen='\033[1;32m'
NC='\033[0m' # No Color

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

main() {
    local root=`dirname $(dirname $(realpath "$0"))`
    local nvim_dir="${root}/nvim"

    ensure rm -fr "${HOME}/.config/nvim"
    info "Removed Neovim files."
    ensure cp -fr $nvim_dir "${HOME}/.config"
    info "Copied Neovim files."

    echo "Done."
}

main "$@" || exit 1
