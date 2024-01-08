[[powershell]]
[[ps_package]]

[モジュールについて - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_modules?view=powershell-7.4)
> コマンドレット、プロバイダー、関数、ワークフロー、変数、エイリアスなど
- [標準ライブラリのバイナリ モジュールの作成方法 - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/scripting/dev-cross-plat/create-standard-library-binary-module?view=powershell-7.4)

- @2021 [PowerShell Gallery からモジュールをインストールするために必要な設定 | Microsoft Japan Windows Technology Support Blog](https://jpwinsup.github.io/blog/2021/06/14/UserInterfaceAndApps/PowerShell/how-to-setup-install-module/)

`$env:PSModulePath`
```sh
${env:USERPROFILE}\Documents\PowerShell\Modules
C:\Program Files\PowerShell\Modules
c:\program files\powershell\7\Modules
C:\Program Files\WindowsPowerShell\Modules
C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules
```

- @2022 [PowerShellのモジュールの種類はどう決まる？ #PowerShell - Qiita](https://qiita.com/TheParkSider/items/6db01ae4f97d97054cb7)

- [PowerShell Gallery | Home](https://www.powershellgallery.com/)
- [Import-Module (Microsoft.PowerShell.Core) - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/import-module?view=powershell-7.4)

- @2023 [大規模な PowerShell モジュールは Install-Module での導入がオススメです | Microsoft Japan Windows Technology Support Blog](https://jpwinsup.github.io/blog/2023/02/27/UserInterfaceAndApps/PowerShell/PowerShell-ImportModule-FunctionOverflow/)
- @2020 [PowerShellにおけるモジュールの取扱い方 #PowerShell - Qiita](https://qiita.com/tomomoss/items/5f8c027f3bdc3b189791)

`C:\Program Files\WindowsPowerShell\Modules`
`${env:USERPROFILE}\Documents\PowerShell\Modules`

# Nuget
[パッケージの手動ダウンロード - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/gallery/how-to/working-with-packages/manual-download?view=powershellget-3.x)


# PSRepository
```powershell
> Get-PSRepository

Name                      InstallationPolicy   SourceLocation
----                      ------------------   --------------
PSGallery                 Untrusted            https://www.powershellgallery.com/api/v2
```

# Find-Package
[Find-Package (PackageManagement) - PowerShell | Microsoft Learn](https://learn.microsoft.com/en-us/powershell/module/packagemanagement/find-package?view=powershellget-2.x)

# psmodule
```powershell
> dotnet new psmodule
TestSampleCmdletCommand.cs
hello_module.csproj
```

# PSScriptTools
`> Install-Module PSScriptTools -scope CurrentUser`

- [GitHub - jdhitsolutions/PSScriptTools: :wrench: A set of PowerShell functions you might use to enhance your own functions and scripts or to facilitate working in the console. Most should work in both Windows PowerShell and PowerShell 7, even cross-platform. Any operating system limitations should be handled on a per command basis. The Samples folder contains demonstration script files](https://github.com/jdhitsolutions/PSScriptTools)

# api
## Save-Module


# readline
[[[PSReadline]]]

# completion
[[ps_completion]]

# git
- [GitHub - dahlbyk/posh-git: A PowerShell environment for Git](https://github.com/dahlbyk/posh-git)
- [Git - Git in PowerShell](https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-PowerShell)

[PowerShell Gallery | Functions/Load-LibGit2Sharp.ps1 2.0.2](https://www.powershellgallery.com/packages/Git-PsRadar/2.0.2/Content/Functions%5CLoad-LibGit2Sharp.ps1)
- @2017 [Gitメモ : Git RadarでPROMPTにリポジトリの状態を表示 - もた日記](https://wonderwall.hatenablog.com/entry/2017/09/14/230000)
```sh
> Install-Module -Name Git-PsRadar
```

[GitHub - ethomson/gitpowershell: Git PowerShell module](https://github.com/ethomson/gitpowershell)

# fzf

# zlocation

# vswhere
- https://github.com/microsoft/vssetup.powershell

