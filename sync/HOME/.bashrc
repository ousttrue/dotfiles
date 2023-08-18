#
# ~/.bashrc
#
if [ -v MSYSTEM ]; then

	XDG_DATA_HOME=$HOME/.local/share
	XDG_CONFIG_HOME=$HOME/.config
	XDG_MUSIC_DIR=$HOME//home/oustt/Music
	XDG_CACHE_HOME=$HOME/.cache
	XDG_STATE_HOME=$HOME/.local/state

	if grep -qi msys2 /etc/os-release >/dev/null 2>&1; then
		PLATFORM=$MSYSTEM
		if [[ $MSYSTEM == "MSYS" ]]; then
			SYSTEM_COLOR="black"
			ICON=🦉
		elif [[ $MSYSTEM == "MINGW64" ]]; then
			SYSTEM_COLOR="yellow"
			ICON=🐔
		else
			SYSTEM_COLOR="gray"
			ICON=🥚
		fi
	else
		SYSTEM_COLOR="white"
		PLATFORM=MSYSGIT
		ICON=🍄
	fi
else
	if grep -qi microsoft /proc/version; then
		# echo "Ubuntu on Windows"
		SYSTEM_COLOR="purple"
		PLATFORM=WSL
		ICON=🦆
	else
		SYSTEM_COLOR="blue"
		PLATFORM=LINUX
		ICON=🐧
	fi
fi

if [ -v LANG ]; then
	true
else
	export LANG="C.UTF-8"
fi

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
path_unshift "$HOME/.cargo/bin"
path_unshift "$HOME/local/src/zig"
if [ -v MSYSTEM ]; then
	# msys
	export MSYS=winsymlinks:nativestrict
	export GHQ_ROOT=$HOME/ghq
	# path_push "/c/Python310/Scripts"
	# path_push "$(cygpath $USERPROFILE)/.local/share/aquaproj-aqua/bin"
	true
else
	if which powerline-shell >/dev/null 2>&1; then
		if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
			PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
		fi
	fi
fi

UNAME_OS=$(uname -o)
if [ "$UNAME_OS" = "GNU/Linux" ]; then
	export LD_LIBRARY_PATH=$HOME/prefix/lib64
	export PKG_CONFIG_PATH=$HOME/prefix/lib64/pkgconfig:$HOME/prefix/share/pkgconfig
	export PYTHONPATH=$HOME/prefix/lib/python3.10/site-packages
fi

if which zoxide >/dev/null 2>&1; then
	eval "$(zoxide init bash)"
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# export FZF_DEFAULT_OPTS=" --color=fg+:#b1ff8f --preview-window=top:60%,border-bottom --preview 'bat --color=always {}'"

# set -euC

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
	if [ -f ~/.cargo/env ]; then
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

function gg {
	local arg=""
	if [ $# -gt 0 ]; then
		arg="-q $*"
	fi
	local selected=$(ghq list -p | fzf ${arg} --reverse +m)
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
	local selected=$(apt list | cut -d "/" -f 1 | fzf --preview "apt-cache show {}")
	if [[ ${selected} =~ [^\s] ]]; then
		sudo apt install ${selected}
	fi
}
function fapu {
	local selected=$(apt-cache pkgnames | fzf --preview "apt-cache show {}")
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
	local selected=$(meson wrap list | fzf --preview "meson wrap info{}")
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
if which exa >/dev/null 2>&1; then
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
alias gt="git status -sb"

alias luamake=/home/ousttrue/ghq/github.com/sumneko/lua-language-server/3rd/luamake/luamake

alias eau='emerge -av --autounmask=y --autounmask-write=y'
alias rf='rg --files .'

if which vim >/dev/null 2>&1; then
	export EDITOR=vim
	alias v='vim'
fi
if which nvim >/dev/null 2>&1; then
	export EDITOR=nvim
	alias v='nvim'
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

# https://qiita.com/GunseiKPaseri/items/e594c8e261905e3d0281
declare -l DSPCOLOR="reset"
COLORCHANGE() {
	if [ "$1" = "back" ]; then
		# background color
		printf "\033[4"
	else
		# charactor color
		printf "\033[3"
	fi
	case "$2" in
	"red") printf "8;2;255;0;15m" ;;
	"green") printf "8;2;0;145;64m" ;;
	"yellow") printf "8;2;250;191;20m" ;;
	"blue") printf "8;2;0;0;255m" ;;
	"purple") printf "8;2;146;7;131m" ;;
	"cyan") printf "8;2;0;160;233m" ;;
	"gray") printf "8;2;229;229;229m" ;;
	"white") printf "8;2;255;255;255m" ;;
	"black") printf "8;2;0;0;0m" ;;
	*) printf "9m" ;;
	esac
}
COLORCHANGEFROMBACK() {
	case "$1" in
	"white" | "gray")
		COLORCHANGE "chara" "black"
		;;
	*)
		COLORCHANGE "chara" "white"
		;;
	esac
}
# make bar like powershell
TOPICCHANGE() {
	# > color
	local isUsed=true
	if [ "$DSPCOLOR" = "reset" ]; then
		echo -n ""
		isUsed=false
	else
		echo -n " "
	fi
	# > background color
	COLORCHANGE "back" "$1"
	# > color

	COLORCHANGE "chara" "$DSPCOLOR"
	# >
	if "${isUsed}"; then
		echo -n ""
		COLORCHANGE "chara" "reset"
	fi
	echo -n " "
	COLORCHANGEFROMBACK "$1"
	DSPCOLOR="$1"
}

