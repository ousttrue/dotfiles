import pathlib
import os
import doit.action

HAS_PIP_API = False
try:
    import pip_api
    HAS_PIP_API = True
    # slow
    PIP_INSTALLED = pip_api.installed_distributions()  # type: ignore
except Exception as e:
    print(e)

HERE = pathlib.Path(__file__).absolute().parent
HOME_DIR = HERE.parent
GHQ_DIR = HOME_DIR / 'ghq'
GHQ_GITHUB_DIR = GHQ_DIR / 'github.com'
SYNC_DIR = HERE / 'sync'
SYNC_HOME_DIR = SYNC_DIR / 'HOME'
SYNC_APPDATA_ROAMING_DIR = SYNC_DIR / 'APPDATA/Roaming'
SYNC_APPDATA_LOCAL_DIR = SYNC_DIR / 'APPDATA/Local'

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


def is_windows():
    import platform
    return platform.system() == 'Windows'


IS_WINDOWS = is_windows()

if IS_WINDOWS:
    HOME_DIR = pathlib.Path(os.environ['USERPROFILE'])
    APPDATA_ROAMING_DIR = pathlib.Path(os.environ['APPDATA'])
    APPDATA_LOCAL_DIR = APPDATA_ROAMING_DIR.parent / 'Local'
    PYTHON_BIN = pathlib.Path('C:/python310/python.exe')
    PYTHON_SCRIPTS = pathlib.Path('C:/python310/Scripts')
    EXE = '.exe'
    import vcenv
else:
    HOME_DIR = pathlib.Path(os.environ['HOME'])
    from linux_tasks import *
    PYTHON_BIN = pathlib.Path('/usr/local/bin/python')
    PYTHON_SCRIPTS = HOME_DIR / '.local/bin'
    EXE = ''


class NEOVIM:
    GITHUB = 'neovim/neovim'
    SOURCE = GHQ_GITHUB_DIR / 'neovim/neovim/README.md'
    BIN = HOME_DIR / f'local/bin/nvim{EXE}'
    DEP_APTS = [
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

    @classmethod
    def has_source(cls):
        return cls.SOURCE.is_dir()


def task_neovim_get():
    actions = []
    if IS_WINDOWS:
        pass
    else:
        actions.append('sudo apt-get install -y ' + ' '.join(NEOVIM.DEP_APTS))
    actions += [
        'ghq get --branch v0.6.1 neovim/neovim',
    ]
    return {
        'file_dep': [HOME_DIR / f'go/bin/ghq{EXE}'],
        'actions': actions,
        'targets': [NEOVIM.SOURCE],
    }


def mkdir(path: pathlib.Path):
    print(path)
    path.mkdir(parents=True, exist_ok=True)


if IS_WINDOWS:

    def task_neovim_build():
        deps_dir = NEOVIM.SOURCE.parent / '.deps'
        build_dir = NEOVIM.SOURCE.parent / 'build'
        from cmake import CMAKE_BIN_DIR
        cmake = f'{CMAKE_BIN_DIR}\\cmake.exe'
        return {
            'actions': [
                # deps
                (mkdir, [deps_dir]),
                doit.action.CmdAction(
                    f'{cmake} ../third-party -DCMAKE_BUILD_TYPE=RelWithDebInfo',
                    cwd=deps_dir),
                doit.action.CmdAction(
                    f'{cmake} --build . --config RelWithDebInfo',
                    cwd=deps_dir),
                # nvim
                (mkdir, [build_dir]),
                doit.action.CmdAction(
                    f'{cmake} .. -DCMAKE_BUILD_TYPE=RelWithDebInfo',
                    cwd=build_dir),
                doit.action.CmdAction(
                    f'{cmake} --build . --config RelWithDebInfo',
                    cwd=build_dir),
                # install
                doit.action.CmdAction(
                    f'{cmake} --install . --config RelWithDebInfo --prefix {HOME_DIR / "local"}',
                    cwd=build_dir),
            ],
            'targets': [NEOVIM.BIN],
            'file_dep': [NEOVIM.SOURCE],
            'verbosity':
            2,
        }

else:

    def task_neovim_build():
        return {
            'actions': [
                f'mkdir -p {NEOVIM.SOURCE.parent}',
                doit.action.CmdAction(
                    f'make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX={HOME_DIR}/local" -j 4',
                    cwd=NEOVIM.SOURCE.parent),
                doit.action.CmdAction('make install', cwd=NEOVIM.SOURCE.parent)
            ],
            'targets': [NEOVIM.BIN],
            'file_dep': [NEOVIM.SOURCE],
            'verbosity':
            2,
        }


class SUMNEKO:
    GITHUB = 'sumneko/lua-language-server'
    SOURCE = GHQ_GITHUB_DIR / 'sumneko/lua-language-server/README.md'
    BIN = GHQ_GITHUB_DIR / f'sumneko/lua-language-server/bin/lua-language-server{EXE}'

    @classmethod
    def has_source(cls):
        return cls.SOURCE.is_dir()


def task_sumneko_get():
    return {
        'actions': [
            'ghq get sumneko/lua-language-server',
        ],
        'uptodate': [True],
        'targets': [SUMNEKO.SOURCE],
    }


if IS_WINDOWS:

    def task_sumneko_build():
        sumneko_dir = SUMNEKO.SOURCE.parent
        return {
            'actions': [
                doit.action.CmdAction('cmd /C compile\\install.bat',
                                      cwd=(sumneko_dir / '3rd/luamake')),
                doit.action.CmdAction('3rd\\luamake\\luamake.exe rebuild',
                                      cwd=sumneko_dir),
            ],
            'targets': [SUMNEKO.BIN],
            'file_dep': [SUMNEKO.SOURCE],
            'verbosity':
            2,
        }

else:

    def task_sumneko_build():
        sumneko_dir = SUMNEKO.SOURCE.parent
        return {
            'actions': [
                doit.action.CmdAction('./compile/install.sh',
                                      cwd=(sumneko_dir / '3rd/luamake')),
                doit.action.CmdAction('./3rd/luamake/luamake rebuild',
                                      cwd=sumneko_dir),
            ],
            'targets': [SUMNEKO.BIN],
            'file_dep': [SUMNEKO.SOURCE],
            'verbosity':
            2,
        }


def mklink(src, targets):
    dst = pathlib.Path(targets[0])
    if dst.exists() or dst.is_symlink():
        print(f'rm {dst}')
        dst.unlink()
    dst.parent.mkdir(exist_ok=True, parents=True)
    assert (src.is_file())
    dst.symlink_to(src, target_is_directory=False)


def check_link(src: pathlib.Path, dst: pathlib.Path):
    return dst.is_symlink() and dst.resolve() == src


def traverse(d: pathlib.Path):
    for f in d.iterdir():
        if f.is_dir():
            for x in traverse(f):
                yield x
        else:
            yield f


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


if IS_WINDOWS:
    pass
else:
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
                f'curl {url} -L -O',
            ]
        }


