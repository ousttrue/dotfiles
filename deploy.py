#!env python3
import pathlib
from typing import Optional
import os
import sys
import shutil
from enum import Enum, auto

SELF = pathlib.Path(__file__).absolute()
DOTFILES = SELF.parent

EXCLUDE = [
    SELF, DOTFILES / 'README.md', DOTFILES / 'deploy.sh', DOTFILES / 'scripts'
]
EXCLUDE_NAMES = ['.git', '.vscode']


def get_home() -> pathlib.Path:
    if os.name == 'nt':
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
                print(f'overwrite: {dst}')
                shutil.copy(src, dst)
                return
        else:
            print(f'copy: {src} => {dst}')
            shutil.copy(src, dst)

    def apply_nt(self, src: pathlib.Path, dst: pathlib.Path):
        if dst.exists():
            if src.read_bytes() == dst.read_bytes():
                # same contents
                return
            else:
                print(f'apply: {dst}')
                shutil.copy(dst, src)
                return
        else:
            print(f'copy: {src} => {dst}')
            shutil.copy(src, dst)

    def deploy_posix(self, src: pathlib.Path, dst: pathlib.Path):
        if dst.exists():
            if dst.is_symlink():
                return
            else:
                print(f'exists: {dst}')
                return
        else:
            print(f'link: {src} => {dst}')
            dst.symlink_to(src)

    def deploy_file(self, src: pathlib.Path, dst: pathlib.Path):
        if not dst.parent.exists():
            dst.parent.mkdir()

        if os.name == 'nt':
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
                # print(f'skip: {child}')
                continue
            if child.name in EXCLUDE_NAMES:
                # print(f'skip: {child}')
                continue

            if child.is_dir():
                children.append(child)

            elif child.is_file():
                rel = child.relative_to(root)
                self.deploy_file(child, self.home / rel)

        for child in children:
            self.deploy_dir(root, child)


if __name__ == '__main__':
    mode = getattr(Mode, sys.argv[1])
    deploy = Deploy(get_home(), mode)
    deploy.deploy_dir(DOTFILES)
