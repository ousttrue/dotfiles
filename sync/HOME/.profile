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
if which ibus-daemon > /dev/null 2>&1; then
    export GTK_IM_MODULE=ibus
    export QT_IM_MODULE=ibus
    export XMODIFIERS=@im=ibus
    export DefaultIMModule=ibus
    ibus-daemon --daemonize --xim --replace
fi

export GLTF_SAMPLE_MODELS="$HOME/ghq/github.com/KhronosGroup/glTF-Sample-Models"
export VRM_SAMPLES="$HOME/ghq/github.com/madjin/vrm-samples"
export BVH_SAMPLES="$HOME/ghq/github.com/CreativeInquiry/BVH-Examples"
export FBX_SAMPLES="$HOME/ghq/github.com/wangii/fbx_samples"
export LUA_PATH="$HOME/lua/?.lua;$HOME/lua/?/init.lua"

#
# term
#
if [ -f ~/.cargo/env ];then
    . "$HOME/.cargo/env"
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

alias luamake=/home/ousttrue/ghq/github.com/sumneko/lua-language-server/3rd/luamake/luamake

# opam configuration
test -r ~/.opam/opam-init/init.sh && . ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
