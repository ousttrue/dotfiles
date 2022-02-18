import contextlib

WEEKDAY = [
    '月',
    '火',
    '水',
    '木',
    '金',
    '土',
    '日',
]

def _datetime():
    import datetime
    now = datetime.datetime.now()
    return f'{now.day}{WEEKDAY[now.weekday()]}{now.hour}:{now.minute}'

@contextlib.contextmanager
def pushdir(dst):
    import os
    cwd = os.getcwd()
    os.chdir(dst)
    try:
        yield
    finally:
        os.chdir(cwd)

