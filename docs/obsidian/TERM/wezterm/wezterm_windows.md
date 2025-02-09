# launcher

```py
import subprocess
import os

EXE = "C:/Program Files/WezTerm/wezterm-gui.exe"
HOME = os.environ['USERPROFILE']
os.environ['LUA_PATH'] = f'{HOME}\\lua\\?.lua;{HOME}\\lua\\?\\init.lua'

subprocess.run(EXE, shell=False)
```

```sh
> pythonw.exe wezterm.py
```
