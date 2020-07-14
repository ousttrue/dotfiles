#!/bin/bash
#set -x

DOTFILES=~/dotfiles
pushd $DOTFILES

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".config" ]] && continue
    ln -sf $DOTFILES/$f ~/
done

mkdir -p $/.config/nvim
for f in .config/nvim/*
do
    ln -sf $DOTFILES/$f ~/
done

mkdir -p $/.config/openbox
for f in .config/openbox/*
do
    ln -sf $DOTFILES/$f ~/
done

mkdir -p $/.config/fontconfig
for f in .config/fontconfig/*
do
    ln -sf $DOTFILES/$f ~/
done

