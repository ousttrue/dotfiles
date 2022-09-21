umask 022
#export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export EDITOR=vim
export _PROFILE_=1

#
# term
#
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -f ~/.cargo/env ];then
    . "$HOME/.cargo/env"
fi

alias luamake=/home/ousttrue/ghq/github.com/sumneko/lua-language-server/3rd/luamake/luamake
