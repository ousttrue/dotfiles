#
# ~/.bash_profile
#

export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export EDITOR=vim
export PATH=$HOME/local/bin:/usr/local/bin:/usr/bin:/bin

[[ $- != *i* ]] && return

#
# term 
#
[ -f ~/.bashrc ] && . ~/.bashrc

if [ -d $HOME/.cargo/bin ];then
    export PATH=$HOME/.cargo/bin:$PATH
fi

if [ -d $HOME/.pyenv ];then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

if `which xrdb 2>/dev/null`; then
    xrdb ~/.Xresources
    export DISPLAY=localhost:0
fi

