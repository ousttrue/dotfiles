
```ps1
dir * | % { *.GetType }

=> FileInfo / DirectoryInfo
```


# まとめて rename

search & rename
```powershell
Get-ChildItem -Recurse "*.pbf" | ForEach-Object {Move-Item $_ "$_.gz"}
```
