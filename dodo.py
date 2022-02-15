import pathlib
import platform
import os
import urllib.request
import contextlib
import subprocess


@contextlib.contextmanager
def push_dir(dir: pathlib.Path):
    current = pathlib.Path(os.getcwd())
    try:
        print(f'chdir {dir}')
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
LOCAL_DIR = HOME_DIR / 'local'
HERE = pathlib.Path(__file__).absolute().parent
PYTHON310_ARCHIVE_URL = 'https://www.python.org/ftp/python/3.10.2/Python-3.10.2.tar.xz'
PYTHON310_ARCHIVE = HOME_DIR / 'local/src/Python-3.10.2.tar.xz'
PYTHON310_ARCHIVE_EXTRACT = HOME_DIR / 'local/src/Python-3.10.2'
PYTHON310_BIN = HOME_DIR / 'local/bin/python'


def task_python310_download():
    def download():
        PYTHON310_ARCHIVE.parent.mkdir(parents=True, exist_ok=True)
        response = urllib.request.urlopen(PYTHON310_ARCHIVE_URL)
        data = response.read()
        PYTHON310_ARCHIVE.write_bytes(data)

    return {
        'actions': [download],
        'targets': [PYTHON310_ARCHIVE],
        'uptodate': [True],
    }

def run_or_raise(*args: str):
    if subprocess.run(args).returncode != 0:
        raise RuntimeError(f'{args}')


def task_python310_build():
    def build():
        with push_dir(PYTHON310_ARCHIVE.parent):
            run_or_raise('tar', 'xf', PYTHON310_ARCHIVE.name)
        with push_dir(PYTHON310_ARCHIVE_EXTRACT):
            run_or_raise('./configure', '--prefix', LOCAL_DIR, '--enable-optimizations')
            run_or_rais e('make', '-j', '4')
            run_or_raise('make', 'install')
        with push_dir(LOCAL_DIR / 'bin'):
            run_or_raise('ln' '-s', 'python3.10', 'python')
            run_or_raise('ln' '-s', 'pip3', 'pip')
    #
    # depends libssl-dev
    #
    return {
        'actions': [build],
        'targets': [PYTHON310_BIN],
        'file_dep': [PYTHON310_ARCHIVE],
    }

