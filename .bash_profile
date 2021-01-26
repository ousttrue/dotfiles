#
# ~/.bash_profile
#
umask 022
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export EDITOR=vim
PATH=$HOME/local/bin:/usr/local/bin:/usr/bin:/bin:/mnt/c/Windows/System32

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

if which xrdb > /dev/null;then
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
    xrdb -merge ~/.Xresources
    export DefaultImModule=fcitx
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS="@im=fcitx"
fi

[[ $- != *i* ]] && return

#
# term
#
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