if PYTHON_BIN.exists():

    def task_pip_api():
        return {
            'actions': [f'{PYTHON_BIN} -m pip install pip-api'],
            'uptodate': [HAS_PIP_API],
        }

    if HAS_PIP_API:

        def task_pip():
            for k, v in PIP_MODULES.items():
                yield {
                    'name': k,
                    'uptodate': [lambda: k in PIP_INSTALLED],
                    'actions': [f'{PYTHON_BIN} -m pip install "{v}"'],
                }


CARGO_INSTALLS = {
    'ripgrep': 'rg',
    'bat': 'bat',
    'stylua': 'stylua',
    'viu': 'viu',
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


def task_skk_dictionary():
    url = 'https://skk-dev.github.io/dict/SKK-JISYO.L.gz'
    dst = HOME_DIR / '.skk/SKK-JISYO.L'
    return {
        'actions': [(mkdir, [dst.parent]), f'curl {url} | gzip -dc > {dst}'],
        'uptodate': [True],
        'targets': [dst]
    }


if IS_WINDOWS:
    def task_deno():
        return {
            "actions": ['pwsh -c "iwr https://deno.land/x/install/install.ps1 -useb | iex"'],
            "uptodate": [True],
            'targets': [HOME_DIR / '.deno/bin/deno.exe']
        }
else:
    def task_deno():
        return {
            "actions": ['curl -fsSL https://deno.land/x/install/install.sh | sh'],
            "uptodate": [True],
            'targets': [HOME_DIR / '.deno/bin/deno']
        }


def task_emoji():
    return {
        'actions': [
            'ghq get --shallow git@github.com:twitter/twemoji.git',
            (mkdir, [HOME_DIR / '.mlterm']),
            f'ln -s {GHQ_GITHUB_DIR}/twitter/twemoji/assets/72x72 {HOME_DIR}/.mlterm/emoji',
        ],
        "uptodate": [True],
        'targets': [
            GHQ_GITHUB_DIR / 'twitter/twemoji/README.md'
        ], }


def task_mlterm():
    dir = GHQ_GITHUB_DIR / 'arakiken/mlterm'
    return {
        'actions': [
            'ghq get arakiken/mlterm',
            doit.action.CmdAction(f'./configure --prefix={HOME_DIR}/local --with-gui=console', cwd=dir),
            doit.action.CmdAction('make install', cwd=dir),
        ],
        "uptodate": [True],
        'targets': [
            HOME_DIR / 'local/bin/mlterm-con'
        ],
    }
