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
			ICON=🐐
		elif [[ $MSYSTEM == "UCRT64" ]]; then
			SYSTEM_COLOR="yellow"
			ICON=🛸
		elif [[ $MSYSTEM == "CLANG64" ]]; then
			SYSTEM_COLOR="yellow"
			ICON=🐉
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
		ICON=🚇
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

path_unshift "/opt/bin"
# custom
path_unshift "$HOME/local/bin"
# local pip
path_unshift "$HOME/.local/bin"
# golang
path_unshift "$HOME/go/bin"
path_push "/usr/lib/go-1.20/bin"
# rust
path_unshift "$HOME/.cargo/bin"

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
elif which lsd >/dev/null 2>&1; then
	alias ls='lsd'
	alias la='lsd -a'
	alias ll='lsd -al'
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

if ! [ -v MSYSTEM ] && which nvim >/dev/null 2>&1; then
	export EDITOR=nvim
	alias v='nvim'
elif which vim >/dev/null 2>&1; then
	export EDITOR=vim
	alias v='vim'
fi
alias e='emacs -nw'
alias r='cd "$(git rev-parse --show-toplevel)"'

# https://wiki.archlinux.jp/index.php/%E3%82%B3%E3%83%B3%E3%82%BD%E3%83%BC%E3%83%AB%E3%81%AE%E3%82%AB%E3%83%A9%E3%83%BC%E5%87%BA%E5%8A%9B#man
if which bat >/dev/null 2>&1; then
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
	export MANROFFOPT="-c"
elif false; then
	export MANPAGER=ov
	export PAGER=ov
else
	export LESS_TERMCAP_mb=$'\e[1;32m'
	export LESS_TERMCAP_md=$'\e[1;32m'
	export LESS_TERMCAP_me=$'\e[0m'
	export LESS_TERMCAP_se=$'\e[0m'
	export LESS_TERMCAP_so=$'\e[01;33m'
	export LESS_TERMCAP_ue=$'\e[0m'
	export LESS_TERMCAP_us=$'\e[1;4;31m'
	export MANPAGER="less -R --use-color -Dd+r -Du+b"
	export PAGER="less -R --use-color -Dd+r -Du+b"
fi

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

if [ -v MSYSTEM ]; then
	function fpkg {
		local selected=$(pacman -Sl | cut -d " " -f 2 | fzf --preview "pacman -Si {}")
		if [[ ${selected} =~ [^\s] ]]; then
			pacman -S ${selected}
		fi
	}

else
	function fpkg {
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
fi

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

function path {
	if [ "$1" = "list" ]; then
		list=(${PATH//:/ })
		for item in "${list[@]}"; do
			echo ${item}
		done
	fi
}

#
# prompt
#
# https://qiita.com/GunseiKPaseri/items/e594c8e261905e3d0281
# local DSPCOLOR="reset"

#
# ANSI COLOR
#
F_BLACK='\e[30m'
F_RED='\e[31m'
F_GREEN='\e[32m'
F_YELLOW='\e[33m'
F_BLUE='\e[34m'
F_MAGENTA='\e[35m'
F_CYAN='\e[36m'
F_WHITE='\e[37m'
F_RGB='\e[38;2;'
F_256='\e[38;5;'
F_DEFAULT='\e[39m'

B_BLACK='\e[40m'
B_RED='\e[41m'
B_GREEN='\e[42m'
B_YELLOW='\e[43m'
B_BLUE='\e[44m'
B_MAGENTA='\e[45m'
B_CYAN='\e[46m'
B_WHITE='\e[47m'
B_RGB='\e[48;2;'
B_256='\e[48;5;'
B_DEFAULT='\e[49m'

#
# decoration
#
E_BOLD='\e[0m'
E_LIGHT='\e[1m'
E_ITALIC='\e[2m'
E_UNDERLINE='\e[3m'
E_BLINK='\e[4m'
E_HIBLINK='\e[5m'
E_REVERSE='\e[6m'
E_HIDE='\e[7m'
E_STRIKE='\e[8m'
E_STRIKE='\e[9m'

C256_RED="255;0;15m"
C256_GREEN="0;145;64m"
C256_YELLOW="250;191;20m"
C256_BLUE="0;0;255m"
C256_MAGENTA="146;7;131m"
C256_CYAN="0;160;233m"
C256_GRAY="229;229;229m"
C256_WHITE="255;255;255m"
C256_BLACK="0;0;0m"

B_CURRENT='\e[49m'

BG() {
	printf '\e[48;2;'$1
	B_CURRENT='\e[38;2;'$1
}

FG() {
	printf '\e[38;2;'$1
}

PL() {
	printf " ${B_CURRENT}"
	BG $2
	printf " "
	FG $1
}

PL_END() {
	printf " "
	FG ${B_CURRENT}
	printf '\e[49m'
}

FB() {
	FG $1
	BG $2
}

GetPwd() {
	local pwdInfo=$(pwd)
	if [[ "$pwdInfo" =~ ^.*/ghq/github.com/(.*)$ ]]; then
		printf " /${BASH_REMATCH[1]}"
	elif [[ "$pwdInfo" =~ ^"$HOME"(/|$) ]]; then
		printf "🏠${pwdInfo#$HOME}"
	else
		printf "📂${pwdInfo}"
	fi
}

ColorArrow() {
	if [ "$1" = "0" ]; then
		printf "${F_CYAN}>${F_DEFAULT}"
	else
		printf "${F_RED}>${F_DEFAULT}"
	fi
}

GetBranch() {
	if [[ "$(uname -r)" == *microsoft* && "$pwdInfo" =~ ^/mnt/ ]]; then
		# Git is too slow in WSLdir
		:
	else
		git branch --show-current 2>/dev/null
	fi
}

TmuxHeader() {
	FB ${C256_WHITE} ${C256_BLACK}
	printf ${ICON}

	PL ${C256_BLACK} ${C256_GRAY}
	printf $(GetPwd)

	local branch=$(GetBranch)
	if [ ! -z ${branch} ]; then
		local git_log=$(git log --pretty="format:%cr   %s" -n 1)
		tmux selectp -T" ${branch}   ${git_log}" -t $TMUX_PANE
	else
		tmux selectp -T"🎴" -t $TMUX_PANE
	fi

	PL_END
}

Header() {
	FB ${C256_WHITE} ${C256_BLACK}
	printf ${ICON}

	PL ${C256_BLACK} ${C256_GRAY}
	printf $(GetPwd)

	local branch=$(GetBranch)
	if [ ! -z ${branch} ]; then
		PL ${C256_RED} ${C256_YELLOW}
		printf " ${branch}"

		PL ${C256_BLUE} ${C256_WHITE}
		git log --pretty=format:%s -n 1

		PL ${C256_BLUE} ${C256_YELLOW}
		printf "status"
		# git status --ignore-submodules
	fi

	PL_END
}

Prompt() {
	share_history

	if [ -v TMUX ]; then
		if [ "$1" = "0" ]; then
			PS1="$(TmuxHeader)\n\[${F_CYAN}\]>\[${F_DEFAULT}\] "
		else
			PS1="$(TmuxHeader)\n\[${F_RED}\]>\[${F_DEFAULT}\] "
		fi
	else
		if [ "$1" = "0" ]; then
			PS1="$(Header)\n\[${F_CYAN}\]>\[${F_DEFAULT}\] "
		else
			PS1="$(Header)\n\[${F_RED}\]>\[${F_DEFAULT}\] "
		fi
	fi
}

PROMPT_COMMAND='Prompt $?'
