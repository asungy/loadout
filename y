#!/usr/bin/env nix-shell
#! nix-shell -i bash
#! nix-shell -p bash git llvmPackages_16.libcxxClang neovim nodejs_20 yarn

# Neovim helper build script.

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
copy() {
    local root=`dirname $(realpath "$0")`
    local nvim_dir="${root}/nvim"

    ensure rm -fr "${HOME}/.config/nvim"
    info "Removed Neovim files."
    ensure cp -fr $nvim_dir "${HOME}/.config"
    info "Copied Neovim files."

    echo "Done."
}

rebuild() {
    ensure rm -fr "${HOME}/.local/share/nvim" "${HOME}/.local/state/nvim"
    info "Cleared Neovim cache."

    nvim
}

main() {
    case $1 in
        "copy")
            copy;;
        "rebuild")
            rebuild;;
        *)
            echo 'Expected "copy", "rebuild".'
    esac
}

main "$@" || exit 1
