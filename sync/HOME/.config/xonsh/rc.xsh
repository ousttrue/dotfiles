#
# @2019 [xonsh 始めました + xonshrc 弄って oh-my-fish/yimmy inspired な見た目にする](https://blog.atusy.net/2019/04/14/xonsh-debut/)
#
import subprocess
import pathlib
import sys
import os
import platform

def get_home()->pathlib.Path:
    home = os.environ.get('HOME')
    if home:
        return pathlib.Path(home)
    return pathlib.Path(os.environ['USERPROFILE'])

def get_os_icon():
    import nerdfonts as nf
    if platform.system()=='Windows':
        return nf.icons['fa_windows'] + ' '
    else:
        return nf.icons['fa_linux'] + ' '

def which(cmd: str)->bool:
    return subprocess.run(f'which {cmd}', shell=True).returncode == 0

$PROMPT_FIELDS['os_icon'] = get_os_icon()

HOME_DIR = get_home()
sys.path.append(str((HOME_DIR / 'dotfiles').absolute()))
import xonsh_py
$PROMPT_FIELDS['custom_date'] = xonsh_py._datetime

# エディタ
#$EDITOR = '/usr/local/bin/vim'
#$VISUAL = '/usr/local/bin/vim'
# vi風の操作がシェル上で直感的でないのでFalse
$VI_MODE = False
# 補完をEnterで直接実行しない
$COMPLETIONS_CONFIRM = False
# Ctrl + D で終了しない
$IGNOREEOF = True
# tabではなく空白4つ
$INDENT = "    "
# 補完時に大小区別しない
$CASE_SENSITIVE_COMPLETIONS = False
# 連続重複コマンドを保存しない
$HISTCONTROL = "ignoredups"
# 括弧を補完
$XONSH_AUTOPAIR = True
# ディレクトリ名を入力でcd
$AUTO_CD = True
# エラー全て吐くように
$XONSH_SHOW_TRACEBACK = True
# サブプロセスタイムアウトのメッセージ抑制
$SUPPRESS_BRANCH_TIMEOUT_MESSAGE = True
# キー入力即評価（サイコー）
$UPDATE_COMPLETIONS_ON_KEYPRESS = True

# lsコマンドの結果の見た目
$LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30"

$XONSH_COLOR_STYLE = 'native'
$LANG = 'ja_JP.UTF-8'

$COLOR_INPUT = True
$COLOR_RESULTS = True

# xontrib load powerline2
# xontrib load apt_tabcomplete
# xontrib load z

#
# プロンプトの表記
#
# Look & Feel inspired by oh-my-fish/theme-yimmy
# http://xon.sh/tutorial.html#customizing-the-prompt

# $PROMPT = (
#     "{BOLD_BLUE}{cwd}{RESET} {gitstatus}\n"
#     "{env_name}{prompt_end} "
# )

$PROMPT = "{RED}┌{INTENSE_GREEN}{os_icon} [ {cwd} ] {gitstatus}\n{RED}└{INTENSE_GREEN}{prompt_end} "
# $RIGHT_PROMPT = "{user}{os_icon}{hostname}"
$BOTTOM_TOOLBAR = "{custom_date}"
$XONSH_APPEND_NEWLINE = True

if platform.system() == 'Windows':
    $PATH.append('C:\\Python310\\Scripts')
    $PATH.append('~\\tools')
    $PATH.append('~\\go\\bin')
    $PATH.append('~\\my_nvim\\install\\bin')
    $PATH.append('C:\\Program Files\\Git\\usr\\bin')
    $PATH.append('~\\.cargo\\bin')
    aliases['ls']=['lsd.exe']
    aliases['la']=['lsd.exe', '-a']
    aliases['ll']=['lsd.exe', '-al']
else:
    $PATH.append('~/.cargo/bin')
    $PATH.append('~/.local/bin')
    $PATH.append('~/my_nvim/install/bin')
    if which('exa'):
        aliases['ls']='exa --color=auto --icons'
        aliases['la']='exa --color=auto --icons -a'
        aliases['ll']='exa --color=auto --icons -al'
    else:
        aliases['ls']='ls --color=auto'
        aliases['la']='ls --color=auto -a'
        aliases['ll']='ls --color=auto -al'

aliases["cd.dotfiles"] = "cd ~/dotfiles"
aliases["gs"] = "git status"
aliases["gl"] = "git log"

def _repos():
    repository = $(ghq list -p | peco).strip()
    if repository:
        cd @(repository)
aliases['repos'] = _repos

def _start(args, stdin=None, stdout=None, stderr=None, spec=None):
    cmd = ['cmd.exe', '/c', 'start'] + args
    subprocess.run(cmd, stdin=stdin, stdout=stdout, stderr=stderr)
aliases['start'] = _start

def _dotpush(args):
    with xonsh_py.pushdir(HOME_DIR / 'dotfiles'):
        subprocess.run(['git', 'commit', '-av'])
        subprocess.run(['git', 'push'])
aliases['dotpush'] = _dotpush

def _dotpull(args):
    with xonsh_py.pushdir(HOME_DIR / 'dotfiles'):
        subprocess.run(['git', 'pull'])
aliases['dotpull'] = _dotpull


# gc
def _gc(args, stdin=None):
    import gc
    gc.collect()
aliases['gc'] = _gc


# ライブラリの実行時import
# https://vaaaaaanquish.hatenablog.com/entry/2017/12/26/190153
# xonsh上で使うときがありそうなライブラリはlazyasdで補完時、実行時に読み込み
from xonsh.lazyasd import lazyobject
import importlib
lazy_module_dict = {
        'sys': 'sys',
        'random': 'random',
        'shutil': 'shutil',
        'pd': 'pandas',
        'np': 'numpy',
        'requests': 'requests',
        'os': 'os',
        'plt': 'matplotlib.pyplot',
        'Path': 'pathlib.Path',
        }
for k,v in lazy_module_dict.items():
    t = "@lazyobject\ndef {}():\n    return importlib.import_module('{}')".format(k, v)
    exec(t)

