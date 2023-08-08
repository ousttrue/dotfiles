from typing import Optional
import argparse
import logging
import colorama
import contextlib
import os
import sys
import pathlib
import subprocess

LOGGER = logging.getLogger(__name__)
HERE = pathlib.Path(__file__).absolute().parent
DOTFILES_ROOT = HERE.parent


@contextlib.contextmanager
def pushd(path: pathlib.Path):
    current = pathlib.Path(os.getcwd())
    try:
        os.chdir(path)
        yield
    finally:
        os.chdir(current)


def run(cmd: str, env: Optional[dict] = None):
    LOGGER.debug(cmd)
    proc = subprocess.run(cmd, env=env, shell=True)
    return proc.returncode


def main():
    logging.basicConfig(level=logging.DEBUG)
    colorama.init(autoreset=True)

    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="parser_name")

    sub_pull = subparsers.add_parser("pull")
    sub_push = subparsers.add_parser("push")
    sub_status = subparsers.add_parser("status")

    args = parser.parse_args()

    match (args.parser_name):
        case "pull":
            with pushd(DOTFILES_ROOT):
                if run("git pull")!=0:
                    sys.exit(1)
                if run("doit")!=0:
                    sys.exit(1)

        case "push":
            with pushd(DOTFILES_ROOT):
                if run("git add .") != 0:
                    sys.exit(1)
                if run("git commit -av") != 0:
                    sys.exit(1)
                if run("git push") != 0:
                    sys.exit(1)

        case "status":
            with pushd(DOTFILES_ROOT):
                run("git status")

        case _:
            parser.print_help()


if __name__ == "__main__":
    main()
