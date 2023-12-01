[[dotNET]]

# Version
## 7.4(LTS)
- `.NET8` @2023 [PowerShell 7.4がリリースされました | DevelopersIO](https://dev.classmethod.jp/articles/powershell-7-4-generally-available/)
- [What's New in PowerShell 7.4 (preview) - PowerShell | Microsoft Learn](https://learn.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-74?view=powershell-7.2)

## 7.3
- [What's New in PowerShell 7.3 - PowerShell | Microsoft Learn](https://learn.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-73?view=powershell-7.2)

## 7.2(LTS)
- [What's New in PowerShell 7.2 - PowerShell | Microsoft Docs](https://docs.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-72?view=powershell-7.2)
	- [General Availability of PowerShell 7.2 - PowerShell Team](https://devblogs.microsoft.com/powershell/general-availability-of-powershell-7-2/)
> built on .NET 6.0.	

## 5.1
windows preinstall

# profile
[プロファイルについて - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.4)

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

## alias

## readline
[[PSReadline]]



## vscode
- @2022 [PoweShellの開発環境を整える](https://incipe.dev/blog/post/setting-up-a-powershell-development-environment/)
- @2022 [https://incipe.dev/blog/post/setting-up-a-powershell-development-environment/](https://incipe.dev/blog/post/setting-up-a-powershell-development-environment/)

## formatter

## lsp


# command
## Cmdlet
[[cmdlet]]

## function

## ps1 script

## .exe, .bat, .cmd ...


#  型
	```powershell
"a".GetType()

[math]::pi
```
