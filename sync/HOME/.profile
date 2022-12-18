umask 022
#export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export EDITOR=vim
export _PROFILE_=1

# # fcitx5
# export INPUT_METHOD=fcitx
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
# export DefaultIMModule=fcitx
# fcitx5 --disable=wayland&

# ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export DefaultIMModule=ibus
ibus-daemon --daemonize --xim --replace

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
