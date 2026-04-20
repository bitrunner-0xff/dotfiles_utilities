#!/usr/bin/env bash
# This script provisions the system.

set -euo pipefail

# Scripts
mkdir -p ~/.local/bin && ln -sfn ~/.config/dotfiles_utilities/scripts/* ~/.local/bin

# NeoVim
ln -sfn ~/.config/dotfiles_utilities/nvim ~/.config/nvim

# Vim
ln -sfn ~/.config/dotfiles_utilities/.vimrc ~/.vimrc

# Tmux
ln -sfn ~/.config/dotfiles_utilities/.tmux.conf ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Alacritty
ln -sfn ~/.config/dotfiles_utilities/.alacritty.toml ~/.alacritty.toml

# Yazi
ln -sfn ~/.config/dotfiles_utilities/yazi ~/.config/yazi

# Starship
ln -sfn ~/.config/dotfiles_utilities/starship.toml ~/.config/starship.toml

# Zsh
ln -sfn ~/.config/dotfiles_utilities/.zshrc ~/.zshrc
git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

source ~/.zshrc
