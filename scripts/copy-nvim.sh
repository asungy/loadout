#!/usr/bin/env bash

# This script copies the contents of the `nvim/` directory to `$HOME/.config/nvim`.

set -e

root=`dirname $(dirname $(realpath "$0"))`
nvim_dir="${root}/nvim"

rm -fr "${HOME}.config/nvim"
cp -fr $nvim_dir "${HOME}/.config"
