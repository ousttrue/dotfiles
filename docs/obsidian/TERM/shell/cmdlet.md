[[powershell]]

- @2019 [Powershellのコマンドレット(Cmdlet)と関数(Function) - One Step Ahead](https://one-sthead.hatenablog.com/entry/2019/09/04/142925)

# builtin
## get-command(gcm)


## move-item(move)
[Move-Item (Microsoft.PowerShell.Management) - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.management/move-item?view=powershell-7.3)

## remove-item
`rm`
https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.management/remove-item?view=powershell-7.3

### folder

`Remove-Item -Recurse path`

複数
`Remove-Item -Recurse a,b,c`

## new-item
```ps1
> New-Item -ItemType Directory HOGE
```
[フォルダを作成する / ディレクトリを作成する : PowerShell Tips | iPentec](https://www.ipentec.com/document/powershell-create-directory)

## pipeline
### Foreach-Object

```ps1
dir *.txt | foreach{ $_.name }
# 👇
dir *.txt | %{ $_.name }
```

```ps1
1..5|%{$t=0}{$t+=$_}{$t}
```

`flattern`

### Where-Object
```ps1
1..10|where {$_%2}
```

```ps1
1..10|?{$_%2}
```

# third-party
## poco
- [GitHub - jasonmarcher/poco: Interactive pipeline filtering in PowerShell (a port of peco).](https://github.com/jasonmarcher/poco)
- [GitHub - krymtkts/pocof: An interactive pipeline filtering Cmdlet for PowerShell written in F#.](https://github.com/krymtkts/pocof)

# module
## import-module
- [Import-Module (Microsoft.PowerShell.Core) - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/import-module?view=powershell-7.4)

# Fsharp
[[fsharp]]
[Writing a PowerShell Core Module With F#, A Complete Guide | Brianary](https://webcoder.info/fspsmodule.html)
- @2019 [Writing PowerShell Modules in F#. This article will give you step-by-step… | by Nate Lehman | Medium](https://medium.com/@natelehman/writing-powershell-modules-in-f-ed52704d97ed)
```sh
> dotnet new classlib -lang 'F#' -o src/MyPSModule
```

- @2023 [PowerShell の Cmdlet を F# で書く - タイダログ](https://taidalog.hatenablog.com/entry/2023/01/31/080000)
	- [GitHub - taidalog/FSharp-Cmdlet-Study: Studying note for creating PowerShell Cmdlets with F#. For both Windows PowerShell and PowerShell.](https://github.com/taidalog/FSharp-Cmdlet-Study)
- @2023 [krymtkts - F#でコマンドレットを書いてる pt.14](https://krymtkts.github.io/posts/2023-03-05-writing-cmdlet-in-fsharp-pt14)
- @2014 [F#でPowerShellのカスタムコマンドレットを作ってみた #PowerShell - Qiita](https://qiita.com/minfuk/items/e3562d84b4c2fb460b2d)