nerdPS1() {
	local userName="$1"
	# if userName yourname, use short name
	if [[ $userName == "ousttrue" ]]; then
		userName="🐔" # terminalによってはカラーフォント絵文字も使える。自分っぽいものに置き換えよう
	fi

	local hostName="$2"
	# if hostName ..
	# [TODO] Change YOUR-HOST-NAME
	if [[ $hostName == "YOUR-HOST-NAME" ]]; then
		hostName="" # \uf878 nf-mdi-monitor 一番ホストっぽかった
	fi
	local pwdInfo="$(pwd)"
	# GHQ
	[[ "$pwdInfo" =~ ^.*/ghq/github.com/(.*)$ ]] && pwdInfo="🐙/${BASH_REMATCH[1]}"
	# HOME
	[[ "$pwdInfo" =~ ^"$HOME"(/|$) ]] && pwdInfo="🏠${pwdInfo#$HOME}"

	# (optional) python venv
	if [[ -v VIRTUAL_ENV ]]; then
		local PYTHON_VER="$(python -V)"
		local PYTHON_ENVNAME="$(basename $VIRTUAL_ENV)"
		TOPICCHANGE "cyan"
		# for remove uniquename (pipenv hoge-{uniquename})
		echo -e -n "\ue235 ${PYTHON_VER#Python } ${PYTHON_ENVNAME%-*}" #  nf-fae-python 一番見やすいPythonロゴ
	fi

	# host
	# TOPICCHANGE "blue"
	# echo -n "$userName@$hostName"
	# pwd
	TOPICCHANGE $SYSTEM_COLOR
	echo -e -n $ICON
	TOPICCHANGE "green"
	echo -e -n "$pwdInfo" #  nf-custom-folder フォルダアイコン

	# (optional) git
	# [TODO] `source git-prompt.sh` (you have to download or find)
	if [[ "$(uname -r)" == *microsoft* && "$pwdInfo" =~ ^/mnt/ ]]; then
		# Git is too slow in WSLdir
		:
	else
		if git status --ignore-submodules &>/dev/null; then
			# You Use Git
			# local gitps1="$(__git_ps1)"
			# if [[ $gitps1 =~ [*+?%] ]]; then
			#   TOPICCHANGE "yellow"
			# else
			TOPICCHANGE "gray"
			# fi
			echo -e -n "\ue725" #  nf-dev-git_branch 一番見やすかったGitぽいアイコン
		fi
	fi
	TOPICCHANGE "reset" # 忘れずに

	echo
	echo "> "
}

function man {
	# https://www.geeksforgeeks.org/how-to-view-colored-man-pages-in-linux/
	LESS_TERMCAP_mb=$'\e[01;31m'
	LESS_TERMCAP_md=$'\e[01;31m' \
		LESS_TERMCAP_me=$'\e[0m' \
		LESS_TERMCAP_se=$'\e[0m' \
		LESS_TERMCAP_so=$'\e[45;93m' \
		LESS_TERMCAP_ue=$'\e[0m' \
		LESS_TERMCAP_us=$'\e[4;93m'

	command man "$@"
}

PS1='$(nerdPS1)'
