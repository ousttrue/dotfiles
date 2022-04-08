#
# ~/.bash_profile
#
umask 022
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export EDITOR=vim

if [ -v MSYSTEM ]; then
    # msys
    test
else
    PATH=$HOME/local/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin
fi

#
# term
#
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

. "$HOME/.cargo/env"

alias luamake=/home/ousttrue/ghq/github.com/sumneko/lua-language-server/3rd/luamake/luamake
