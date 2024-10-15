[[pdb]]
[[natvis_msvcp]] [[natvis_libc++]] [[natvis_libstdc++]]

```xml
<?xml version="1.0" encoding="utf-8"?>
<AutoVisualizer xmlns="http://schemas.microsoft.com/vstudio/debugger/natvis/2010">
</AutoVisualizer>
```

[Create custom views of C++ objects - Visual Studio (Windows) | Microsoft Learn](https://learn.microsoft.com/en-us/visualstudio/debugger/create-custom-views-of-native-objects?view=vs-2022)

- [C++ オブジェクトのカスタム ビューを作成する | Microsoft Learn](https://learn.microsoft.com/ja-jp/visualstudio/debugger/create-custom-views-of-native-objects?view=vs-2022)

- [Visual Studio Code documentation search](https://code.visualstudio.com/Search?q=natvis)

- [STL/stl/debugger/STL.natvis at main · microsoft/STL · GitHub](https://github.com/microsoft/STL/blob/main/stl/debugger/STL.natvis)

- @2023 [C++&Visual Studio 便利なデバッグ変数情報の視覚化（natvis）と関数使用時の注意 - potisanのプログラミングメモ](https://potisan-programming-memo.hatenablog.jp/entry/2023/01/12/062155)
  `struct`

- @2020 [ブログズミ: [Visual Studio] .natvis/.natstepfilter をプロジェクトに追加してウォッチ・ステップインしやすくする](https://srz-zumix.blogspot.com/2020/05/visual-studio-natvisnatstepfilter.html)
- @2020 [組込 1 年目のエンジニアが開発環境を整備した話 - Qiita](https://qiita.com/utisam/items/dd8717e007326e360e41)
- @2014 [Fetching Title#n4u1](https://mariusbancila.ro/blog/2014/06/04/per-project-natvis-files-in-visual-studio-14/)
- @2015 [.natvisを使ってVisual Studioのデバッグを見やすくする - Qiita](https://qiita.com/bigengelt/items/91a4eff6a8385a30f6ae)

## std::variant

[visual c++ - How to display template parameter type name in natvis? - Stack Overflow](https://stackoverflow.com/questions/54458842/how-to-display-template-parameter-type-name-in-natvis)

# C++TeamBlog

- [Project Support for Natvis - C++ Team Blog](https://devblogs.microsoft.com/cppblog/project-support-for-natvis/)
- @2021 [STL Visualizers on GitHub - C++ Team Blog](https://devblogs.microsoft.com/cppblog/stl-visualizers-on-github/)
- @2015 [Natvis support for Android debugging - C++ Team Blog](https://devblogs.microsoft.com/cppblog/natvis-support-for-android-debugging/)
- @2013 [Using Visual Studio 2013 to write maintainable native visualizations (natvis) - C++ Team Blog](https://devblogs.microsoft.com/cppblog/using-visual-studio-2013-to-write-maintainable-native-visualizations-natvis/)

# format

> 関数の評価や副作用は許可されません

## debugger function

- [デバッガーでの式 - Visual Studio (Windows) | Microsoft Learn](https://learn.microsoft.com/ja-jp/visualstudio/debugger/expressions-in-the-debugger?view=vs-2022#BKMK_Using_debugger_intrinisic_functions_to_maintain_state)

## context

- [デバッガーでのコンテキスト演算子 (C++) | Microsoft Learn](https://learn.microsoft.com/ja-jp/visualstudio/debugger/context-operator-cpp?view=vs-2022)

## Schema

- [The Natvis framework provides custom views for native C++ objects](https://code.visualstudio.com/docs/cpp/natvis)

# Type

```xml
<Type Name="std::string"> // typedef なのでマッチしない
</Type>

<TYpe Name="std::basic_string&lt;char,*&gt;"> // template の具体型指定と *
</Type>
```

## Name

- template 引数
  - `\*``: wildcard
  - `$T1`、`$T2`

## DisplayString

- 中かっこ内のすべてのものは式
- 二重中かっこ (`{{` または `}}`) を使用して中かっこをエスケープ

```xml
<Type Name="CPoint">
  <DisplayString>{{x={x} y={y}}}</DisplayString>
</Type>
```

[デバッガーでの書式指定子 (C++) | Microsoft Learn](https://learn.microsoft.com/ja-jp/visualstudio/debugger/format-specifiers-in-cpp?view=vs-2022#BKMK_Visual_Studio_2012_format_specifiers)

## StringView

テキストビジュアライザー

```xml
<Type Name="ATL::CStringT&lt;wchar_t,*&gt;">
  <DisplayString>{m_pszData,su}</DisplayString>
  <StringView>m_pszData,su</StringView>
</Type>
```

## Expand

子要素のビジュアライズ。

## Expand > Item

```xml
<Type Name="CRect">
  <DisplayString>{{top={top} bottom={bottom} left={left} right={right}}}</DisplayString>
  <Expand>
    <Item Name="Width">right - left</Item>
    <Item Name="Height">bottom - top</Item>
  </Expand>
</Type>
```

## Expand > ArrayItems

```xml
<Type Name="std::vector&lt;*&gt;">
  <DisplayString>{{size = {_Mylast - _Myfirst}}}</DisplayString>
  <Expand>
    <Item Name="[size]">_Mylast - _Myfirst</Item>
    <Item Name="[capacity]">(_Myend - _Myfirst)</Item>
    <ArrayItems>
      <Size>_Mylast - _Myfirst</Size>
      <ValuePointer>_Myfirst</ValuePointer>
    </ArrayItems>
  </Expand>
</Type>
```

## 属性

### Optional

失敗した場合無視される

### Conditional

条件が一致した場合のみ

### IncludeView

可視性

### ExcludeView

可視性

# 配置場所

## project

```json5
// launch.json
        {
            "name": "Debug",
            "type": "cppvsdbg",
            "request": "launch",
            "preLaunchTask": "DebugBuild",
            "program": "${workspaceRoot}/testapp.exe",
            "cwd": "${workspaceRoot}",
            "visualizerFile": "${workspaceRoot}/dlang_cpp.natvis",
        },

```

## cmake

- [ブログズミ: [Visual Studio] .natvis/.natstepfilter をプロジェクトに追加してウォッチ・ステップインしやすくする](https://srz-zumix.blogspot.com/2020/05/visual-studio-natvisnatstepfilter.html)

```cmake
function(iutest_add_executable name)
if (MSVC)
  add_executable(${name} ${ARGN} ${IUTEST_ROOT_DIR}/tools/VisualStudio/Visualizers/iutest.natvis)
else()
  add_executable(${name} ${ARGN})
endif()
endfunction()
```

## user

`%USERPROFILE%\Documents/Visual Studio 2013/Visualizers/*.natvis`
`%USERPROFILE%\Documents\Visual Studio 2022\Visualizer/*.natvis`

## sytem

`<VS Installation Folder>\Xml\Schemas\1033\natvis.xsd_`
`<VS Installation Folder>\Common7\Packages\Debugger\Visualizers_`

# Natvis 診断

VSCode ?
