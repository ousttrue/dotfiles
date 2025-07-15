# cmdlet output

cmdlet からは `object[]`

[比較演算子について - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.4)

```ps1
1..10 | where{ $_ % 2 }
```

```ps1
1..10 | ?{ $_ % 2 }
```

# exe output

外部コマンドからは `string` もしくは `string[]` が得られる

```ps1
# 常に string[] を得る(1行のときも)
$lines = @(git status --porcelain --branch)
```

# type

## -is

```ps1
"hoge" -is [string] # $true
"1" -is [int] # $false
1 -is [int] # $true
(gci)[0] -is [System.IO.DirectoryInfo]
```
