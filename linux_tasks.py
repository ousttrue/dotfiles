from typing import Union
import doit.action
import pathlib
import platform
import os
import urllib.request
import contextlib
import subprocess
import logging

logger = logging.getLogger(__name__)

__all__ = [
    'task_python310_download',
    'task_python310_build',
    'task_rustup',
    'task_w3m_get',
    'task_w3m_build',
    'task_ranger_devicon_get',
    'task_zig',
]


@contextlib.contextmanager
def push_dir(dir: pathlib.Path):
    current = pathlib.Path(os.getcwd())
    try:
        print(f'chdir {dir}')
        dir.mkdir(parents=True, exist_ok=True)
        os.chdir(dir)
        yield
    finally:
        print(f'chdir {current}')
        os.chdir(current)


def get_home():
    system = platform.system()
    if system == 'Linux':
        return pathlib.Path(os.environ['HOME'])
    else:
        raise RuntimeError()


HOME_DIR = get_home()
GHQ_DIR = HOME_DIR / 'ghq'
USR_LOCAL = pathlib.Path('/usr/local')
# LOCAL_DIR = HOME_DIR / 'local'
LOCAL_DIR = USR_LOCAL
LOCAL_BIN = LOCAL_DIR / 'bin'
HERE = pathlib.Path(__file__).absolute().parent


class PYTHON310:
    ARCHIVE_URL = 'https://www.python.org/ftp/python/3.10.2/Python-3.10.2.tar.xz'
    ARCHIVE = HOME_DIR / 'local/src/Python-3.10.2.tar.xz'
    ARCHIVE_EXTRACT = HOME_DIR / 'local/src/Python-3.10.2'
    BIN = LOCAL_BIN / 'python'
    DEP_APTS = [
        "build-essential",
        "libbz2-dev",
        "libdb-dev",
        "libreadline-dev",
        "libffi-dev",
        "libgdbm-dev",
        "liblzma-dev",
        "libncursesw5-dev",
        "libsqlite3-dev",
        "libssl-dev",
        "zlib1g-dev",
        "uuid-dev",
        "tk-dev",
    ]


class W3M:
    GITHUB = 'tats/w3m'
    SOURCE = GHQ_DIR / 'github.com/tats/w3m/main.c'
    BIN = HOME_DIR / 'local/bin/w3m'
    DEP_APTS = [
        'libgc-dev',
        'libimlib2-dev',
    ]

    @classmethod
    def has_source(cls):
        return cls.SOURCE.is_dir()


class ZIG:
    ARCHIVE_URL = 'https://ziglang.org/download/0.9.1/zig-linux-x86_64-0.9.1.tar.xz'
    ARCHIVE = HOME_DIR / 'local/src/zig-linux-x86_64-0.9.1.tar.xz'
    ARCHIVE_EXTRACT = HOME_DIR / 'local/src/zig-linux-x86_64-0.9.1'
    BIN = HOME_DIR / 'local/bin/zig'


def task_zig():

    def download():
        ZIG.ARCHIVE.parent.mkdir(parents=True, exist_ok=True)
        response = urllib.request.urlopen(ZIG.ARCHIVE_URL)
        data = response.read()
        ZIG.ARCHIVE.write_bytes(data)

    return {
        'actions': [
            f'mkdir -p {ZIG.ARCHIVE.parent}',
            f'curl {ZIG.ARCHIVE_URL} -o {ZIG.ARCHIVE}',
            doit.action.CmdAction(f'tar xf {ZIG.ARCHIVE}',
                                  cwd=ZIG.ARCHIVE.parent),
            f'mkdir -p {ZIG.BIN.parent}',
            f'ln -s {ZIG.ARCHIVE_EXTRACT}/zig {ZIG.BIN}',
        ],
        'targets': [ZIG.BIN],
        'uptodate': [True],
    }


def task_python310_download():

    def download():
        PYTHON310.ARCHIVE.parent.mkdir(parents=True, exist_ok=True)
        response = urllib.request.urlopen(PYTHON310.ARCHIVE_URL)
        data = response.read()
        PYTHON310.ARCHIVE.write_bytes(data)

    return {
        'actions': [download],
        'targets': [PYTHON310.ARCHIVE],
        'uptodate': [True],
    }


def run_or_raise(*args: Union[str, pathlib.Path]):
    print(f'{args}')
    with subprocess.Popen(args,
                          stdout=subprocess.PIPE,
                          stderr=subprocess.STDOUT) as p:
        assert (p.stdout)
        while p.poll() is None:
            line = p.stdout.readline()
            if isinstance(
                    line, bytes
            ) and b"The necessary bits to build these optional modules were not found:" in line:
                print(line)
        return_code = p.wait()
    print(return_code)
    if return_code:
        raise subprocess.CalledProcessError(return_code, cmd=f'{args}')


def task_python310_build():

    def build():
        # extract
        with push_dir(PYTHON310.ARCHIVE.parent):
            run_or_raise('tar', 'xf', PYTHON310.ARCHIVE.name)
        # apt
        run_or_raise('sudo', 'apt-get', 'install', '-y', *PYTHON310.DEP_APTS)
        # make
        with push_dir(PYTHON310.ARCHIVE_EXTRACT):
            run_or_raise('./configure', '--prefix', LOCAL_DIR,
                         '--enable-optimizations')
            run_or_raise('make', '-j', '4')
            run_or_raise('sudo', 'make', 'install')
        # ln
        with push_dir(LOCAL_DIR / 'bin'):
            if not (LOCAL_BIN / 'python').exists():
                run_or_raise('sudo', 'ln', '-s', 'python3.10', 'python')
            if not (LOCAL_BIN / 'pip').exists():
                run_or_raise('sudo', 'ln', '-s', 'pip3', 'pip')
            run_or_raise(LOCAL_DIR / 'bin/python3.10', '-m', 'pip', 'install',
                         '--upgrade', 'pip')
            #

    # depends libssl-dev
    #
    return {
        'actions': [build],
        'targets': [PYTHON310.BIN],
        'file_dep': [PYTHON310.ARCHIVE],
        'verbosity': 2,
    }


def task_rustup():
    return {
        'actions':
        ["curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"],
        'uptodate': ['which rustup'],
        'targets': [HOME_DIR / '.cargo/bin/rustup'],
    }


def task_w3m_get():
    return {
        'actions': [
            'sudo apt-get install -y ' + ' '.join(W3M.DEP_APTS),
            'ghq get tats/w3m',
            f'cd {W3M.SOURCE.parent} && patch -p1 < ~/dotfiles/w3m.patch',
        ],
        'uptodate': [True],
        'targets': [W3M.SOURCE],
    }


def task_w3m_build():

    def build():
        with push_dir(W3M.SOURCE.parent):
            run_or_raise('./configure', f'--prefix={HOME_DIR}/local')
            run_or_raise('make', '-j', '4')
            run_or_raise('make', 'install')

    return {
        'actions': [build],
        'targets': [W3M.BIN],
        'file_dep': [W3M.SOURCE],
        'verbosity': 2,
    }


def task_ranger_devicon_get():
    return {
        'actions': [
            'git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons',
        ],
        'uptodate': [True],
        'targets':
        [HOME_DIR / '.config/ranger/plugins/ranger_devicons/README.md'],
    }
