import pathlib
import os
HERE = pathlib.Path(__file__).absolute().parent
SYNC_DIR = HERE / 'sync'


def get_home() -> pathlib.Path:
    userprofile = os.environ.get('USERPROFILE')
    if userprofile:
        return pathlib.Path(userprofile)
    home = os.environ.get('HOME')
    if home:
        return pathlib.Path(home)
    raise RuntimeError()


HOME_DIR = get_home()


def mklink(src: pathlib.Path, dst: pathlib.Path):
    if dst.exists():
        print(f'rm {dst}')
        dst.unlink()
    dst.symlink_to(src)


def task_create_link():
    '''
    create symbol link for config files
    '''
    target = '.xonshrc'
    src = SYNC_DIR / target
    dst = HOME_DIR / target
    return {        
        'actions': [(mklink, (dst, dst))],
        'verbosity': 2,
    }
