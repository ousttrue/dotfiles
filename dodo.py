from doit.tools import result_dep
from doit_lib import (IS_WINDOWS, HOME_DIR, EXE, GhqTask)


class fzf_ghq(GhqTask):
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
