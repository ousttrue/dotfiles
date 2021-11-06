#
# ~/.bash_profile
#
umask 022
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export EDITOR=vim
PATH=$HOME/local/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin

#
# go lang
#
if [ -d $HOME/local/go ];then
    PATH=$PATH:$HOME/local/go/bin
fi
if [ -d $HOME/go ];then
    export GOPATH=$HOME/go
elif [ -d $HOME/.go ];then
    export GOPATH=$HOME/.go
fi
PATH=$PATH:$GOPATH/bin
export PATH

[[ $- != *i* ]] && return

#
# term
#
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

