[[powershell]] [[ps_stream]]

[Out-Default (Microsoft.PowerShell.Core) - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/out-default?view=powershell-7.4)

> すべてのパイプラインの末尾に自動的に追加 Out-Default

`Write-Out` => `Out-Default` => `Out-Host`
- Write-XXX は関数的
- OUt-XXX は Pipe 出力 

- @2006 [How PowerShell Formatting and Outputting REALLY works - PowerShell Team](https://devblogs.microsoft.com/powershell/how-powershell-formatting-and-outputting-really-works/)

# Update-FormatData
- formatter
[PowerShellの既定のフォーマット設定に介入する方法 · GitHub](https://gist.github.com/stknohg/2e2fc43b90e51ff5b5241152b7045e52)

# PSStyle


# out
## Out-Default
`Format-Table | Out-Host`
[Out-Defaultをフックしてパイプラインに渡されたオブジェクトの型と値をホストに表示するサンプル · GitHub](https://gist.github.com/stknohg/a0fabb9e10ddcc146672)

## Out-Host
```
Write-Host "`u{1F363}  `u{1F37A}"
```

## Out-Null
`$null`
## Out-File

## Out-String
```ps1
Out-String -stream
```

## Out-GridView
- @2020 [[PowerShell] 再度帰ってきた？Out-GridView | DevelopersIO](https://dev.classmethod.jp/articles/out-gridview-returns-twice-powershell-core/)
- [GitHub - PowerShell/GraphicalTools: Modules that mix PowerShell and GUIs/CUIs! - built on Avalonia and gui.cs](https://github.com/PowerShell/GraphicalTools)

=>  https://github.com/gui-cs/Terminal.Gui

# ps1xml
- @2018 [ps1xml のスキーマを書いた話 - 鷲ノ巣](https://aerie.hatenablog.jp/entry/powershell-advent-calendar-2018-04)

`~5.0`

```ps1
# $PSHOME
.\Modules\Microsoft.PowerShell.Diagnostics\Diagnostics.format.ps1xml
.\Modules\Microsoft.PowerShell.Diagnostics\Event.format.ps1xml
.\Modules\Microsoft.PowerShell.Diagnostics\GetEvent.types.ps1xml
.\Modules\Microsoft.PowerShell.PSResourceGet\PSGet.Format.ps1xml
.\Modules\Microsoft.PowerShell.Security\Security.types.ps1xml
.\Modules\Microsoft.WSMan.Management\WSMan.format.ps1xml
.\Modules\PSReadLine\PSReadLine.format.ps1xml
.\Modules\PackageManagement\PackageManagement.format.ps1xml
.\Modules\PowerShellGet\PSGet.Format.ps1xml
```