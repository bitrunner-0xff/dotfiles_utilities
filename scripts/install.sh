#!/usr/bin/env bash
# This script provisions the system.

set -euo pipefail

# Scripts
mkdir -p ~/.local/bin && ln -sfn ~/.config/dotfiles/scripts/* ~/.local/bin

# NeoVim
ln -sfn ~/.config/dotfiles/nvim ~/.config/nvim

# Vim
ln -sfn ~/.config/dotfiles/.vimrc ~/.vimrc

# Tmux
ln -sfn ~/.config/dotfiles/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Alacritty
ln -sfn ~/.config/dotfiles/.alacritty.toml ~/.alacritty.toml

# Yazi
ln -sfn ~/.config/dotfiles/yazi ~/.config/yazi
