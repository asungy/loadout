#!/usr/bin/env nix-shell
#! nix-shell -i bash
#! nix-shell -p bash git llvmPackages_16.libcxxClang neovim

# This script rebuilds Neovim plugins.

set -e

rm -fr "${HOME}/.local/share/nvim" "${HOME}/.local/state/nvim"
nvim
