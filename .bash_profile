#
# ~/.bash_profile
#

export LANG=ja_JP.UTF-8
export PATH=$HOME/local/bin:/usr/local/bin:/usr/bin:/bin

if [ -d $HOME/.pyenv ];then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

[ -f ~/.bashrc ] && . ~/.bashrc

