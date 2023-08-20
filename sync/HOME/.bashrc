#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export _BASHRC_=1

function share_history {
	history -a
	history -c
	history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=9999

export HTTP_HOME='~/dotfiles/home.html'
export XDG_MUSIC_DIR=$HOME/Music
if [ -v MSYSTEM ]; then

	export XDG_DATA_HOME=$HOME/.local/share
	export XDG_CONFIG_HOME=$HOME/.config
	export XDG_MUSIC_DIR=$HOME//home/oustt/Music
	export XDG_CACHE_HOME=$HOME/.cache
	export XDG_STATE_HOME=$HOME/.local/state
	export MSYS=winsymlinks:nativestrict
	export GHQ_ROOT=$HOME/ghq

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
		SYSTEM_COLOR="cyan"
		PLATFORM=LINUX
		ICON=🐧
		export LD_LIBRARY_PATH=$HOME/prefix/lib64
		export PKG_CONFIG_PATH=$HOME/prefix/lib64/pkgconfig:$HOME/prefix/share/pkgconfig
		export PYTHONPATH=$HOME/prefix/lib/python3.10/site-packages
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

if which zoxide >/dev/null 2>&1; then
	eval "$(zoxide init bash)"
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS="--layout=reverse"

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
alias gcd='cd $(git rev-parse --show-toplevel)'
alias groot='cd $(git rev-parse --show-toplevel)'
alias gt="git status -sb"

if which vim >/dev/null 2>&1; then
	export EDITOR=vim
	alias v='vim'
fi
if which nvim >/dev/null 2>&1; then
	export EDITOR=nvim
	alias v='nvim'
fi
alias e='emacs -nw'
# https://wiki.archlinux.jp/index.php/%E3%82%B3%E3%83%B3%E3%82%BD%E3%83%BC%E3%83%AB%E3%81%AE%E3%82%AB%E3%83%A9%E3%83%BC%E5%87%BA%E5%8A%9B#man
export MANPAGER="less -R --use-color -Dd+r -Du+b"

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

#
# prompt
#
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

PS1='$(nerdPS1)'
