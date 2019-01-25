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
if [ `which nvim 2>/dev/null` != "" ]; then
    alias vi='nvim'
    alias vim='nvim'
    export EDITOR='nvim'
fi

#
# git
#
if [ -f ~/.git-completion.bash ];then
    if [ -f !/.git-prompt.sh ];then
        source ~/.git-completion.bash
        source ~/.git-prompt.sh
        GIT_PS1_SHOWDIRTYSTATE=1
        GIT_PS1_SHOWUPSTREAM=1
        GIT_PS1_SHOWUNTRACKEDFILES=
        GIT_PS1_SHOWSTASHSTATE=1
    fi
fi

#
# nvm
#
#if [ -d $HOME/.nvim ];then
#    export NVM_DIR="$HOME/.nvm"
#    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#fi

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

# \u ユーザ名
# \h ホスト名
# \W カレントディレクトリ
# \w カレントディレクトリのパス
# \n 改行
# \d 日付
# \[ 表示させない文字列の開始
# \] 表示させない文字列の終了
# \$ $
#if [ -f ~/.git-completion.bash ];then
#if [ -f ~/.bash-git-prompt/gitprompt.sh ];then
#    export PS1='\[\033[1;32m\]\u\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$ '
#    GIT_PROMPT_ONLY_IN_REPO=1
#    source ~/.bash-git-prompt/gitprompt.sh
##else
    export PS1='[\u:\W]\$ '
#fi
export PS1='[\u:\W]\$ '


if [ -d $HOME/.cargo/bin ];then
    export PATH=$HOME/.cargo/bin:$PATH
fi

if [ -d $HOME/.pyenv ];then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

if `which xrdb > /dev/null 2>&1`; then
    export DISPLAY=localhost:0
    xrdb ~/.Xresources
fi

