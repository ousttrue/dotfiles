import pathlib
import os
HERE = pathlib.Path(__file__).absolute().parent
SYNC_DIR = HERE / 'sync'
SYNC_HOME_DIR = SYNC_DIR / 'HOME'
SYNC_APPDATA_DIR = SYNC_DIR / 'APPDATA'

def is_windows():
    import platform
    return platform.system() == 'Windows'

IS_WINDOWS = is_windows()

if IS_WINDOWS:
    HOME_DIR = pathlib.Path(os.environ['USERPROFILE'])
    APPDATA_DIR = pathlib.Path(os.environ['APPDATA'])
else:
    HOME_DIR = pathlib.Path(os.environ['HOME'])
    from build_python310 import task_python310_build


def mklink(dependencies, targets):
    src = pathlib.Path(dependencies[0])
    dst = pathlib.Path(targets[0])
    if dst.exists() or dst.is_symlink():
        print(f'rm {dst}')
        dst.unlink()
    dst.parent.mkdir(exist_ok=True, parents=True)
    assert(src.is_file())
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
            'file_dep': [src],
            'targets': [dst],
            'actions': [(mklink)],
            'uptodate': [(check_link, (src, dst))],
            'verbosity': 2,
        }
    
    if IS_WINDOWS:
        for src in traverse(SYNC_APPDATA_DIR):
            target = src.relative_to(SYNC_APPDATA_DIR)
            dst = APPDATA_DIR / target
            yield {
                'name': target,
                'file_dep': [src],
                'targets': [dst],
                'actions': [(mklink)],
                'uptodate': [(check_link, (src, dst))],
                'verbosity': 2,
            }

