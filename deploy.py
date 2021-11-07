#!/usr/bin/env python3
from logging import getLogger

logger = getLogger(__name__)

HAS_COLOR = False
try:
    import colorlog
    handler = colorlog.StreamHandler()
    handler.setFormatter(
        colorlog.ColoredFormatter(
            '%(log_color)s%(levelname)s:%(name)s:%(message)s'))
    root_logger = colorlog.getLogger()
    root_logger.addHandler(handler)
    root_logger.setLevel('DEBUG')
    HAS_COLOR = True
except Exception as ex:
    from logging import basicConfig, DEBUG
    basicConfig(
        level=DEBUG,
        datefmt='%H:%M:%S',
        format='%(asctime)s[%(levelname)s][%(name)s.%(funcName)s] %(message)s')

import pathlib
from typing import Optional, Tuple, List
import os
import sys
import shutil
import platform
from enum import Enum, auto
import subprocess

SELF = pathlib.Path(__file__).absolute()
DOTFILES = SELF.parent

EXCLUDE = [
    SELF, DOTFILES / 'README.md', DOTFILES / 'deploy.sh', DOTFILES / 'scripts'
]
EXCLUDE_NAMES = ['.git', '.vscode']

IS_WINDOWS = platform.system() == 'Windows'

APT = [
    'python3-pip',
    'tmux',
    'w3m',
    'cmake',
    'curl',
    'libtool-bin',
    'cmake',
    'python3',
    'ninja-build',
    'clangd',
    'peco',
    'golang-go',
]

PIP = [
    'colorlog',
    'doit',
    'invoke',
    'yapf',
    'pynvim',
    'neovim-remote',
    'yapf',
    'debugpy',
    'GitPython',
]

CARGO = [
    'bat',
    'exa',
    'stylua',
    'ripgrep',
]

NPM = [
    'pyright',
    'remark-cli',
]

# $ curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/bin/rust-analyzer
# $ chmod +x ~/bin/rust-analyzer


def run_command(*cmd, **kw) -> Tuple[int, List[str]]:
    logger.info(f'# {" ".join(cmd)}')
    if kw.get('shell'):
        cmd = cmd[0][0]
        logger.debug('shell', cmd)
    p = subprocess.Popen(cmd,
                         stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE,
                         **kw)
    if not p.stdout:
        raise Exception("fail to popen")
    lines = []
    for line_bytes in iter(p.stdout.readline, b''):
        line_bytes = line_bytes.rstrip()
        try:
            line = line_bytes.decode(encoding)
        except Exception:
            encoding = 'utf-8'
            line = line_bytes.decode(encoding)
        logger.debug(line.rstrip())
        lines.append(line)
    returncode = p.wait()
    if returncode != 0:
        raise Exception(f'returncode: {returncode}')
    return p.returncode, lines


def get_home() -> pathlib.Path:
    if IS_WINDOWS:
        user_profile = os.environ['USERPROFILE']
        if user_profile:
            return pathlib.Path(user_profile)
        else:
            raise Exception('no USER_PROFILE')

    else:
        home = os.environ['HOME']
        if home:
            return pathlib.Path(home)
        else:
            raise Exception('no HOME')


class Mode(Enum):
    deploy = auto()
    apply = auto()


class Deploy:
    def __init__(self, home: pathlib.Path, mode: Mode) -> None:
        self.home = home
        self.mode = mode  # deploy or update

    def deploy_nt(self, src: pathlib.Path, dst: pathlib.Path):
        if dst.exists():
            if src.read_bytes() == dst.read_bytes():
                # same contents
                return
            else:
                logger.info(f'overwrite: {dst}')
                shutil.copy(src, dst)
                return
        else:
            logger.info(f'copy: {src} => {dst}')
            shutil.copy(src, dst)

    def apply_nt(self, src: pathlib.Path, dst: pathlib.Path):
        if dst.exists():
            if src.read_bytes() == dst.read_bytes():
                # same contents
                return
            else:
                logger.info(f'apply: {dst}')
                shutil.copy(dst, src)
                return
        else:
            logger.info(f'copy: {src} => {dst}')
            shutil.copy(src, dst)

    def deploy_posix(self, src: pathlib.Path, dst: pathlib.Path):
        if dst.exists():
            if dst.is_symlink():
                return
            else:
                logger.warning(f'exists: {dst}')
                return
        else:
            logger.info(f'link: {src} => {dst}')
            dst.symlink_to(src)

    def deploy_file(self, src: pathlib.Path, dst: pathlib.Path):
        if src.suffix == '.swp':
            return

        if not dst.parent.exists():
            dst.parent.mkdir(parents=True)

        if IS_WINDOWS:
            if self.mode == Mode.deploy:
                self.deploy_nt(src, dst)
            elif self.mode == Mode.apply:
                self.apply_nt(src, dst)
            else:
                raise NotImplementedError(f'{self.mode}')

        else:
            if self.mode == Mode.deploy:
                self.deploy_posix(src, dst)
            elif self.mode == Mode.apply:
                raise NotImplementedError(f'{self.mode}')
            else:
                raise NotImplementedError(f'{self.mode}')

    def deploy_dir(self,
                   root: pathlib.Path,
                   current: Optional[pathlib.Path] = None):

        if not current:
            current = root

        children = []
        for child in current.iterdir():
            if any(exclude for exclude in EXCLUDE if exclude == child):
                # logger.warning(f'skip: {child}')
                continue
            if child.name in EXCLUDE_NAMES:
                # logger.warning(f'skip: {child}')
                continue

            if child.is_dir():
                children.append(child)

            elif child.is_file():
                rel = child.relative_to(root)
                self.deploy_file(child, self.home / rel)

        for child in children:
            self.deploy_dir(root, child)


if __name__ == '__main__':

    is_force = '-f' in (sys.argv[1:])
    if is_force or not HAS_COLOR:
        # apt
        run_command('sudo', 'apt', 'update')
        run_command('sudo', 'apt', 'install', '-y', *APT)

        # latest npm
        if not pathlib.Path('/usr/local/bin/npm').exists():
            run_command('sudo', 'apt', 'install', '-y', 'nodejs', 'npm')
            run_command('sudo', 'npm', 'install', 'n', '-g')
            run_command('sudo', 'n', 'stable')
            run_command('sudo', 'apt', 'purge', '-y', 'nodejs', 'npm')
            run_command('node', '-v')
            run_command('npm', 'config', 'set', 'prefix', '~/.local/')

        # rust
        cargo_dir = get_home() / '.cargo'
        if not cargo_dir.exists():
            subprocess.check_output(
                "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y",
                shell=True)

        # ghq
        # run_command('go', 'install', 'github.com/x-motemen/ghq@latest')
        run_command('go', 'get', 'github.com/x-motemen/ghq')

        # clone
        MY_NVIM = get_home() / 'my_nvim'
        if not MY_NVIM.exists():
            run_command('git', 'clone', 'git@github.com:ousttrue/my_nvim.git',
                        str(MY_NVIM))
            run_command('git', 'submodule', 'update', '--init', cwd=MY_NVIM)

    if HAS_COLOR:
        run_command('pip', 'install', *PIP)
        run_command('cargo', 'install', *CARGO)
        run_command('npm', 'install', '-g', *NPM)

        # copy
        mode = Mode.deploy
        if 'apply' in sys.argv[1:]:
            mode = Mode.apply
        deploy = Deploy(get_home(), mode)
        deploy.deploy_dir(DOTFILES)
