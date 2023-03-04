#
# ~/.bashrc
#

# https://qiita.com/s_h_i_g_e_chan/items/e31920a767589359ea4c
path_unshift() {
    [ ! -d $1 ] || [ -z "${PATH##*$1*}" ] || export PATH=$1:$PATH
}
path_push() {
    [ ! -d $1 ] || [ -z "${PATH##*$1*}" ] || export PATH=$PATH:$1
}

path_unshift "$HOME/prefix/bin"
path_unshift "$HOME/zig"
path_unshift "/usr/local/go/bin"
path_push "$HOME/.deno/bin"
path_unshift "$HOME/.local/bin"
path_unshift "$HOME/local/bin"
path_unshift "$HOME/go/bin"
path_unshift "$HOME/cargo/bin"
path_unshift "$HOME/local/src/zig"
if [ -v MSYSTEM ]; then
    # msys
    path_push "/c/Python310/Scripts"
fi

UNAME_OS=`uname -o`
if [ "$UNAME_OS" = "GNU/Linux" ]; then
    export LD_LIBRARY_PATH=$HOME/prefix/lib64
    export PKG_CONFIG_PATH=$HOME/prefix/lib64/pkgconfig:$HOME/prefix/share/pkgconfig
    export PYTHONPATH=$HOME/prefix/lib/python3.10/site-packages
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export _BASHRC_=1

# # https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
# if [ -f "$HOME/.git-prompt.sh" ]; then
#     source ~/.git-prompt.sh
#     GIT_PS1_SHOWDIRTYSTATE=1
#     GIT_PS1_SHOWUPSTREAM=1
#     GIT_PS1_SHOWUNTRACKEDFILES=
#     GIT_PS1_SHOWSTASHSTATE=1
#     # export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
#     export PS1='\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$${MSYSTEM} '
# fi

#
# bash
#
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=9999

function _update_ps1() {
    # PS1=$(powerline-shell $?)
    PS1="$(powerline-shell $?)\n$ "
}

if which powerline-shell > /dev/null 2>&1; then
    if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
fi

#
# x11
#
# if [ `which xrdb > /dev/null` ]; then
#     export DISPLAY=localhost:0
#     xrdb ~/.Xresources
# fi
#if which setxkbmap > /dev/null 2>&1; then
#    setxkbmap -layout us
#fi

#
# rust
#
if [ -d ~/.cargo ]; then
    if [ -f ~/.cargo/env ];then
        . "$HOME/.cargo/env"
    fi
fi

#
# pyenv
#
# if [ -d $HOME/.pyenv ]; then
#     export PYENV_ROOT="$HOME/.pyenv"
#     export PATH="$PYENV_ROOT/bin:$PATH"
#     eval "$(pyenv init -)"
#     eval "$(pyenv init --path)"
# fi

# function repos {
#   cd "$( ghq list --full-path | peco)"
# }
if which zoxide > /dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

function gg {
    local arg=""
    if [ $# -gt 0 ]; then
        arg="-q $*"
    fi
    local selected=$(ghq list -p | fzf-tmux ${arg} --reverse +m)
    if [[ ${selected} =~ [^\s] ]]; then
        z ${selected}
    fi
}

function gs {
    local selected=$(git branch | fzf)
    if [[ ${selected} =~ [^\s] ]]; then
        git switch ${selected}
    fi
}

function femg {
    pushd /var/db/repos/gentoo
    local selected=$(find * -mindepth 1 -maxdepth 1 -type d | fzf --preview "emerge --pretend {}")
    popd
    if [[ ${selected} =~ [^\s] ]]; then
        sudo emerge -av --autounmask=y --autounmask-license=y --autounmask-write=y ${selected}
    fi
}

function fapt {
    local selected=$(apt list|cut -d "/" -f 1| fzf --preview "apt-cache show {}")
    if [[ ${selected} =~ [^\s] ]]; then
        sudo apt install ${selected}
    fi
}
function fapu {
    local selected=$(apt-cache pkgnames| fzf --preview "apt-cache show {}")
    if [[ ${selected} =~ [^\s] ]]; then
        sudo apt uninstall ${selected}
    fi
}

function pkg {
    local selected=$(pkg-config --list-package-names | fzf --preview "bat ${HOME}/prefix/lib64/pkgconfig/{}.pc")
    if [[ ${selected} =~ [^\s] ]]; then
        bat $HOME/prefix/lib64/pkgconifg/${selected}.pc
    fi
}

function mewrap {
    local selected=$(meson wrap list| fzf --preview "meson wrap info{}")
    if [[ ${selected} =~ [^\s] ]]; then
        meson wrap install $selected
    fi
}

function dotpull {
    pushd $HOME/dotfiles
    git pull
    popd
}

#
# alias
#
if which exa > /dev/null 2>&1; then
    alias ls='exa --color=auto --icons'
    alias la='exa --color=auto --icons -a'
    alias ll='exa --color=auto --icons -al'
elif [ "$UNAME_OS" = "FreeBSD" ]; then
    alias ls='ls --color'
    alias la='ls --color -a'
    alias ll='ls --color -al'
else
    alias ls='ls -I "NTUSER.DAT*" --color=auto'
    alias la='ls -I "NTUSER.DAT*" --color=auto -a'
    alias ll='ls -I "NTUSER.DAT*" --color=auto -al'
fi
alias glg='git lga'
alias gcd='cd $(git rev-parse --show-toplevel)'
alias groot='cd $(git rev-parse --show-toplevel)'
alias gst="git status -sb"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

alias luamake=/home/ousttrue/ghq/github.com/sumneko/lua-language-server/3rd/luamake/luamake

alias eau='emerge -av --autounmask=y --autounmask-write=y'

if which vim > /dev/null 2>&1; then
    export EDITOR=vim
fi
if which nvim > /dev/null 2>&1; then
    export EDITOR=nvim
fi

export HTTP_HOME='~/dotfiles/home.html'
export XDG_MUSIC_DIR=$HOME/Music

# source C:\Users\ousttrue\AppData\Roaming\dystroy\broot\config\launcher\bash\br
# source /home/ousttrue/.config/broot/launcher/bash/br

# export JAVA_HOME=/usr/lib/jvm/java-18-openjdk
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export ANDROID_HOME=/opt/android-sdk
path_push "$ANDROID_HOME/tools"
path_push "$ANDROID_HOME/platform-tools"
# export ANDROID_NDK_HOME=/opt/android-ndk-r10d
# path_push $ANDROID_NDK_HOME

# source /home/ousttrue/.config/broot/launcher/bash/br

export PATH=$(printf %s "$PATH" | awk -v RS=: -v ORS=: '!arr[$0]++')

fix_wsl2_interop() {
    for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
        if [[ -e "/run/WSL/${i}_interop" ]]; then
            export WSL_INTEROP=/run/WSL/${i}_interop
        fi
    done
}
