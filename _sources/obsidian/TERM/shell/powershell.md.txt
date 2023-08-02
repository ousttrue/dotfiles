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
> New-Item -path $profile -type file -force
```

```
mkdir %USERPROFILE%\Documents\WindowsPowerShell
%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
vim $profile
```

## readline
- @2020 [【PowerShell】PsReadLine 設定のススメ - Qiita](https://qiita.com/AWtnb/items/5551fcc762ed2ad92a81)
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
- [about Prompts - PowerShell | Microsoft Learn](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_prompts?view=powershell-7.3&viewFallbackFrom=powershell-7.1)
- @2022 [PowerShellのprompt関数について - Qiita](https://qiita.com/SAITO_Keita/items/47eb86a6d5dc5f928608)
- @2021 [PowerShellでプロンプト表示を変える](https://zenn.dev/kumarstack55/articles/2021-01-24-powershell-prompt)
- @2020 [Windows PowerShellのプロンプトを変更する](https://bayashi.net/diary/2020/0615)
- @2016 [【PowerShell】 プロンプトの表示を変更する - 1.21 jigowatts](https://sh-yoshida.hatenablog.com/entry/2016/12/20/130000)

## vscode
- @2022 [https://incipe.dev/blog/post/setting-up-a-powershell-development-environment/](https://incipe.dev/blog/post/setting-up-a-powershell-development-environment/)

# 型
```powershell
"a".GetType()

[math]::pi
```
