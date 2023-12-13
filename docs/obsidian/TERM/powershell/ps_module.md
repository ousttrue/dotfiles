[[powershell]]

`$env:PSModulePath`
```sh
${env:USERPROFILE}\Documents\PowerShell\Modules
C:\Program Files\PowerShell\Modules
c:\program files\powershell\7\Modules
C:\Program Files\WindowsPowerShell\Modules
C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules
```

[モジュールについて - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_modules?view=powershell-7.4)
> コマンドレット、プロバイダー、関数、ワークフロー、変数、エイリアスなど

- @2022 [PowerShellのモジュールの種類はどう決まる？ #PowerShell - Qiita](https://qiita.com/TheParkSider/items/6db01ae4f97d97054cb7)

- [PowerShell Gallery | Home](https://www.powershellgallery.com/)
- [Import-Module (Microsoft.PowerShell.Core) - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/import-module?view=powershell-7.4)

- @2023 [大規模な PowerShell モジュールは Install-Module での導入がオススメです | Microsoft Japan Windows Technology Support Blog](https://jpwinsup.github.io/blog/2023/02/27/UserInterfaceAndApps/PowerShell/PowerShell-ImportModule-FunctionOverflow/)
- @2020 [PowerShellにおけるモジュールの取扱い方 #PowerShell - Qiita](https://qiita.com/tomomoss/items/5f8c027f3bdc3b189791)

`C:\Program Files\WindowsPowerShell\Modules`
`${env:USERPROFILE}\Documents\PowerShell\Modules`

# api
## Save-Module


# readline
[[[PSReadline]]]

# completion


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