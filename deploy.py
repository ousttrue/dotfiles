#!/usr/bin/env python3
from logging import getLogger
logger = getLogger(__name__)

try:
    import colorlog
    handler = colorlog.StreamHandler()
    handler.setFormatter(colorlog.ColoredFormatter(
        '%(log_color)s%(levelname)s:%(name)s:%(message)s'))
    root_logger = colorlog.getLogger()
    root_logger.addHandler(handler)
    root_logger.setLevel('DEBUG')

except Exception as ex:
    from logging import basicConfig, DEBUG
    basicConfig(
     level=DEBUG,
     datefmt='%H:%M:%S',
     format='%(asctime)s[%(levelname)s][%(name)s.%(funcName)s] %(message)s'
    )

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
]

PIP = [
    'colorlog',
    'doit',
]



def run_command(*cmd) -> Tuple[int, List[str]]:
    logger.info(f'# {" ".join(cmd)}')
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
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
        logger.debug(line)
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
    # apt
    run_command('sudo', 'apt', 'update')
    run_command('sudo', 'apt',  'install', '-y', *APT)

    # pip
    run_command('pip', 'install', *PIP)

    # copy 
    mode = Mode.deploy
    if len(sys.argv)>1:
        mode = getattr(Mode, sys.argv[1])
    deploy = Deploy(get_home(), mode)
    deploy.deploy_dir(DOTFILES)

    # clone
    MY_NVIM = get_home() / 'my_nvim'
    if not MY_NVIM.exists():
        run_command('git', 'clone', 'git@github.com:ousttrue/my_nvim.git', str(MY_NVIM))

