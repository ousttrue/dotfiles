#
# ~/.bash_profile
#
umask 022
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export EDITOR=vim
PATH=$HOME/local/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin

#
# term
#
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

