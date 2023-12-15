[[powershell]]

```ps1
$area = Invoke-WebRequest https://www.jma.go.jp/bosai/common/const/area.json
$json = ConvertFrom-Json $area.Content => PSCustomObject

Invoke-RestMethod と同じ

$hash = ConvertFrom-Json $area.Content -AsHashtable
$hash.keys
```

# ConvertFrom-Json
`from string` => `PSCustomObject`
[PSCustomObject について知りたかったことのすべて - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/scripting/learn/deep-dives/everything-about-pscustomobject?view=powershell-7.4&viewFallbackFrom=powershell-7.1)
[ConvertFrom-Json (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.utility/convertfrom-json?view=powershell-7.4)

```
# 意味的に似た感じに
Get-Date | Select-Object "*"
```

# ConvertTo-Json
[ConvertTo-Json (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.utility/convertto-json?view=powershell-7.4)

```

```