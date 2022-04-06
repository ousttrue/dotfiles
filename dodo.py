from doit.action import CmdAction
from doit_lib import (IS_WINDOWS, HOME_DIR, EXE, GitCloneTask, GitBuildTask,
                      GHQ_GITHUB_DIR, condition, mkdir)
from doit.tools import result_dep

CARGO_INSTALLS = {
    'ripgrep': 'rg',
    'bat': 'bat',
    'stylua': 'stylua',
    'viu': 'viu',
    'zoxide': 'zoxide',
}
if IS_WINDOWS:
    CARGO_INSTALLS['lsd'] = 'lsd'
else:
    CARGO_INSTALLS |= {'exa': 'exa', 'gitui': 'gitui', 'skim': 'sk'}


def task_cargo():
    for k, v in CARGO_INSTALLS.items():
        yield {
            'name': k,
            'actions': [f"cargo install {k}"],
            'uptodate': [True],
            'targets': [HOME_DIR / f'.cargo/bin/{v}{EXE}'],
        }


def task_go_ghq():
    return {
        'actions': ['go install github.com/x-motemen/ghq@latest'],
        'uptodate': [True],
        'targets': [HOME_DIR / f'go/bin/ghq{EXE}'],
    }


class fzf_ghq(GitCloneTask):
    user = 'junegunn'
    repository = 'fzf'
    shallow = True


def task_fzf():
    if IS_WINDOWS:
        install = 'pwsh -File %(git_dir)s\\install.ps1'
    else:
        install = '%(git_dir)s/install --all'
    return {
        'getargs': {
            'git_dir': ('fzf_ghq', 'git_dir'),
        },
        'actions': [
            install,
            f'cp %(git_dir)s/bin/fzf{EXE} %(targets)s',
        ],
        'uptodate': [result_dep('fzf_ghq')],
        'targets': [HOME_DIR / f'local/bin/fzf{EXE}']
    }


class mlterm_ghq(GitCloneTask):
    user = 'arakiken'
    repository = 'mlterm'


class mlterm(GitBuildTask):
    condition = not IS_WINDOWS
    repository = mlterm_ghq
    actions = [
        f'./configure --prefix={HOME_DIR}/local --with-gui=console',
        'make install',
    ]
    targets = [HOME_DIR / 'local/bin/mlterm-con']


class emoji_ghq(GitCloneTask):
    user = 'twitter'
    repository = 'twemoji'
    shallow = True


class emoji_mlterm(GitBuildTask):
    repository = emoji_ghq
    actions = [
        (mkdir, [HOME_DIR / '.mlterm']),
        f'ln -s %(git_dir)s/assets/72x72 {HOME_DIR}/.mlterm/emoji',
    ]
    uptodate = [True]
    targets = [HOME_DIR / '.mlterm/emoji']


def task_deno():
    if IS_WINDOWS:
        action = 'pwsh -c "iwr https://deno.land/x/install/install.ps1 -useb | iex"'
    else:
        action = 'curl -fsSL https://deno.land/x/install/install.sh | sh'
    return {
        "actions": [action],
        "uptodate": [True],
        'targets': [HOME_DIR / f'.deno/bin/deno{EXE}']
    }


def task_skk_dictionary():
    url = 'https://skk-dev.github.io/dict/SKK-JISYO.L.gz'
    dst = HOME_DIR / '.skk/SKK-JISYO.L'
    return {
        'actions': [(mkdir, [dst.parent]), f'curl {url} | gzip -dc > {dst}'],
        'uptodate': [True],
        'targets': [dst]
    }


if not IS_WINDOWS:
    HACKGEN_ZIP = HOME_DIR / 'local/src/HackGenNerd_v2.6.0.zip'

    def task_font_hackgen_downlaod():
        url = 'https://github.com/yuru7/HackGen/releases/download/v2.6.0/HackGenNerd_v2.6.0.zip'
        return {
            'uptodate': [True],
            'targets': [HACKGEN_ZIP],
            'actions': [
                'mkdir -p ~/local/src',
                f'curl {url} -L -o %(targets)s',
            ],
        }

    def task_font_hackgen():
        return {
            'file_dep': [HACKGEN_ZIP],
            'targets': [HOME_DIR / '.fonts/HackGenNerdConsole-Regular.ttf'],
            'actions': [
                'mkdir -p ~/.fonts',
                'unzip -o -p %(dependencies)s HackGenNerd_v2.6.0/HackGenNerdConsole-Regular.ttf | cat > %(targets)s',
                'fc-cache -fv',
            ],
        }

    def task_font_sarasa():
        url = 'https://github.com/laishulu/Sarasa-Mono-SC-Nerd/raw/master/sarasa-mono-sc-nerd-regular.ttf'
        return {
            'uptodate': [True],
            'targets': [HOME_DIR / '.fonts/sarasa-mono-sc-nerd-regular.ttf'],
            'actions': [
                'mkdir -p ~/.fonts',
                f'curl {url} -L -o %(targets)s',
            ]
        }


class sumneko_lua_language_server_ghq(GitCloneTask):
    user = 'sumneko'
    repository = 'lua-language-server'


if IS_WINDOWS:

    class sumneko_lua_language_server(GitBuildTask):
        repository = sumneko_lua_language_server_ghq
        actions = [
            CmdAction('cmd /C compile\\install.bat',
                      cwd='%(git_dir)s/3rd/luamake'),
            '3rd\\luamake\\luamake.exe rebuild',
        ]
        targets = [f'{GHQ_GITHUB_DIR}/sumneko/lua-language-server/bin/lua-language-server{EXE}']

else:

    class sumneko_lua_language_server(GitBuildTask):
        repository = sumneko_lua_language_server_ghq
        actions = [
            CmdAction('./compile/install.sh', cwd='%(git_dir)s/3rd/luamake'),
            './3rd/luamake/luamake rebuild',
        ]
        targets = [f'{GHQ_GITHUB_DIR}/sumneko/lua-language-server/bin/lua-language-server']
