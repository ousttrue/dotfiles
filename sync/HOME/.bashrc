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

path_push "/usr/local/go/bin"
path_push "$HOME/.deno/bin"
path_unshift "$HOME/.local/bin"
path_unshift "$HOME/local/bin"
path_unshift "$HOME/go/bin"
path_unshift "$HOME/cargo/bin"
if [ -v MSYSTEM ]; then
    # msys
    path_push "/c/Python310/Scripts"
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export _BASHRC_=1

if which zoxide > /dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

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
  PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

#
# x11
#
# if [ `which xrdb > /dev/null` ]; then
#     export DISPLAY=localhost:0
#     xrdb ~/.Xresources
# fi
if which setxkbmap > /dev/null 2>&1; then
    setxkbmap -layout us
fi

#
# rust
#
if [ -d ~/.cargo ]; then
    . "$HOME/.cargo/env"
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
function gg {
    local repository
    repository=$(ghq list -p | fzf-tmux --reverse +m)
    if [ -n ${repository} ]; then
        z ${repository}
    fi
}

#
# alias
#
if which exa > /dev/null 2>&1; then
    alias ls='exa --color=auto --icons'
    alias la='exa --color=auto --icons -a'
    alias ll='exa --color=auto --icons -al'
else
    alias ls='ls -I "NTUSER.DAT*" --color=auto'
    alias la='ls -I "NTUSER.DAT*" --color=auto -a'
    alias ll='ls -I "NTUSER.DAT*" --color=auto -al'
fi
alias glg='git lga'
alias gcd='cd $(git rev-parse --show-toplevel)'
alias gst="git status -sb"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

alias luamake=/home/ousttrue/ghq/github.com/sumneko/lua-language-server/3rd/luamake/luamake

if which vim > /dev/null 2>&1; then
    export EDITOR=vim
fi
if which nvim > /dev/null 2>&1; then
    export EDITOR=nvim
fi

export HTTP_HOME='~/dotfiles/home.html'
export XDG_MUSIC_DIR=$HOME/Music

