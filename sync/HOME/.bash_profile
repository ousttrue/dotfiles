#
# ~/.bash_profile
#
umask 022
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export EDITOR=vim
export HTTP_HOME=~/.w3m/bookmark.html

if [ -v MSYSTEM ]; then
    # msys
    test
else
    PATH=$HOME/local/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin
fi

if [ -d ~/.cargo ]; then
    . ~/.cargo/env
fi

#
# term
#
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

