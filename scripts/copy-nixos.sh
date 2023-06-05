#!/usr/bin/env bash

# This script copies the contents of the `nixos/` directory to /etc/nixos.

root=`dirname $(dirname $(realpath "$0"))`
nixos_dir="${root}/nixos"
for file in "${nixos_dir}/*"; do
    sudo cp -fr $file /etc/nixos
done
