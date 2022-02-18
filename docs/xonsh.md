# xonsh

`v0.11.0`

<https://xon.sh/>

`pip install xonsh[full]'

* <https://opensourcelibs.com/lib/xonsh-cheatsheet>
* (2020)[【Xonsh】Python製シェルが尖りまくってて神](https://qiita.com/akoji/items/4935480f9c53c980ffe0)
* (2019)[xonshの導入と使い方のメモ](https://qiita.com/souhei-etou/items/9a485df72b26b5a5148a)
* (2019)[xonshが超カッコイイ話](https://qiita.com/ihcamonoihS/items/659278e6fa7a4a130e1a)
* (2018)<https://qiita.com/advent-calendar/2018/xonsh>
* (2018)[xonshのPROMPTにdatetimeを表示する](https://vaaaaaanquish.hatenablog.com/entry/2018/03/18/014419)
* (2018)[Python製シェルxonshを半年使った所感や環境設定のまとめ](https://vaaaaaanquish.hatenablog.com/entry/2018/06/22/194227)
* (2018)[2018年のxonshrc](https://vaaaaaanquish.hatenablog.com/entry/2018/12/21/230441)
* (2017)<https://qiita.com/advent-calendar/2017/xonsh>
 
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

## callable alias

* (2017)[Xonshでコマンドを作る](https://qiita.com/riktor/items/2f18db475dc5b2c8d829)
