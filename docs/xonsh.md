# xonsh

`v0.11.0`

<https://xon.sh/>

`pip install xonsh[full]'

## 設定

`~/.config/xonsh/rc.xsh` `~/.xonshrc`

```
$VI_MODE = True
$XONSH_COLOR_STYLE = 'native'
$XONSH_SHOW_TRACEBACK = True

xontrib load powerline2
```

<https://pypi.org/project/xontrib-powerline2/>

### vim

```vim
au BufNewFile,BufRead .xonshrc setf python
```

## prompt

<https://xon.sh/tutorial.html#customizing-the-prompt>


## git

<https://xon.sh/envvars.html#xonsh-gitstatus>


## vscode

`settings.json`

```json
    "terminal.integrated.defaultProfile.windows": "PowerShell",
    "terminal.integrated.profiles.windows": {
        "PowerShell": {
            "source": "PowerShell",
            "icon": "terminal-powershell"
        },
        "Command Prompt": {
            "path": [
                "${env:windir}\\Sysnative\\cmd.exe",
                "${env:windir}\\System32\\cmd.exe"
            ],
            "args": [
                "/k",
                "chcp",
                "65001"
            ],
            "icon": "terminal-cmd"
        },
        "xonsh": {
            "path": [
                "C:/Python310/Scripts/xonsh.exe",
            ],
        }
    }
```
