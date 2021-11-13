#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
if [ -f "$HOME/.git-prompt.sh" ]; then
    source ~/.git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWUPSTREAM=1
    GIT_PS1_SHOWUNTRACKEDFILES=
    GIT_PS1_SHOWSTASHSTATE=1
    # export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
    export PS1='\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$${MSYSTEM} '
fi

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

#
# x11
#
# if [ `which xrdb` ]; then
#     export DISPLAY=localhost:0
#     xrdb ~/.Xresources
# fi
if [ `which setxkbmap` ]; then
    setxkbmap -layout us
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

#
# alias
#
if [ `which exa` ]; then
    alias ls='exa --color=auto --icons'
    alias la='exa --color=auto --icons -a'
    alias ll='exa --color=auto --icons -al'
else
    alias ls='ls -I "NTUSER.DAT*" --color=auto'
    alias la='ls -I "NTUSER.DAT*" --color=auto -a'
    alias ll='ls -I "NTUSER.DAT*" --color=auto -al'
fi
alias gs='git status'
alias gl='git lga'
alias gr='cd $(git rev-parse --show-toplevel)'

