[プロファイルについて - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.4)

`$PSHOME\Profile.ps1`
`$HOME\Documents\PowerShell\Profile.ps1`

`~/.config/powershell/profile.ps1`

```
> $PROFILE | Select-Object *

AllUsersAllHosts       : C:\Program Files\PowerShell\7\profile.ps1
AllUsersCurrentHost    : C:\Program Files\PowerShell\7\Microsoft.PowerShell_profile.ps1
CurrentUserAllHosts    : %USERPROFILE%\Documents\PowerShell\profile.ps1
CurrentUserCurrentHost : %USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
```

[シェル環境のカスタマイズ - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/scripting/learn/shell/creating-profiles?view=powershell-7.4)
