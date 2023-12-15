[クラスについて - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_classes?view=powershell-7.4)

```ps1
class Device {
    [string]$Brand
}
```

```ps1
New-Object CLASS_NAME
# もしくは
[CLASS_NAME]::new()
```

> PowerShell クラスをセッションでアンロードまたは再読み込みすることはできません
