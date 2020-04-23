#
# ~/.bash_profile
#

export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export EDITOR=vim
export PATH=$HOME/local/bin:/usr/local/bin:/usr/bin:/bin

if [ -x xrdb ];then
    export DISPLAY=localhost:0
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

