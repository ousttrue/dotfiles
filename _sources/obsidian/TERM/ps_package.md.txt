[PackageManagement Module - PowerShell | Microsoft Learn](https://learn.microsoft.com/en-us/powershell/module/packagemanagement/?view=powershellget-2.x)

[NuGet のブートストラップ - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/gallery/how-to/getting-support/bootstrapping-nuget?view=powershellget-3.x)

- @2020 [[Powershell] Nugetでインストールしたパッケージの読み込みサポート #PowerShell - Qiita](https://qiita.com/ktz_alias/items/7306f0a44f0c051fa19d)
- @2016 [Windows PowerShell でパッケージ管理(Package Management)してみる - はしくれエンジニアもどきのメモ](https://cartman0.hatenablog.com/entry/2016/03/20/233719)

# Find-PackageProvider
```powershell
> Find-PackageProvider | Select-Object "Name"

Name
----
PowerShellGet
ChocolateyGet
WinGet
ContainerIma…
NanoServerPa…
Chocolatier
DotNetGlobal…
Homebrew```

# Install-Package
https://learn.microsoft.com/ja-jp/powershell/module/packagemanagement/install-package?view=powershellget-2.x

## Nuget
`-Scope Administrator` => 
`C:\Program Files\PackageManagement\NuGet\Packages`

`-Scope CurrentUser` => `C:\Users\ousttrue\AppData\Local\PackageManagement\NuGet\Packages`

# Get-PackageProvider
```powershell
> Get-PackageProvider

Name                     Version          DynamicOptions
----                     -------          --------------
NuGet                    3.0.0.1          Destination, ExcludeVersion, Scope, SkipDependencies, Headers, FilterOnTag, Contains, AllowPrereleaseVer…
PowerShellGet            2.2.5.0          PackageManagementProvider, Type, Scope, AllowClobber, SkipPublisherCheck, InstallUpdate, NoPathUpdate, A…
```
