[[powershell]]

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

# git

## posh-git

起動が遅くなる

## alt

https://github.com/libgit2/libgit2sharp

- @2016 [LibGit2Sharpを使ってGitリポジトリのビュワーを作った時のTips #Git - Qiita](https://qiita.com/kurasho/items/39404e11ba3040a6ed5c)

# title

- [PowerShellで自分だけのオリジナルステータスバーを作る](https://zenn.dev/mdgrs/articles/c628be5212a1cb)

# 測定

- @2022 [PowerShellの起動時間をPSProfilerモジュールで確認してみる #PowerShell - Qiita](https://qiita.com/SAITO_Keita/items/fc385bbc6e3025686d8b)
- @2017 [PowerShellの起動時に表示されるプロファイルに関するメッセージについて - しばたテックブログ](https://blog.shibata.tech/entry/2017/03/13/202457)

[PowerShell スクリプトのパフォーマンスに関する考慮事項 - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/scripting/dev-cross-plat/performance/script-authoring-considerations?view=powershell-7.4)

# variables

```ps
# $env:JAVA_HOME = $env:ANDROID_STUDIO_HOME + "\jre";
# $env:VCPKG_DISABLE_METRICS = 1

# $PSDefaultParameterValues['*:Encoding'] = 'utf8'
# if($env:TERM_PROGRAM -ne "vscode"){
#    chcp 65001
# }
```

`$PSHOME = C:\Program Files\PowerShell\7`
`$PSVersionTable`
`$PROFILE`
`$IsWindows` : Windowsの場合$True。
`$IsMacOS`: macOSの場合$True。`$IsLinux` : Linuxの場合$True。

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
