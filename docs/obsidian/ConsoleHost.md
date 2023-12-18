[[conpty]]

```powershell
> Get-Host
Name             : ConsoleHost
Version          : 7.4.0
```

- @2022 [[PowerShell]: 文字列を複数の色で出力する](https://zenn.dev/bluesilvercat/articles/354f4357f92d72)
- @2019 [PowerShell　背景色文字色変更 - ささやかな日々記](https://ryukiko0730.hatenablog.com/entry/2019/03/24/180402)
- @2010 [PowerShellウインドーサイズをスクリプトで変更する - PowerShell 逆引きリファレンス](http://powershell.web.fc2.com/Html/Data/2010/09/29/0001.html)
- @2008 [2008-05-14](https://newpops.hatenadiary.org/entries/2008/05/14)

# UI
- @2006 [「$host.ui」に関する考察 - PowerShell Memo](https://newpops.hatenadiary.org/entry/20061119/p1)
- @2006 [コンソールに選択肢を表示する - PowerShell Memo](https://newpops.hatenadiary.org/entry/20061120/p2)]

```powershell
PS C:\> $host.ui.GetType().FullName
System.Management.Automation.Internal.Host.InternalHostUserInterface
```

# ReadKey
- @2020 [PowerShell Core で確認ダイアログ - ねこさんのぶろぐ](https://www.neko3cs.net/entry/2020/07/26/013451)
```powershell
Write-Host "続行するには何かキーを押してください...`n"
$host.UI.RawUI.ReadKey() | Out-Null
```

# poco
## screen


## backup/restore
[[poco]]
GetBufferContents
SetBufferContents
