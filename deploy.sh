#!/bin/bash
#set -x

DOTFILES=~/dotfiles
pushd $DOTFILES

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    echo $f
    ln -sf $DOTFILES/$f ~/$f
done

