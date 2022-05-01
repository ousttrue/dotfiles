umask 022
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export EDITOR=vim

if [ -v MSYSTEM ]; then
    # msys
    PATH="/c/Python310/Scripts:$PATH"
else
    PATH=$HOME/local/bin:$HOME/.local/bin:/usr/local/go/bin:/usr/local/bin:/usr/bin:/bin
fi

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
