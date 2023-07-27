[[dotNET]]

- [カスタム .NET ランタイム ホストを作成する - .NET | Microsoft Learn](https://learn.microsoft.com/ja-jp/dotnet/core/tutorials/netcore-hosting)
- [Write a custom .NET runtime host - .NET | Microsoft Learn](https://learn.microsoft.com/en-us/dotnet/core/tutorials/netcore-hosting)

# .NET Core 3.0以降
- @2019 [2019年10月版 .NET Coreが動くまで - Qiita](https://qiita.com/yaegaki/items/245709cacc956e9d55aa)
- @2017 [主に技術日記: .NET Coreが動くまで](http://yfakariya.blogspot.com/2017/03/net-core.html)

- [samples/core/hosting at main · dotnet/samples · GitHub](https://github.com/dotnet/samples/tree/main/core/hosting)
- [samples/readme.md at 97a47512f2df268b2c3f4cdd0b31092f3b49514d · dotnet/samples · GitHub](https://github.com/dotnet/samples/blob/97a47512f2df268b2c3f4cdd0b31092f3b49514d/core/hosting/HostWithHostFxr/readme.md#L11)[]

```
$ dotnet list reference
プロジェクト参照
--------
src/NativeHost/*.csproj
src/DotNetLib/*.csproj
```

```xml
  <ItemGroup>
    <ClInclude Include="inc.vs\nethost.h" />
    <ClInclude Include="inc\coreclr_delegates.h" />
    <ClInclude Include="inc\hostfxr.h" />
  </ItemGroup>
```
 
## nethost
> `nethost`は`hostfxr`のパスを取得するためだけのライブラリです
- libnethost.lib
	- C:/Program Files/dotnet/packs/Microsoft.NETCore.App.Host.win-x64/7.0.5/runtimes/win-x64/native/libnethost.lib
- nethost.dll
- [`libnethost.lib` appears to be built with LTCG, making it unusable with non-MSVC toolchains · Issue #71056 · dotnet/runtime · GitHub](https://github.com/dotnet/runtime/issues/71056)

- https://www.nuget.org/packages/runtime.win-x86.Microsoft.NETCore.DotNetAppHost/3.0.1
- [.NET Package Maintenance (deprecation) · Issue #217 · dotnet/announcements · GitHub](https://github.com/dotnet/announcements/issues/217)

## hostfxr 
- get_hostfxr_path
- `C:/Program Files/dotnet/host/fxr/7.0.5/hostfxr.dll`

# .NET Core 3.0 より前
- [`coreclrhost.h`](https://github.com/dotnet/runtime/blob/main/src/coreclr/hosts/inc/coreclrhost.h)

# CoreCLR
> ホスティング API は、その名の通り CoreCLR（.NET Core のランタイム）をプロセスにロードして、実行するための API です。.NET Core のプログラムを実行する場合、このホスティング API を何らかの形で実行する必要があります。

.NET Core の場合、以下の 4 つの関数が定義されています。ここで、文字列は、Windows の場合は ANSI、それ以外の場合は UTF-8 で渡します。

## coreclr_initialize
## coreclr_shutdown
## coreclr_create_delegate
## coreclr_execute_assembly
# app
- [CefSharpでカスタムWebブラウザを作る - Qiita](https://qiita.com/masahiro-furuichi/items/ff3a1abf25a64cef7cdd)
