#!env python3
import pathlib
from typing import Optional
import os

SELF = pathlib.Path(__file__).absolute()
DOTFILES = SELF.parent

EXCLUDE = [SELF, DOTFILES / 'README.md', DOTFILES / 'deploy.sh', DOTFILES / 'scripts']
EXCLUDE_NAMES = ['.git', '.vscode']


def get_home() -> pathlib.Path:
    if os.name == 'nt':
        user_profile = os.environ['USER_PROFILE']

    else:
        home = os.environ['HOME']
        if home:
            return pathlib.Path(home)
        else:
            raise Exception('no HOME')


HOME = get_home()


def deploy_file(src: pathlib.Path, dst: pathlib.Path):
    if not src.parent.exists():
        src.parent.mkdir()

    if dst.exists():
        if dst.is_symlink():
            return
        else:
            print(f'exists: {dst}')
            return

    if os.name == 'nt':
        print(f'copy: {src} => {dst}')

    else:
        print(f'link: {src} => {dst}')
        dst.symlink_to(src)


def deploy_dir(root: pathlib.Path, current: Optional[pathlib.Path] = None):

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
            deploy_file(child, HOME / rel)

    for child in children:
        deploy_dir(root, child)


if __name__ == '__main__':
    deploy_dir(DOTFILES)
