import sys
import pathlib
import site
from doit.action import CmdAction
from doit_lib import (IS_WINDOWS, HOME_DIR, EXE, GitCloneTask, GitBuildTask,
                      GHQ_GITHUB_DIR, condition, mkdir, traverse,
                      SYNC_HOME_DIR, DOTFILES, mklink, check_link, download,
                      extract)
if IS_WINDOWS:
    from doit_lib import (SYNC_APPDATA_LOCAL_DIR, SYNC_APPDATA_ROAMING_DIR,
                          APPDATA_LOCAL_DIR, APPDATA_ROAMING_DIR)
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


GO_ARCHIVE = HOME_DIR / 'local/src/go1.18.1.linux-amd64.tar.gz'
GO_BIN = '/usr/local/go/bin/go'


@condition(not IS_WINDOWS)
def task_golang_downlaod():
    url = 'https://go.dev/dl/go1.18.1.linux-amd64.tar.gz'
    return {
        'uptodate': [True],
        'targets': [GO_ARCHIVE],
        'actions': [
            'mkdir -p ~/local/src',
            f'curl {url} -L -o %(targets)s',
        ],
    }


@condition(not IS_WINDOWS)
def task_golang():
    return {
        'file_dep': [GO_ARCHIVE],
        'actions': [
            'sudo rm -rf /usr/local/go',
            'sudo tar -C /usr/local -xzf %(dependencies)s',
        ],
        'targets': [GO_BIN]
    }


CARGO_INSTALLS = {
    'ripgrep': 'rg',
    'bat': 'bat',
    'stylua': 'stylua',
    'viu': 'viu',
    'zoxide': 'zoxide',
    'broot': 'broot',
    'fd-find': 'fd',
}
if IS_WINDOWS:
    CARGO_INSTALLS['lsd'] = 'lsd'
else:
    CARGO_INSTALLS |= {'exa': 'exa', 'gitui': 'gitui', 'skim': 'sk'}


@condition(not IS_WINDOWS)
def task_rustup():
    return {
        'actions': [
            "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
        ],
        'uptodate': ['which rustup'],
        'targets': [HOME_DIR / f'.cargo/bin/rustup{EXE}'],
    }


def task_cargo():
    for k, v in CARGO_INSTALLS.items():
        yield {
            'name': k,
            'actions': [f"{HOME_DIR}/.cargo/bin/cargo{EXE} install {k}"],
            'file_dep': [HOME_DIR / f'.cargo/bin/rustup{EXE}'],
            'targets': [HOME_DIR / f'.cargo/bin/{v}{EXE}'],
        }


if IS_WINDOWS:
    for s in site.getsitepackages():
        if 'site-packages' in s:
            SITE_PACKAGES = pathlib.Path(s)
            break
else:
    SITE_PACKAGES = pathlib.Path(site.getusersitepackages())


def task_pip_api():
    return {
        'actions': [f'{sys.executable} -m pip install --user pip-api'],
        'uptodate': [True],
        'targets': [f'{SITE_PACKAGES}/pip_api/__init__.py'],
    }


PIP_MODULES = {
    'powerline_shell': 'powerline-shell',
    'xonsh': 'xonsh[full]',
    'xontrib_powerline3': 'xontrib-powerline3',
    'nerdfonts': 'nerdfonts',
    'autopep8': 'autopep8',
    'yapf': 'yapf',
    'pipx': 'pipx',
    'pynvim': 'pynvim',
    'powerline_status': 'powerline-status',
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
            'actions': [f'{sys.executable} -m pip install --user "{v}"'],
        }


