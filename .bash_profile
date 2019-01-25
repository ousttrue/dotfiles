#
# ~/.bash_profile
#

export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export EDITOR=vim
export PATH=$HOME/local/bin:/usr/local/bin:/usr/bin:/bin

export DISPLAY=localhost:0
xrdb -merge ~/.Xresources
export DefaultImModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

[[ $- != *i* ]] && return

#
# term 
#
[ -f ~/.bashrc ] && . ~/.bashrc

