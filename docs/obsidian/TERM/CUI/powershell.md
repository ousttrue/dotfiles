[[dotNET]]

# Version
## 7.4
- [What's New in PowerShell 7.4 (preview) - PowerShell | Microsoft Learn](https://learn.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-74?view=powershell-7.2)

## 7.3
- [What's New in PowerShell 7.3 - PowerShell | Microsoft Learn](https://learn.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-73?view=powershell-7.2)

## 7.2
- [What's New in PowerShell 7.2 - PowerShell | Microsoft Docs](https://docs.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-72?view=powershell-7.2)
	- [General Availability of PowerShell 7.2 - PowerShell Team](https://devblogs.microsoft.com/powershell/general-availability-of-powershell-7-2/)
> built on .NET 6.0.	

## 5.1
windows preinstall

# settings
## $PROFILE

- `%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`
- `%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

```
mkdir %USERPROFILE%\Documents\WindowsPowerShell
%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
vim $profile
```

## readline
- [【PowerShell】PsReadLine 設定のススメ - Qiita](https://qiita.com/AWtnb/items/5551fcc762ed2ad92a81)
- [Set-PSReadLineKeyHandler (PSReadLine) - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/psreadline/set-psreadlinekeyhandler?view=powershell-7.2)
- [about PSReadLine Functions - PowerShell | Microsoft Learn](https://learn.microsoft.com/en-us/powershell/module/psreadline/about/about_psreadline_functions?view=powershell-7.2)

```profile.ps1
Set-PSReadlineKeyHandler -Key 'Ctrl+u' -Function BackwardDeleteLine
Set-PSReadlineKeyHandler -Key 'Ctrl+b' -Function BackwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+f' -Function ForwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+d' -Function DeleteChar
Set-PSReadlineKeyHandler -Key 'Ctrl+h' -Function BackwardDeleteChar
Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key 'Ctrl+a' -Function BeginningOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+e' -Function EndOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+m' -Function AcceptLine
Set-PSReadlineKeyHandler -Key 'Ctrl+k' -Function ForwardDeleteLine
```

## prompt
- @2022 [PowerShellのprompt関数について - Qiita](https://qiita.com/SAITO_Keita/items/47eb86a6d5dc5f928608)
- @2021 [PowerShellでプロンプト表示を変える](https://zenn.dev/kumarstack55/articles/2021-01-24-powershell-prompt)

## vscode
- @2022 [https://incipe.dev/blog/post/setting-up-a-powershell-development-environment/](https://incipe.dev/blog/post/setting-up-a-powershell-development-environment/)

# 型
```powershell
"a".GetType()

[math]::pi
```
