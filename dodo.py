from doit.action import CmdAction
from doit_lib import (IS_WINDOWS, HOME_DIR, EXE, GitCloneTask, GitBuildTask,
                      condition)
from doit.tools import result_dep


class fzf_ghq(GitCloneTask):
    user = 'junegunn'
    repository = 'fzf'
    shallow = True


def task_fzf():
    if IS_WINDOWS:
        install = 'pwsh -File %(git_dir)s\\install.ps1'
    else:
        install = '%(git_dir)s/install'
    return {
        'getargs': {
            'git_dir': ('fzf_ghq', 'git_dir'),
        },
        'actions': [
            install,
            f'cp %(git_dir)s/bin/fzf{EXE} %(targets)s',
        ],
        'uptodate': [result_dep('fzf_ghq')],
        'targets': [HOME_DIR / f'local/bin/fzf{EXE}']
    }


class mlterm_ghq(GitCloneTask):
    user = 'arakiken'
    repository = 'mlterm'


class mlterm(GitBuildTask):
    condition = not IS_WINDOWS
    repository = mlterm_ghq
    actions = [
        CmdAction(f'./configure --prefix={HOME_DIR}/local --with-gui=console'),
        CmdAction('make install'),
    ]
    targets = [HOME_DIR / 'local/bin/mlterm-con']
