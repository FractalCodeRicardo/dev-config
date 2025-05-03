#!/bin/bash

nvim_repo="nvim"
nvim_config="$HOME/.config/nvim"

rm -rf "$nvim_config"
mkdir -p "$nvim_config"

cp -r "$nvim_repo"/* "$nvim_config"

echo "Ok!"
