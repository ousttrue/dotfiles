import pathlib
import os
HERE = pathlib.Path(__file__).absolute().parent
SYNC_DIR = HERE / 'sync'
SYNC_HOME_DIR = SYNC_DIR / 'HOME'


def get_home() -> pathlib.Path:
    userprofile = os.environ.get('USERPROFILE')
    if userprofile:
        return pathlib.Path(userprofile)
    home = os.environ.get('HOME')
    if home:
        return pathlib.Path(home)
    raise RuntimeError()


HOME_DIR = get_home()


def mklink(dependencies, targets):
    src = pathlib.Path(dependencies[0])
    dst = pathlib.Path(targets[0])
    print(src, dst)
    if dst.exists():
        print(f'rm {dst}')
        dst.unlink()
    dst.parent.mkdir(exist_ok=True, parents=True)
    assert(src.is_file())
    dst.symlink_to(src, target_is_directory=False)


def check_link(src: pathlib.Path, dst: pathlib.Path):
    return dst.is_symlink() and dst.resolve() == src


def task_create_link():
    '''
    create symbol link for config files
    '''
    target = '.xonshrc'
    src = SYNC_HOME_DIR / target
    dst = HOME_DIR / target
    return {
        'file_dep': [src],
        'targets': [dst],
        'actions': [(mklink)],
        'uptodate': [(check_link, (src, dst))],
        'verbosity': 2,
    }
