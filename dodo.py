import pathlib
import os

HAS_PIP_API = False
try:
    import pip_api
    HAS_PIP_API = True
except Exception as e:
    print(e)

HERE = pathlib.Path(__file__).absolute().parent
SYNC_DIR = HERE / 'sync'
SYNC_HOME_DIR = SYNC_DIR / 'HOME'
SYNC_APPDATA_DIR = SYNC_DIR / 'APPDATA'

PIP_MODULES = {
    'xonsh': 'xonsh[full]',
    'nerdfonts': 'nerdfonts',
    'autopep8': 'autopep8',
    'pipx': 'pipx',
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
    APPDATA_DIR = pathlib.Path(os.environ['APPDATA'])
    PYTHON_BIN = pathlib.Path('C:/python310/python.exe')
    PYTHON_SCRIPTS = pathlib.Path('C:/python310/Scripts')
else:
    HOME_DIR = pathlib.Path(os.environ['HOME'])
    from linux_tasks import *
    PYTHON_BIN = pathlib.Path('/usr/local/bin/python')
    PYTHON_SCRIPTS = HOME_DIR / '.local/bin'


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
        for src in traverse(SYNC_APPDATA_DIR):
            target = src.relative_to(SYNC_APPDATA_DIR)
            dst = APPDATA_DIR / target
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
                    'uptodate': [lambda: k in pip_api.installed_distributions()],
                    'actions': [f'{PYTHON_BIN} -m pip install "{v}"'],
                }

CARGO_INSTALLS = {
    'ripgrep': 'rg',
    'bat': 'bat',
    'stylua': 'stylua',
}
if IS_WINDOWS:
    CARGO_INSTALLS['lsd'] = 'lsd'
else:
    CARGO_INSTALLS |= {
            'exa': 'exa',
            'gitui':'gitui',
            'skim':'sk'
            }


def task_cargo():
    for k, v in CARGO_INSTALLS.items():
        yield {
            'name': k,
            'actions': [f"cargo install {k}"],
            'uptodate': [f'which {v}'],
            'targets': [HOME_DIR / f'.cargo/bin/{v}'],
        }

