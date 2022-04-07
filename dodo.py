import sys
from doit.action import CmdAction
from doit_lib import (IS_WINDOWS, HOME_DIR, EXE, GitCloneTask, GitBuildTask,
                      GHQ_GITHUB_DIR, condition, mkdir, traverse,
                      SYNC_HOME_DIR, DOTFILES, mklink, check_link)
if IS_WINDOWS:
    from doit_lib import (SYNC_APPDATA_LOCAL_DIR,SYNC_APPDATA_ROAMING_DIR, APPDATA_LOCAL_DIR, APPDATA_ROAMING_DIR)
from doit.tools import result_dep


def task_create_link():
    '''
    create symbol link for config files
    '''
    for src in traverse(SYNC_HOME_DIR):
        target = src.relative_to(SYNC_HOME_DIR)
        dst = HOME_DIR / target
        yield {
            'name': target,
            # 'file_dep': [src],
            'targets': [dst],
            'actions': [(mklink, [src])],
            'uptodate': [(check_link, (src, dst))],
            'verbosity': 2,
        }

    if IS_WINDOWS:
        for src in traverse(SYNC_APPDATA_ROAMING_DIR):
            target = src.relative_to(SYNC_APPDATA_ROAMING_DIR)
            dst = APPDATA_ROAMING_DIR / target
            yield {
                'name': target,
                # 'file_dep': [src],
                'targets': [dst],
                'actions': [(mklink, [src])],
                'uptodate': [(check_link, (src, dst))],
                'verbosity': 2,
            }

        for src in traverse(SYNC_APPDATA_LOCAL_DIR):
            target = src.relative_to(SYNC_APPDATA_LOCAL_DIR)
            dst = APPDATA_LOCAL_DIR / target
            yield {
                'name': target,
                # 'file_dep': [src],
                'targets': [dst],
                'actions': [(mklink, [src])],
                'uptodate': [(check_link, (src, dst))],
                'verbosity': 2,
            }


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


@condition(not IS_WINDOWS)
def task_rustup():
    return {
        'actions':
        ["curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"],
        'uptodate': ['which rustup'],
        'targets': [HOME_DIR / f'.cargo/bin/rustup{EXE}'],
    }


def task_cargo():
    for k, v in CARGO_INSTALLS.items():
        yield {
            'name': k,
            'actions': [f"cargo install {k}"],
            'file_dep': [HOME_DIR / f'.cargo/bin/rustup{EXE}'],
            'targets': [HOME_DIR / f'.cargo/bin/{v}{EXE}'],
        }


import site

if IS_WINDOWS:
    for s in site.getsitepackages():
        if 'site-packages' in s:
            SITE_PACKAGES = s
            break
else:
    SITE_PACKAGES = site.getusersitepackages()


def task_pip_api():
    return {
        'actions': [f'{sys.executable} -m pip install pip-api'],
        'uptodate': [True],
        'targets': [f'{SITE_PACKAGES}/pip_api/__init__.py'],
    }


PIP_MODULES = {
    'xonsh': 'xonsh[full]',
    'nerdfonts': 'nerdfonts',
    'autopep8': 'autopep8',
    'pipx': 'pipx',
    'pynvim': 'pynvim',
}
PIPX_MODULES = {
    'pylsp': 'python-lsp-server[all]',
    'ranger': 'ranger-fm',
}

PIP_INSTALLED = {}


def get_pip_installed():
    global PIP_INSTALLED
    if not PIP_INSTALLED:
        import pip_api
        PIP_INSTALLED = pip_api.installed_distributions()  # type: ignore
    return PIP_INSTALLED


