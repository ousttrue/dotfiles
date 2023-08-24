# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

autoload -Uz compinit
autoload -Uz colors
autoload -Uz add-zsh-hook

compinit
# End of lines added by compinstall

umask 002
setopt EXTENDED_GLOB
setopt IGNOREEOF
setopt share_history
setopt auto_cd
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
compctl -M 'm:{a-z}={A-Z}'

export GHQ_ROOT="$HOME/ghq"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export FZF_DEFAULT_OPTS="--layout=reverse "
export SHELL=`which zsh`

export MANPAGER='less -iscrL'
# if which bat >/dev/null 2>&1; then
#     export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# else
#     export MANPAGER="less -R --use-color -Dd+r -Du+b"
# fi

path=("$HOME/local/bin" $path)
path=("$HOME/go/bin" $path)
path=("$HOME/.cargo/bin" $path)

alias grep="grep --color"
alias pstree="pstree -A"
alias v='nvim'

if which exa >/dev/null 2>&1; then
    alias ls='exa --icons'
    alias la='exa --icons -a'
    alias ll='exa --icons -a -l'
elif which lsd >/dev/null 2>&1; then
    alias ls='lsd'
    alias la='lsd -a'
    alias ll='lsd -a -l'
else
    alias ls='ls --color'
    alias la='ls --color -a'
    alias ll='ls --color -a -l'
fi

$ gg() {
  declare -r REPO_NAME="$(ghq list >/dev/null | fzf --reverse +m)"
  [[ -n "${REPO_NAME}" ]] && cd "$(ghq root)/${REPO_NAME}"
}

source ~/.zplug/init.zsh

zplug "agkozak/zsh-z"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load #--verbose

function git_prompt {
    local branch=$(git branch --show-current 2>/dev/null)
    if [ ! -z ${branch} ]; then
        echo " ${branch}"
    else
        echo "🌵"
    fi
}

typeset -A emoji
emoji[ok]=$'\U2705'
emoji[error]=$'\U274C'
emoji[git]=$'\U1F500'
emoji[git_changed]=$'\U1F37A'
emoji[git_untracked]=$'\U1F363'
emoji[git_clean]=$'\U2728'
emoji[right_arrow]=$'\U2794'

function _vcs_git_indicator () {
  typeset -A git_info
  local git_indicator git_status
  git_status=("${(f)$(git status --porcelain --branch 2> /dev/null)}")
  (( $? == 0 )) && {
    git_info[branch]="${${git_status[1]}#\#\# }"
    shift git_status
    git_info[changed]=${#git_status:#\?\?*}
    git_info[untracked]=$(( $#git_status - ${git_info[changed]} ))
    git_info[clean]=$(( $#git_status == 0 ))

    git_indicator=("${emoji[git]}  %{%F{blue}%}${git_info[branch]}%{%f%}")
    (( ${git_info[clean]}     )) && git_indicator+=("${emoji[git_clean]}")
    (( ${git_info[changed]}   )) && git_indicator+=("${emoji[git_changed]}  %{%F{yellow}%}${git_info[changed]} changed%{%f%}")
    (( ${git_info[untracked]} )) && git_indicator+=("${emoji[git_untracked]}  %{%F{red}%}${git_info[untracked]} untracked%{%f%}")
  }
  _vcs_git_indicator="${git_indicator}"
}

function prompt_precmd() {
    # Default PROMPT
    if [ -v TMUX_PANE ];then
        local git='$_vcs_git_indicator'
        tmux selectp -T "$(git_prompt)$git" -t $TMUX_PANE
        # local title_s=$'\e]0;'
        # local title_e=$'\a'
        # PROMPT="%{${title_s}%}$(git_prompt)%{${title_e}%}%F{45}>%f "
        PROMPT=" %~"$'\n'"%F{45}>%f "
    else
        PROMPT=" %~ $(git_prompt)"$'\n'"%F{45}>%f "
    fi
}

add-zsh-hook precmd prompt_precmd
add-zsh-hook precmd _vcs_git_indicator

