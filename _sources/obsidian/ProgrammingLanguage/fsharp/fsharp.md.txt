[[dotNET]]

[F# 関連のドキュメント - 概要、チュートリアル、リファレンス。 | Microsoft Learn](https://learn.microsoft.com/ja-jp/dotnet/fsharp/)

- [F# のコーディング規則 - .NET | Microsoft Learn](https://learn.microsoft.com/ja-jp/dotnet/fsharp/style-guide/conventions)
  - [F# スタイル ガイド | Microsoft Learn](https://learn.microsoft.com/ja-jp/dotnet/fsharp/style-guide/#five-principles-of-good-f-code)
- [F# のモジュールと変換関数の命名について - タイダログ](https://taidalog.hatenablog.com/entry/2023/02/28/235500)

- @2022 [F#を始める時に役立つ資料 #.NET - Qiita](https://qiita.com/kxkx5150/items/febceda472f6e3e356a5)
- @2021 [F# でのfsxベースの開発 - なーんだ、ただの水たまりじゃないか](https://karino2.github.io/2021/02/06/fsx_eval_based_dev.html)
- @2016 [F# をLearning F# をかじりながら学んでみる - tech.guitarrapc.cóm](https://tech.guitarrapc.com/entry/2016/09/04/054641)
- [krymtkts - Tags - fsharp](https://krymtkts.github.io/tags/fsharp.html)

# Version

## 8

- @2023 [Announcing F# 8 - .NET Blog](https://devblogs.microsoft.com/dotnet/announcing-fsharp-8/)
- @2023 [F# 8 のリリースで F# が最強の言語になってしまった件 #.NET - Qiita](https://qiita.com/262144/items/01a3023612116180278e)

# syntax

- [F# のツアー - .NET | Microsoft Learn](https://learn.microsoft.com/ja-jp/dotnet/fsharp/tour)

## 関数

[関数 - F# | Microsoft Learn](https://learn.microsoft.com/ja-jp/dotnet/fsharp/language-reference/functions/)

```fsharp
> let f x = x + 1;;
val f: x: int -> int
> f 1;;
val it: int = 2

> let f (x: int): int = x + 1;;
> let f (x: int) (y: int): int = x + y;;
```

## class

`.NET オブジェクト型`
[F# のクラス | Microsoft Learn](https://learn.microsoft.com/ja-jp/dotnet/fsharp/language-reference/classes)

```fsharp
// constructor 1
type MyClass1(x: int, y: int) =
	do printfn "%d %d" x y

    // constructor 2
	new() = MyClass1(0, 0)
```

# cli

[.NET Core F#でコマンドラインツールを作ろう · GitHub](https://gist.github.com/sheepla/4fcb01d4ed7ae682817edd83f403b8c5)

```sh
> dotnet new console -lang=F#
```

# open

- @2021 [F#でNuGetのライブラリを使う - なーんだ、ただの水たまりじゃないか](https://karino2.github.io/2021/01/16/ionide_nuget.html)
- @2020 [F# Interactive(fsi)で新しいパッケージマネジメントの記法を使う。ついでにCanopyで遊ぶ。 #.NETCore - Qiita](https://qiita.com/happy_packet/items/41d6688f8ddf3b953508)

## nuget

### glfw

current に `glfw.dll` を配置

```fsx
#r "nuget: FsGlfw"
printfn "init: %d" (Glfw3.init ())
```

# load

```fs
#load "FileName.fs"
open ModuleName // import symbols
```

# formatter

[GitHub - fsprojects/fantomas: FSharp source code formatter](https://github.com/fsprojects/fantomas)

# languager server

## FsAutoComplete

[GitHub - fsharp/FsAutoComplete: F# language server using Language Server Protocol](https://github.com/fsharp/FsAutoComplete)

## fsharp-language-server

`dot6?`

```
dotnet new console -lang F# -o MyFSharpApp -f net6.0
```

@202308 7.0だと動かない
@2022 で更新止まっている

# Powershell

[[powershell]]

- @2022 [飼い主, F# の環境構築したってよ](https://zenn.dev/terasakisatoshi/scraps/df990c656da85c)
- @2021 [PowerShell 片手に F# を始める - タイダログ](https://taidalog.hatenablog.com/entry/2021/11/26/183000)

# gpu

- [GitHub - w0lya/fsharp-3d-and-gamedev: Resources on 3D Graphics Programming and Game Development in F#](https://github.com/w0lya/fsharp-3d-and-gamedev)

## WGPU.FSharp.Native

- [NuGet Gallery | WGPU.FSharp.Native 0.12.0.2](https://www.nuget.org/packages/WGPU.FSharp.Native/)
- [FSharp](https://github.com/ginger-code/WGPU.Native/tree/main/examples/FSharp)

```xml
<PackageReference Include="Silk.NET.GLFW" Version="2.19.0" />
<PackageReference Include="WGPU.FSharp.Native" Version="0.12.0.2" />
```

## sharpvk

- [NuGet Gallery | SharpVk 0.3.4](https://www.nuget.org/packages/SharpVk/0.3.4)

## OpenGL

- [Windows 10でOpenGLをGLFWとGLEW、GLMで開発する環境を作りWindowを表示する | 測度ゼロの抹茶チョコ](https://matcha-choco010.net/2020/03/29/opengl-glfw-window/)
- [F#にOpenGLの歯車デモを移植 #C - Qiita](https://qiita.com/7shi/items/efdf0ae04a24bc1b7623)

# TUI

- [GitHub - DieselMeister/Terminal.Gui.Elmish: An elmish wrapper around Miguel de Icaza's 'Gui.cs' https://github.com/migueldeicaza/gui.cs including a fable like view DSL.](https://github.com/DieselMeister/Terminal.Gui.Elmish)
  - [GitHub - gui-cs/Terminal.Gui: Cross Platform Terminal UI toolkit for .NET](https://github.com/gui-cs/Terminal.Gui)

# error

## fsproj error MSB4020

```xml
  <Import Project="$(FSharpTargetsPath)" />
```

# tsting

[F#入門](http://fsharpintro.net/fsunit.html)

# code generation

[GitHub - gircore/gir.core: A C# binding generator for GObject based libraries providing a C# friendly API surface](https://github.com/gircore/gir.core)