def task_pip():
    for k, v in PIP_MODULES.items():
        yield {
            'name': k,
            'uptodate': [lambda: k in get_pip_installed()],
            'file_dep': [f'{SITE_PACKAGES}/pip_api/__init__.py'],
            'actions': [f'{sys.executable} -m pip install "{v}"'],
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


class neovim_ghq(GitCloneTask):
    user = 'neovim'
    repository = 'neovim'
    branch = 'v0.6.1'
    apts = [
        "ninja-build",
        "gettext",
        "libtool",
        "libtool-bin",
        "autoconf",
        "automake",
        "cmake",
        "g++",
        "pkg-config",
        "unzip",
        "curl",
        "doxygen",
    ]


if IS_WINDOWS:
    from cmake import CMAKE_BIN_DIR
    cmake = f'{CMAKE_BIN_DIR}\\cmake.exe'

    class neovim(GitBuildTask):
        repository = neovim_ghq
        actions = [
            f'git restore -- .',
            f'git --git-dir= apply -p1 {DOTFILES}\\neovim.patch',
            # deps
            f'{cmake} -S %(git_dir)s/third-party -B %(git_dir)s/.deps -DCMAKE_BUILD_TYPE=RelWithDebInfo',
            f'{cmake} --build %(git_dir)s/.deps --config RelWithDebInfo',
            # nvim
            f'{cmake} -S %(git_dir)s -B %(git_dir)s/build -DCMAKE_BUILD_TYPE=RelWithDebInfo',
            f'{cmake} --build %(git_dir)s/build --config RelWithDebInfo',
            # install
            f'{cmake} --install %(git_dir)s/build --config RelWithDebInfo --prefix {HOME_DIR / "local"}',
        ]
        targets = [HOME_DIR / f'local/bin/nvim{EXE}']

else:

    class neovim(GitBuildTask):
        repository = neovim_ghq
        actions = [
            'make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=~/local" -j 4',
            'make install',
        ]
        targets = [HOME_DIR / 'local/bin/nvim']


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
        targets = [
            f'{GHQ_GITHUB_DIR}/sumneko/lua-language-server/bin/lua-language-server{EXE}'
        ]

else:

    class sumneko_lua_language_server(GitBuildTask):
        repository = sumneko_lua_language_server_ghq
        actions = [
            CmdAction('./compile/install.sh', cwd='%(git_dir)s/3rd/luamake'),
            './3rd/luamake/luamake rebuild',
        ]
        targets = [
            f'{GHQ_GITHUB_DIR}/sumneko/lua-language-server/bin/lua-language-server'
        ]


if not IS_WINDOWS:

    class w3m_ghq(GitCloneTask):
        user = 'tats'
        repository = 'w3m'
        apts = [
            'libgc-dev',
            'libimlib2-dev',
        ]
        patches = ['~/dotfiles/w3m.patch']

    class w3m(GitBuildTask):
        repository = w3m_ghq
        targets = ['~/local/bin/w3m']
        actions = [
            './configure --prefix=~/local',
            'make -j 4',
            'make install',
        ]


@condition(not IS_WINDOWS)
def task_zig():
    ZIG_ARCHIVE_URL = 'https://ziglang.org/download/0.9.1/zig-linux-x86_64-0.9.1.tar.xz'
    ZIG_ARCHIVE = HOME_DIR / 'local/src/zig-linux-x86_64-0.9.1.tar.xz'
    ZIG_ARCHIVE_EXTRACT = HOME_DIR / 'local/src/zig-linux-x86_64-0.9.1'
    ZIG_BIN = HOME_DIR / 'local/bin/zig'

    def download():
        ZIG_ARCHIVE.parent.mkdir(parents=True, exist_ok=True)
        response = urllib.request.urlopen(ZIG_ARCHIVE_URL)
        data = response.read()
        ZIG_ARCHIVE.write_bytes(data)

    return {
        'actions': [
            f'mkdir -p {ZIG_ARCHIVE.parent}',
            f'curl {ZIG_ARCHIVE_URL} -o {ZIG_ARCHIVE}',
            CmdAction(f'tar xf {ZIG_ARCHIVE}', cwd=ZIG_ARCHIVE.parent),
            f'mkdir -p {ZIG_BIN.parent}',
            f'ln -s {ZIG_ARCHIVE_EXTRACT}/zig {ZIG_BIN}',
        ],
        'targets': [ZIG_BIN],
        'uptodate': [True],
    }


@condition(not IS_WINDOWS)
def task_ranger_devicon_get():
    return {
        'actions': [
            'git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons',
        ],
        'uptodate': [True],
        'targets':
        [HOME_DIR / '.config/ranger/plugins/ranger_devicons/README.md'],
    }
