#
# http://blog.schettino72.net/posts/doit-task-creation.html
#
import pathlib
import os
import sys
import platform
import doit.action
from doit.tools import run_once
from doit.tools import result_dep

DOTFILES = pathlib.Path(__file__).absolute().parent.parent
HOME_DIR = DOTFILES.parent
GHQ_DIR = HOME_DIR / 'ghq'
GHQ_GITHUB_DIR = GHQ_DIR / 'github.com'
SYNC_DIR = DOTFILES / 'sync'
SYNC_HOME_DIR = SYNC_DIR / 'HOME'

IS_WINDOWS = platform.system() == 'Windows'

if IS_WINDOWS:
    HOME_DIR = pathlib.Path(os.environ['USERPROFILE'])
    APPDATA_ROAMING_DIR = pathlib.Path(os.environ['APPDATA'])
    APPDATA_LOCAL_DIR = APPDATA_ROAMING_DIR.parent / 'Local'
    PYTHON_SCRIPTS = pathlib.Path(sys.executable).parent / 'Scripts'
    EXE = '.exe'
    SYNC_APPDATA_ROAMING_DIR = SYNC_DIR / 'APPDATA/Roaming'
    SYNC_APPDATA_LOCAL_DIR = SYNC_DIR / 'APPDATA/Local'
else:
    HOME_DIR = pathlib.Path(os.environ['HOME'])
    from linux_tasks import *
    PYTHON_SCRIPTS = HOME_DIR / '.local/bin'
    EXE = ''


def mkdir(path: pathlib.Path):
    print(path)
    path.mkdir(parents=True, exist_ok=True)


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
        branch = kw.pop('branch', '')
        if branch:
            branch = f' --branch {branch} '
        else:
            branch = ' '

        user_repository = f'{kw.pop("user")}/{kw.pop("repository")}'
        git_dir = GHQ_DIR / f'github.com/{user_repository}'
        cmd = f'ghq get{shallow}{branch}{user_repository}'
        if 'doc' not in kw:
            kw['doc'] = cmd

        def return_repository_dir():
            return {'git_dir': str(git_dir)}

        kw['actions'] = [
            cmd,
            (return_repository_dir, ),
            doit.action.CmdAction('git rev-parse HEAD', cwd=git_dir),
        ]
        patches = kw.pop('patches', [])
        if patches:
            kw['actions'].append(
                doit.action.CmdAction('patch -p1 < ~/dotfiles/w3m.patch'))

        kw['uptodate'] = [True]

        kw['file_dep'] = kw.get('file_dep',
                                []) + [HOME_DIR / f'go/bin/ghq{EXE}']

        apts = kw.pop('apts', [])
        if apts:
            if not IS_WINDOWS:
                kw['actions'].insert(
                    0, 'sudo apt-get install -y ' + ' '.join(apts))
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
