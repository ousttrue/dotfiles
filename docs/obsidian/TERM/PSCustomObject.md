[[powershell]]

- [PSCustomObject について - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_pscustomobject?view=powershell-7.4)
- [PSCustomObject について知りたかったことのすべて - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/scripting/learn/deep-dives/everything-about-pscustomobject?view=powershell-7.4)

# hashtable
[[ps_hashtable]]

```powershell
$myObject = [PSCustomObject]@{
    Name     = 'Kevin'
    Language = 'PowerShell'
    State    = 'Texas'
}

$myHashtable = @{
    Name     = 'Kevin'
    Language = 'PowerShell'
    State    = 'Texas'
}
$myObject = [pscustomobject]$myHashtable

$hashtable = @{}
foreach( $property in $myobject.psobject.properties.name )
{
    $hashtable[$property] = $myObject.$property
}
```

# json

```powershell
$myObject | ConvertTo-Json -depth 1 | Set-Content -Path $Path
$myObject = Get-Content -Path $Path | ConvertFrom-Json
```

# Select-Object
