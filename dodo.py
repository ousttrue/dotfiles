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


def task_python310_build():
    def build():
        with push_dir(PYTHON310_ARCHIVE.parent):
            if subprocess.run(['tar', 'xf', PYTHON310_ARCHIVE.name]).returncode != 0:
                raise RuntimeError()
            with push_dir(PYTHON310_ARCHIVE_EXTRACT):
                if subprocess.run(['./configure', '--prefix', HOME_DIR / 'local']).returncode != 0:
                    raise RuntimeError()
                if subprocess.run(['make']).returncode != 0:
                    raise RuntimeError()
                if subprocess.run(['make', 'install']).returncode != 0:
                    raise RuntimeError()
    return {
        'actions': [build],
        'targets': [PYTHON310_BIN],
        'file_dep': [PYTHON310_ARCHIVE],
    }
