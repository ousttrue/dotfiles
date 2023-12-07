[[dotNET]]

- @2023 [PowerShellの起動を速くする | PowerShell from Japan!! Blog](https://blog.powershell-from.jp/?p=276)
- @2023 [PowerShell+fzfでコマンド入力支援](https://zenn.dev/mebiusbox/articles/b922c7e6ded49a)
- @2021 [PowerShellモジュールのPSFzfとZLocationをつかってみる #PowerShell - Qiita](https://qiita.com/SAITO_Keita/items/f1832b34a9946fc8c716)
- @2018 [今すぐalias登録すべきPowerShellワンライナー #VSCode - Qiita](https://qiita.com/mu_sette/items/3954759daee8ae9ad26f)
- [PowerShell+fzfでコマンド入力支援](https://zenn.dev/mebiusbox/articles/b922c7e6ded49a)


# Version
## Core 7.4(LTS)
- `.NET8` @2023 [PowerShell 7.4がリリースされました | DevelopersIO](https://dev.classmethod.jp/articles/powershell-7-4-generally-available/)
- [What's New in PowerShell 7.4 (preview) - PowerShell | Microsoft Learn](https://learn.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-74?view=powershell-7.2)

## Core 7.3
- [What's New in PowerShell 7.3 - PowerShell | Microsoft Learn](https://learn.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-73?view=powershell-7.2)
- @2022 [PowerShell 7.3がリリースされました | DevelopersIO](https://dev.classmethod.jp/articles/powershell-7-3-generally-available/)
- https://dev.classmethod.jp/articles/about-powershell-7-3-clean-blcok-feature/

## Core 7.2(LTS)
- `.NET6` @2021 [PowerShell 7.2がリリースされました | DevelopersIO](https://dev.classmethod.jp/articles/powershell-7-2-generally-available/)
- `PSNativeCommandArgumentPassing` [PowerShell Core入門 - 基本コマンドの使い方(177) PowerShell 7.2登場 - ゲームチェンジャーかもしれないネイティブコマンドパス解析機能 | TECH+（テックプラス）](https://news.mynavi.jp/techplus/article/powershell_core_--177/)
- `Predictive IntelliSense` [PowerShell Core入門 - 基本コマンドの使い方(176) PowerShell 7.2登場 - ゲームチェンジャーかもしれない入力予測機能 | TECH+（テックプラス）](https://news.mynavi.jp/techplus/article/techp5887/)
- [最近の PowerShell について](https://www.slideshare.net/slideshow/embed_code/key/eEwNM71q6DI5ij)
- [What's New in PowerShell 7.2 - PowerShell | Microsoft Docs](https://docs.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-72?view=powershell-7.2)
	- [General Availability of PowerShell 7.2 - PowerShell Team](https://devblogs.microsoft.com/powershell/general-availability-of-powershell-7-2/)
[[ps_out]] `$PSStyle`

## Core 7.1
- `.NET5` @2020 [PowerShell 7.1がリリースされました | DevelopersIO](https://dev.classmethod.jp/articles/powershell-7-1-generally-available/)

## Core 7.0
- [PowerShell Gallery | Microsoft.PowerShell.ConsoleGuiTools 0.7.2](https://www.powershellgallery.com/packages/Microsoft.PowerShell.ConsoleGuiTools/0.7.2)

## Core 6.0
`.NET Core`
- @2018 [PowerShell Core 6.0 新機能まとめ - しばたテックブログ](https://blog.shibata.tech/entry/2018/02/09/175835)
> powershell(.exe) => pwsh(.exe)
> BOMなしUTF-8がデフォルト

## Windows PowerShell 5.1
windows preinstall
> PowerShell 5.1からは$PSHOMEにあるps1xmlファイルは使われなくなります。

## Windows PowerShell 1.0 ~ 4.0
- @2016 [PowerShellの起動時に読まれるps1xmlファイルについて - しばたテックブログ](https://blog.shibata.tech/entry/2016/08/02/212739)


# variable
`$PSHOME = C:\Program Files\PowerShell\7`
`$PSVersionTable`
`$PROFILE`
`$IsWindows` : Windowsの場合$True。
`$IsMacOS` : macOSの場合$True。
`$IsLinux` : Linuxの場合$True。

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


# module
[[ps_module]]

# provider
[[ps_provider]]

#  型
- @2022 [PowerShellの配列と連想配列 | 晴耕雨読](https://tex2e.github.io/blog/powershell/array)
```powershell
"a".GetType() // => System.String
@().GetType() // => System.Object[]
[math]::pi.GetType() // => Double 
```
