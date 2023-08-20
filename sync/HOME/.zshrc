# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

autoload -Uz compinit
compinit
# End of lines added by compinstall

umask 002
setopt EXTENDED_GLOB
setopt IGNOREEOF
setopt share_history
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
compctl -M 'm:{a-z}={A-Z}'

export GHQ_ROOT="$HOME/ghq"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

path=("$HOME/local/bin" $path)
path=("$HOME/go/bin" $path)
path=("$HOME/.cargo/bin" $path)

alias grep="grep --color"
alias pstree="pstree -A"
alias v='nvim'

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
zplug load --verbose

# Default PROMPT
PROMPT="%F{magenta}${MSYSTEM}%f %F{yellow}%~%f"$'\n'"%# "
