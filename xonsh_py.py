import contextlib

def _datetime():
    import datetime
    now = datetime.datetime.now()
    return f'{now.weekday()}'

@contextlib.contextmanager
def pushdir(dst):
    import os
    cwd = os.getcwd()
    os.chdir(dst)
    try:
        yield
    finally:
        os.chdir(cwd)
