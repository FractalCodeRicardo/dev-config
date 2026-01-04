#!/bin/bash

nvim_repo="nvim"
nvim_config="$HOME/.config/nvim"

wezterm_repo="wezterm"
wezterm_config="$HOME/.config/wezterm"

i3_repo="i3"
i3_config="$HOME/.i3"

hypr_repo="hyprland"
hypr_config="$HOME/.config/hypr"


wofi_repo="wofi"
wofi_config="$HOME/.config/wofi"

wofi_repo="wofi"
wofi_config="$HOME/.config/wofi"

waybar_repo="waybar"
waybar_config="$HOME/.config/waybar"

kitty_repo="kitty"
kitty_config="$HOME/.config/kitty"

zsh_file_repo="./zsh/.zshrc"
zsh_file_config="$HOME/.zshrc"

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
    replace_folder "$hypr_repo" "$hypr_config"
    replace_folder "$wofi_repo" "$wofi_config"
    replace_folder "$waybar_repo" "$waybar_config"
    replace_folder "$kitty_repo" "$kitty_config"
    cp "$zsh_file_repo" "$zsh_file_config"
fi

if [ "$1" = "repo" ]; then
    replace_folder "$nvim_config" "$nvim_repo"
    replace_folder "$wezterm_config" "$wezterm_repo"
    replace_folder "$i3_config" "$i3_repo"
    replace_folder "$hypr_config" "$hypr_repo"
    replace_folder "$wofi_config" "$wofi_repo"
    replace_folder "$waybar_config" "$waybar_repo"
    replace_folder "$kitty_config" "$kitty_repo"
    cp "$zsh_file_config" "$zsh_file_repo"
fi

echo "Ok!"
