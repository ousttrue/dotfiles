#!/bin/sh
set -x

DOTFILES=~/dotfiles

ln -sf $DOTFILES/.Xresources ~/
ln -sf $DOTFILES/.gitconfig ~/
ln -sf $DOTFILES/.bash_profile ~/
ln -sf $DOTFILES/.bashrc ~/
ln -sf $DOTFILES/.tmux.conf ~/
ln -sf $DOTFILES/.inputrc ~/
ln -sf $DOTFILES/.vimrc ~/

mkdir -p ~/.config/nvim
ln -sf $DOTFILES/config/nvim/init.vim ~/.config/nvim/
ln -sf $DOTFILES/config/nvim/dein.toml ~/.config/nvim/

mkdir -p ~/.config/openbox
ln -sf $DOTFILES/config/openbox/autostart ~/.config/openbox/
ln -sf $DOTFILES/config/openbox/environment ~/.config/openbox/
ln -sf $DOTFILES/config/openbox/menu.xml ~/.config/openbox/
ln -sf $DOTFILES/config/openbox/rc.xml ~/.config/openbox/

mkdir -p ~/.config/fontconfig
ln -sf $DOTFILES/config/fontconfig/fonts.conf ~/.config/fontconfig/

