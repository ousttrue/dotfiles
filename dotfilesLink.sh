#!/bin/sh
set -x

ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.bashrc ~/.bashrc

mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/config/nvim/dein.toml ~/.config/nvim/dein.toml

