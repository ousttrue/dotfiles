#
# http://blog.schettino72.net/posts/doit-task-creation.html
#
import pathlib
import os
import doit.action
from doit.tools import run_once
from doit.tools import result_dep

HAS_PIP_API = False
try:
    import pip_api
    HAS_PIP_API = True
    # slow
    PIP_INSTALLED = pip_api.installed_distributions()  # type: ignore
except Exception as e:
    print(e)

HERE = pathlib.Path(__file__).absolute().parent
HOME_DIR = HERE.parent.parent
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
    # import vcenv
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


def condition(cond):

    def empty(*args):
        pass

    def decorated(func):
        if not cond:
            return empty
        return func

    return decorated


class GitCloneTask(object):
    '''
    user: str
    repository: str
    shallow: bool = False
    '''

    @classmethod
    def create_doit_tasks(cls):
        if cls is GitCloneTask:
            return  # avoid create tasks from base class 'Task'
        instance = cls()
        kw = dict((a, getattr(instance, a)) for a in dir(instance)
                  if not a.startswith('_'))
        kw.pop('create_doit_tasks')

        shallow = ' --shallow ' if kw.pop("shallow", False) else ' '
        user_repository = f'{kw.pop("user")}/{kw.pop("repository")}'
        git_dir = GHQ_DIR / f'github.com/{user_repository}'
        cmd = f'ghq get{shallow}{user_repository}'
        if 'doc' not in kw:
            kw['doc'] = cmd

        def return_repository_dir():
            return {'git_dir': str(git_dir)}

        kw['actions'] = [
            cmd,
            (return_repository_dir, ),
            doit.action.CmdAction('git rev-parse HEAD', cwd=git_dir),
        ]
        kw['uptodate'] = [True]

        kw['file_dep'] = kw.get('file_dep',
                                []) + [HOME_DIR / f'go/bin/ghq{EXE}']

        return kw


class GitBuildTask(object):
    '''
    actions = []
    repository = GitCloneTask
    condition: bool = True
    '''

    @classmethod
    def create_doit_tasks(cls):
        if cls is GitBuildTask:
            return  # avoid create tasks from base class 'Task'
        instance = cls()
        kw = dict((a, getattr(instance, a)) for a in dir(instance)
                  if not a.startswith('_'))
        kw.pop('create_doit_tasks')

        if 'condition' in kw and not kw.pop('condition'):
            return

        repository = kw.pop('repository').__name__
        kw['getargs'] = {
            'git_dir': (repository, 'git_dir'),
        }
        kw['uptodate'] = [result_dep(repository)]

        def update_cwd(git_dir):
            for i, action in enumerate(kw['actions']):
                if isinstance(action, doit.action.CmdAction):
                    cwd = action.pkwargs.get('cwd', '')
                    if cwd:
                        action.pkwargs['cwd'] = cwd.replace(
                            '%(git_dir)s', git_dir)
                    else:
                        action.pkwargs['cwd'] = git_dir

        kw['actions'] = [
            doit.action.CmdAction(action)
            if isinstance(action, str) else action for action in kw['actions']
        ]
        kw['actions'].insert(0, (update_cwd, ))
        kw['verbosity'] = 2

        return kw
