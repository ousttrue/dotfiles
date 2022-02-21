# WindowsTerminal

<https://docs.microsoft.com/ja-jp/windows/terminal/>

* <https://qiita.com/tags/windowsterminal>

* <https://www.lisz-works.com/entry/wt-color-scheme>
* <https://snowsystem.net/other/windows/windows-terminal-install-customize/>
* (2021)[
「Windows Terminal」新プレビュー版、「Quake」モードなどを追加](https://japan.zdnet.com/article/35171462/)
* (2020)[How to replace external terminal in Visual Studio Code with the new Windows terminal? (And additional tips)](https://medium.com/analytics-vidhya/how-to-replace-external-terminal-in-visual-studio-code-with-the-new-windows-terminal-66e8460f2d31)
* (2020)[ついに完成「Windows Terminal」の機能と使い方まとめ](https://atmarkit.itmedia.co.jp/ait/articles/2005/28/news018.html)

## profile

`%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`

### WSL: home dir

<https://docs.microsoft.com/en-us/windows/terminal/troubleshooting>

`\\wsl$\Ubuntu-20.04\home\USER_NAME`

### color scheme

<https://draculatheme.com/windows-terminal>

## vscode

`settings.json`

```js
{
    "terminal.integrated.profiles.windows": {
        "wt": {
            "path": [
                "${env:LOCALAPPDATA}\\Microsoft\\WindowsApps\\wt.exe",
            ],
            "args": [
                "-p",
                "cmd",
                "cmd",
            ],
            "icon": "terminal-linux",
        },
        "PowerShell": {
            "source": "PowerShell",
            "icon": "terminal-powershell"
        },
        "Command Prompt": {
            "path": [
                "${env:windir}\\Sysnative\\cmd.exe",
                "${env:windir}\\System32\\cmd.exe"
            ],
            "args": [],
            "icon": "terminal-cmd"
        },
        "Git Bash": {
            "source": "Git Bash"
        }
    },
    "terminal.integrated.defaultProfile.windows": "wt",
}
```

## MSYS2
