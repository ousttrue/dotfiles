from typing import Union
import pathlib
import platform
import os
import urllib.request
import contextlib
import subprocess
import logging

LOGGER = logging.getLogger(__name__)


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
        #
        "curl",
        "vim",
        "golang",
    ]


def download():
    if PYTHON310.ARCHIVE.exists():
        return
    PYTHON310.ARCHIVE.parent.mkdir(parents=True, exist_ok=True)
    response = urllib.request.urlopen(PYTHON310.ARCHIVE_URL)
    data = response.read()
    PYTHON310.ARCHIVE.write_bytes(data)


def build():
    # extract
    with push_dir(PYTHON310.ARCHIVE.parent):
        run_or_raise('tar', 'xf', PYTHON310.ARCHIVE.name)
    # apt
    run_or_raise('sudo', 'apt-get', 'install', '-y', *PYTHON310.DEP_APTS)
    # make
    with push_dir(PYTHON310.ARCHIVE_EXTRACT):
        run_or_raise('./configure', '--prefix', LOCAL_DIR,
                     '--enable-optimizations', '--enable-shared')
        run_or_raise('make', '-j', '4')
        run_or_raise('sudo', 'make', 'install')
        subprocess.run('sudo echo /usr/local/lib >> /etc/ld.so.conf', shell=True)
        run_or_raise('sudo', 'ldconfig')
    # ln
    with push_dir(LOCAL_DIR / 'bin'):
        if not (LOCAL_BIN / 'python').exists():
            run_or_raise('sudo', 'ln', '-s', 'python3.10', 'python')
        if not (LOCAL_BIN / 'pip').exists():
            run_or_raise('sudo', 'ln', '-s', 'pip3', 'pip')
        run_or_raise(LOCAL_DIR / 'bin/python3.10', '-m', 'pip', 'install',
                     '--upgrade', 'pip')
        #


def main():
    print('build_python')
    download()
    build()

    print('''
$ pip inistall doit
$ ~/.local/bin/doit
$ pip install xonsh[full]
$ xpip install xontrib-powerline3
$ xpip install xontrib-powerline3
''')


if __name__ == '__main__':
    main()
