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


def _which(cmd: str)->bool:
    for path in $PATH:
        dir = pathlib.Path(path)
        if(dir / cmd).exists():
            return True
        if(dir / (cmd+'.exe')).exists():
            return True
    return False

$PROMPT_FIELDS['os_icon'] = get_os_icon()

HOME_DIR = get_home()
sys.path.append(str((HOME_DIR / 'dotfiles').absolute()))
import xonsh_py
$PROMPT_FIELDS['customdate'] = xonsh_py._datetime

def insert_path(src):
    src = os.path.expanduser(src)
    for v in $PATH:
        if v == src:
            return
    $PATH.insert(0, str(pathlib.Path(src)))

if platform.system()=='Windows':
    import vcenv
    vc_map = vcenv.get_env()
    $VCINSTALLDIR = vc_map['VCINSTALLDIR']
    $INCLUDE = vc_map['INCLUDE']
    $LIB = vc_map['LIB']
    for p in vc_map['PATH'].split(';'):
        insert_path(p)

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
# $UPDATE_COMPLETIONS_ON_KEYPRESS = True

# lsコマンドの結果の見た目
$LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30"

$XONSH_COLOR_STYLE = 'native'
$LANG = 'ja_JP.UTF-8'

$COLOR_INPUT = True
$COLOR_RESULTS = True
$PROMPT_TOOLKIT_COLOR_DEPTH = 'DEPTH_24_BIT'

# xontrib load powerline2
# xontrib load z
xontrib load vox
#xontrib load kitty

#
# プロンプトの表記
#
# Look & Feel inspired by oh-my-fish/theme-yimmy
# http://xon.sh/tutorial.html#customizing-the-prompt

# $PROMPT = (
#     "{BOLD_BLUE}{cwd}{RESET} {gitstatus}\n"
#     "{env_name}{prompt_end} "
# )

# $PROMPT = "{RED}┌{INTENSE_GREEN}{os_icon} [ {cwd} ] {BOLD_RED}{env_name}{gitstatus}\n{RED}└{INTENSE_GREEN}{prompt_end} "
# # $RIGHT_PROMPT = "{user}{os_icon}{hostname}"
# $BOTTOM_TOOLBAR = "{customdate}"
# $XONSH_APPEND_NEWLINE = True
xontrib load powerline3 prompt_ret_code

# the foreground/background colors of the prompt-fields can be configured as below. 
# This works for custom fields as well
# The format is `<prompt-field-name>__pl_colors`. It can be a function returning `tuple[str, str]`
# or set tuples directly as below.
# 
from prompt_toolkit.styles.named_colors import NAMED_COLORS
$PROMPT_FIELDS["cwd__pl_colors"] = ("#FFFFFF", NAMED_COLORS['DarkGreen'])
$PROMPT_FIELDS["user__pl_colors"] = ("#000000", "CYAN")
$PROMPT_FIELDS["customdate__pl_colors"] = ("#FFFFFF", NAMED_COLORS['MidnightBlue'])

# choose the powerline glyph used
$POWERLINE_MODE = "up" # if not set then it will choose random
# available modes: round/down/up/flame/squares/ruiny/lego

# define the prompts using the format style and you are good to go
$PROMPT = "".join(
    [
        "{vte_new_tab_cwd}",
        "{cwd:{}}",
        "{gitstatus:  {}}",
        "{ret_code}",
        "{background_jobs}",
        '\n',
        "{full_env_name: 🐍 {}}",
        "{prompt_end}",
    ]
)
$RIGHT_PROMPT = "".join(
    (
        # "{long_cmd_duration: ⌛{}}",
        "{user: 🤖 {}}",
        "{hostname: "+get_os_icon()+"{}}",
        "{customdate:  {}}",
    )
)



DENO_DIR = HOME_DIR / '.deno'
if DENO_DIR.is_dir():
    $DENO_INSTALL=str(DENO_DIR)
    insert_path(DENO_DIR / 'bin')

if platform.system() == 'Windows':
    import vcenv
    insert_path('C:\\Python310\\Scripts') 
    # insert_path('~\\tools')
    insert_path('C:\\Program Files\\Git\\usr\\bin')
insert_path('~/local/bin')
insert_path('~/go/bin')
insert_path('~/.cargo/bin')
insert_path('~/.local/bin')

if platform.system() == 'Windows':
    aliases['ls']=['lsd.exe']
    aliases['la']=['lsd.exe', '-a']
    aliases['ll']=['lsd.exe', '-al']
else:
    xontrib load apt_tabcomplete
    if _which('exa'):
        aliases['ls']='exa --color=auto --icons'
        aliases['la']='exa --color=auto --icons -a'
        aliases['ll']='exa --color=auto --icons -al'
    else:
        aliases['ls']='ls --color=auto'
        aliases['la']='ls --color=auto -a'
        aliases['ll']='ls --color=auto -al'

aliases["st"] = "git status -sb"

def _repos():
    repository = $(ghq list -p | fzf --reverse).strip()
    if repository:
        z @(repository)
aliases['gg'] = _repos

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

# zoxide
if _which("zoxide"):
    execx($(zoxide init xonsh), 'exec', __xonsh__.ctx, filename='zoxide')

$HTTP_HOME='~/dotfiles/home.html'

