#!/usr/bin/env bash

root=`dirname $(dirname $(realpath "$0"))`
nixos_dir="${root}/nixos"
for file in "${nixos_dir}/*"; do
    sudo cp -fr $file /etc/nixos
done