def task_go_ghq():
    return {
        'actions': [
            'go install github.com/x-motemen/ghq@latest',
            # 'go get github.com/motemen/ghq',
        ],
        'uptodate': [True],
        'file_dep': [] if IS_WINDOWS else [GO_BIN],
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
            f'mkdir -p {HOME_DIR}/local/bin',
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


HACKGEN_ZIP = HOME_DIR / 'local/src/HackGenNerd_v2.6.0.zip'


def task_font_hackgen_downlaod():
    url = 'https://github.com/yuru7/HackGen/releases/download/v2.6.0/HackGenNerd_v2.6.0.zip'
    return {
        'uptodate': [True],
        'targets': [HACKGEN_ZIP],
        'actions': [
            (mkdir, [HOME_DIR / 'local/src']),
            f'curl {url} -L -o %(targets)s',
        ],
    }


def task_font_hackgen():
    task = {
        'file_dep': [HACKGEN_ZIP],
        'targets': [HOME_DIR / '.fonts/HackGenNerdConsole-Regular.ttf'],
        'actions': [
            (mkdir, [HOME_DIR / '.fonts']),
            'unzip -o -p %(dependencies)s HackGenNerd_v2.6.0/HackGenNerdConsole-Regular.ttf | cat > %(targets)s',
        ],
    }
    if not IS_WINDOWS:
        task['actions'].append('fc-cache -fv')
    return task


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
    branch = 'v0.7.0'
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
    emerge = [
        # 'cmake',
    ]
    patches = [DOTFILES / 'neovim.patch']


if IS_WINDOWS:
    from cmake import CMAKE_BIN_DIR
    cmake = f'{CMAKE_BIN_DIR}\\cmake.exe'

    class neovim(GitBuildTask):
        repository = neovim_ghq
        actions = [
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
            'mkdir -p ~/local/bin',
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
            'libsixel-dev',
            'libsixel-bin',
        ]
        emerge = ['boehm-gc']
        patches = [DOTFILES / 'w3m.patch']

    class w3m(GitBuildTask):
        repository = w3m_ghq
        actions = [
            f'./configure --prefix={HOME_DIR}/local',
            'make -j 4',
            'make install',
        ]
        targets = [HOME_DIR / 'local/bin/w3m']


#
# https://github.com/ziglang/zig/wiki/Building-Zig-on-Windows
#
# master
# ZIG_BUILD_VERSION = '2351+b64a1d5ab'
ZIG_BUILD_VERSION = '3027+0e26c6149'
if IS_WINDOWS:
    ZIG_ARCHIVE_NAME = f'zig-windows-x86_64-0.10.0-dev.{ZIG_BUILD_VERSION}'
    ZIG_ARCHIVE_PATH = HOME_DIR / f'local/src/{ZIG_ARCHIVE_NAME}.zip'
    ZIG_ARCHIVE_URL = f'https://ziglang.org/builds/{ZIG_ARCHIVE_NAME}.zip'
else:
    ZIG_ARCHIVE_NAME = f'zig-linux-x86_64-0.10.0-dev.{ZIG_BUILD_VERSION}'
    ZIG_ARCHIVE_PATH = HOME_DIR / f'local/src/{ZIG_ARCHIVE_NAME}.tar.xz'
    ZIG_ARCHIVE_URL = f'https://ziglang.org/builds/{ZIG_ARCHIVE_NAME}.tar.xz'
ZIG_EXTRACT_FILE = HOME_DIR / f'local/src/{ZIG_ARCHIVE_NAME}/zig{EXE}'
ZIG_BIN = HOME_DIR / f'local/bin/zig{EXE}'


def task_zig_download():
    return {
        'actions': [
            (download, [ZIG_ARCHIVE_URL]),
        ],
        'targets': [ZIG_ARCHIVE_PATH],
        'uptodate': [True],
    }


def task_zig_extract():
    dst_dir = HOME_DIR / 'local/src'
    return {
        'actions': [
            (extract, [dst_dir]),
        ],
        'file_dep': [ZIG_ARCHIVE_PATH],
        'targets': [ZIG_EXTRACT_FILE],
    }


def task_zig():
    return {
        'actions': [
            (mklink, [ZIG_EXTRACT_FILE, ZIG_BIN]),
            (mklink, [ZIG_EXTRACT_FILE.parent / 'lib',
                      ZIG_BIN.parent / 'lib']),
        ],
        'file_dep': [ZIG_EXTRACT_FILE],
        'targets': [ZIG_BIN],
    }


class zls_ghq(GitCloneTask):
    user = 'zigtools'
    repository = 'zls'
    patches = [DOTFILES / 'zls.patch']


class zls(GitBuildTask):
    repository = zls_ghq
    file_dep = [HOME_DIR / f'local/bin/zig{EXE}']
    targets = [f'{HOME_DIR}/local/bin/zls{EXE}']
    actions = [
        f'zig{EXE} build -Drelease-safe',
        (mklink,
         [f'{HOME_DIR}/ghq/github.com/zigtools/zls/zig-out/bin/zls{EXE}']),
    ]


class gyro_ghq(GitCloneTask):
    user = 'mattnite'
    repository = 'gyro'
    # patches = [DOTFILES / 'gyro.patch']


class gyro(GitBuildTask):
    repository = gyro_ghq
    file_dep = [HOME_DIR / f'local/bin/zig{EXE}']
    targets = [f'{HOME_DIR}/local/bin/gyro{EXE}']
    actions = [
        f'zig{EXE} build -Drelease-safe',
        (mklink,
         [f'{HOME_DIR}/ghq/github.com/mattnite/gyro/zig-out/bin/gyro{EXE}']),
    ]


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


class bpy_ghq(GitCloneTask):
    user = 'blender'
    repository = 'blender'
    apts = [
        # 'build-essential',
        'git',
        # 'subversion',
        'cmake',
        'libxxf86vm-dev',
        # 'libxcursor-dev',
        'libxi-dev',
        # 'libxrandr-dev',
        # 'libxinerama-dev',
        # 'libglew-dev',
        # 'libx11-dev',
        # 'libsndfile1-dev',
        'libopenexr-dev',
        'libjpeg-dev',
        # 'libopenal-dev',
        # 'libalut-dev',
        # 'libglu1-mesa-dev',
        # 'libsdl-dev',
        # 'libfreetype6-dev',
        'libavdevice-dev',
        'libavformat-dev',
        'libavutil-dev',
        'libavcodec-dev',
        'libswscale-dev',
        'libx264-dev',
        'libxvidcore-dev',
        'libmp3lame-dev',
        # 'libspnav-dev',
        'libzstd-dev',
        'libboost-all-dev',
        'libopenimageio-dev',
    ]


CONFIGURE_FLAGS = ' '.join([
    '-DCMAKE_BUILD_TYPE=Release',
    '-DWITH_INTERNATIONAL=OFF',
    '-DWITH_INPUT_NDOF=OFF',
    '-DWITH_CYCLES=OFF',
    '-DWITH_OPENVDB=OFF',
    '-DWITH_LIBMV=OFF',
    '-DWITH_MEM_JEMALLOC=OFF',
    '-DWITH_DRACO=OFF',
    '-DWITH_TBB=OFF',
    '-DWITH_GMP=OFF',
    '-DWITH_CYCLES=OFF',
    '-DWITH_HARU=OFF',
    '-DWITH_POTRACE=OFF',
    '-DWITH_MOD_OCEANSIM=OFF',
    '-DWITH_OPENCOLLADA=OFF',
    '-DWITH_AUDASPACE=OFF',
    '-DWITH_WINDOWS_BUNDLE_CRT=OFF',
])

BPY_FLAGS = ' '.join([
    '-DWITH_PYTHON_INSTALL=OFF', '-DWITH_PYTHON_INSTALL_NUMPY=OFF',
    '-DWITH_PYTHON_MODULE=ON'
])

if IS_WINDOWS:

    class bpy(GitBuildTask):
        repository = bpy_ghq
        actions = [
            'git switch -C v3.1.2 refs/tags/v3.1.2',
            f'{sys.executable} build_files/utils/make_update.py',
            f'cmake -S . -B ../bpy -G Ninja {CONFIGURE_FLAGS} {BPY_FLAGS}',
            'cmake --build ../bpy',
            f'cmake --install ../bpy --config Release --prefix {HOME_DIR / "local/bpy"}',
            f'cp ../bpy/bin/bpy.pyd {HOME_DIR / "local/bpy/bpy.pyd"}',
            (mklink, [HOME_DIR / "local/bpy/3.1"]),
        ]
        targets = [str(pathlib.Path(sys.executable).parent / '3.1')]

else:

    class bpy(GitBuildTask):
        repository = bpy_ghq
        actions = [
            'git switch -C v3.1.2 refs/tags/v3.1.2',
            f'{sys.executable} build_files/utils/make_update.py',
            f'cmake -S . -B ../bpy -G Ninja {CONFIGURE_FLAGS} {BPY_FLAGS}',
            'cmake --build ../bpy',
            f'cmake --install ../bpy --config Release --prefix {HOME_DIR / "local/bpy"}',
        ]
        targets = [HOME_DIR / 'local/bpy/bpy.so']

    class yaft_ghq(GitCloneTask):
        user = 'uobikiemukot'
        repository = 'yaft'

    class yaft(GitBuildTask):
        repository = yaft_ghq
        actions = [
            'make',
            'sudo make install',
        ]
        targets = ['/usr/local/bin/yaft']


class wezterm_ghq(GitCloneTask):
    user = 'wez'
    repository = 'wezterm'
    patches = [DOTFILES / 'wezterm.patch']


class wezterm(GitBuildTask):
    repository = wezterm_ghq
    file_dep = [HOME_DIR / '.fonts/HackGenNerdConsole-Regular.ttf']
    actions = [
        './get-deps',
        'cargo build --release',
        f'ln -s {HOME_DIR}/ghq/github.com/wez/wezterm/target/release/wezterm {HOME_DIR}/local/bin/wezterm',
    ]


class vcpkg_ghq(GitCloneTask):
    user = 'microsoft'
    repository = 'vcpkg'
    shallow = True


# https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.1/llvm-13.0.1.src.tar.xz
LLVM_ARCHIVE = HOME_DIR / 'local/src/llvm-14.0.3.src.tar.xz'


def task_llvm_downlaod():
    url = 'https://github.com/llvm/llvm-project/releases/download/llvmorg-14.0.3/llvm-14.0.3.src.tar.xz'
    return {
        'uptodate': [True],
        'targets': [LLVM_ARCHIVE],
        'actions': [
            'mkdir -p ~/local/src',
            f'curl {url} -L -o %(targets)s',
        ],
    }


def task_llvm_extract():
    return {
        'file_dep': [LLVM_ARCHIVE],
        'actions': [
            f'tar -C {HOME_DIR}/local/src -xf %(dependencies)s',
        ],
    }


DOIT_CONFIG = {
    'default_tasks': [
        'create_link',
        'deno',
        'pip',
        'neovim',
        'fzf',
        'skk_dictionary',
        'sumneko_lua_language_server',
    ]
}

if IS_WINDOWS:
    pass
else:
    pass
    # DOIT_CONFIG['default_tasks'].append('w3m')
