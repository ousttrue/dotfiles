[[dotNET]]

[F#リファレンス](https://midoliy.com/content/fsharp/index.html)
[F# チュートリアル |.NET | Hello World を 5 分で](https://dotnet.microsoft.com/ja-jp/learn/languages/fsharp-hello-world-tutorial/create)

- @2022 [F#を始める時に役立つ資料 #.NET - Qiita](https://qiita.com/kxkx5150/items/febceda472f6e3e356a5)
- @2021 [F# でのfsxベースの開発 - なーんだ、ただの水たまりじゃないか](https://karino2.github.io/2021/02/06/fsx_eval_based_dev.html)
- @2016 [F# をLearning F# をかじりながら学んでみる - tech.guitarrapc.cóm](https://tech.guitarrapc.com/entry/2016/09/04/054641)
- [krymtkts - Tags - fsharp](https://krymtkts.github.io/tags/fsharp.html)

# Version
## 8
- @2023 [Announcing F# 8 - .NET Blog](https://devblogs.microsoft.com/dotnet/announcing-fsharp-8/)
- @2023 [F# 8 のリリースで F# が最強の言語になってしまった件 #.NET - Qiita](https://qiita.com/262144/items/01a3023612116180278e)

# open
- @2021 [F#でNuGetのライブラリを使う - なーんだ、ただの水たまりじゃないか](https://karino2.github.io/2021/01/16/ionide_nuget.html)
- @2020 [F# Interactive(fsi)で新しいパッケージマネジメントの記法を使う。ついでにCanopyで遊ぶ。 #.NETCore - Qiita](https://qiita.com/happy_packet/items/41d6688f8ddf3b953508)

## nuget
### glfw
current に `glfw.dll` を配置
```fsx
#r "nuget: FsGlfw"
printfn "init: %d" (Glfw3.init ())
````

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
