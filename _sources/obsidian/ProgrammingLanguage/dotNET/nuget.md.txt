[NuGet とは何か。またどのような働きをするのか | Microsoft Learn](https://learn.microsoft.com/ja-jp/nuget/what-is-nuget)

# Version
## 3.0
@2015
## 2.0


# nuget.exe
[NuGet CLI を使用して NuGet パッケージを管理する | Microsoft Learn](https://learn.microsoft.com/ja-jp/nuget/consume-packages/install-use-packages-nuget-cli)

# dotnet

```
> dotnet nuget locals all --list
http-cache: %USERPROFILE%\AppData\Local\NuGet\v3-cache
global-packages: %USERPROFILE%\.nuget\packages\
temp: %USERPROFILE%\AppData\Local\Temp\NuGetScratch
plugins-cache: %USERPROFILE%\AppData\Local\NuGet\plugins-cache
```

# powershell
- `v2` @2020 [[Powershell] Nugetでインストールしたパッケージの読み込みサポート #PowerShell - Qiita](https://qiita.com/ktz_alias/items/7306f0a44f0c051fa19d)
- `v2` @2018 [[PowerShell]NuGetからパッケージをダウンロードする #PowerShell - Qiita](https://qiita.com/HAGITAKO/items/05328043d599964c485d)
- [GitHub - senkousya/PS\_startClosedXMLOnPowershell: 🔰ClosedXMLをPowershellから触ってみる](https://github.com/senkousya/PS_startClosedXMLOnPowershell)

## Install-Package : Dependency loop detected
- `-verbose`
- `-skipDependencies`
[powershell - install-package : Dependency loop detected for package 'Microsoft.Data.Sqlite' - Stack Overflow](https://stackoverflow.com/questions/58351619/install-package-dependency-loop-detected-for-package-microsoft-data-sqlite)

[Install-Package : Dependency loop detected for package 'Microsoft.SqlServer.SqlManagementObjects' - Microsoft Q&A](https://learn.microsoft.com/en-us/answers/questions/1192303/install-package-dependency-loop-detected-for-packa)
