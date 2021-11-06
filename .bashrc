#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#
# ls
#
alias ls='ls --color=auto'
alias ll='ls --color=auto -l'
alias la='ls --color=auto -a'
alias gs='git status'
alias gl='git lga'

#
# nvim
#
if `which nvim >/dev/null 2>&1`; then
    alias vi='nvim'
    alias vim='nvim'
    export EDITOR='nvim'
fi

#
# git
#
#source ~/dotfiles/git-completion.bash
#source ~/dotfiles/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWSTASHSTATE=1
#export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
#export PS1='\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

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

if [ -x  xrdb ]; then
    export DISPLAY=localhost:0
    xrdb ~/.Xresources
fi

function repos {
  cd "$( ghq list --full-path | peco)"
}

#
# rust
#
if [ -d ~/.cargo ]; then
    . "$HOME/.cargo/env"
fi

#
# go lang
#
if [ -d $HOME/local/go ];then
    PATH=$PATH:$HOME/local/go/bin
fi
if [ -d $HOME/go ];then
    export GOPATH=$HOME/go
elif [ -d $HOME/.go ];then
    export GOPATH=$HOME/.go
fi
PATH=$PATH:$GOPATH/bin
export PATH

