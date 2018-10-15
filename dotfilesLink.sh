#!/bin/sh
set -x

DOTFILES=~/dotfiles

ln -sf $DOTFILES/.bash_profile ~/.bash_profile
ln -sf $DOTFILES/.bashrc ~/.bashrc
ln -sf $DOTFILES/.tmux.conf ~/.tmux.conf

mkdir -p ~/.config/nvim
ln -sf $DOTFILES/config/nvim/init.vim ~/.config/nvim/init.vim
ln -sf $DOTFILES/config/nvim/dein.toml ~/.config/nvim/dein.toml

