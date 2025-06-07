#!/bin/bash

nvim_repo="nvim"
nvim_config="$HOME/.config/nvim"

wezterm_repo="wezterm"
wezterm_config="$HOME/.config/wezterm"

i3_repo="i3"
i3_config="$HOME/.i3"

replace_folder() {
    local source_dir="$1"
    local target_dir="$2"

    echo "Updating $target_dir"
    rm -rf "$target_dir"
    mkdir -p "$target_dir"
    cp -r "$source_dir"/* "$target_dir"
}

if [ $# -eq 0 ]; then
    echo "Usage: sh update.sh (config | repo)"
    exit 1
fi

if [ "$1" = "config" ]; then
    replace_folder "$nvim_repo" "$nvim_config"
    replace_folder "$wezterm_repo" "$wezterm_config"
    replace_folder "$i3_repo" "$i3_config"
fi

if [ "$1" = "repo" ]; then
    replace_folder "$nvim_config" "$nvim_repo"
    replace_folder "$wezterm_config" "$wezterm_repo"
    replace_folder "$i3_config" "$i3_repo"
fi

echo "Ok!"
