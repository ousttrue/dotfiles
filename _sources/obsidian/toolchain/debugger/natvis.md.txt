[[pdb]]

[C++ オブジェクトのカスタム ビューを作成する - Visual Studio (Windows) | Microsoft Learn](https://learn.microsoft.com/ja-jp/visualstudio/debugger/create-custom-views-of-native-objects?view=vs-2022)

- [The Natvis framework provides custom views for native C++ objects](https://code.visualstudio.com/docs/cpp/natvis)
- [Create custom views of C++ objects - Visual Studio (Windows) | Microsoft Learn](https://learn.microsoft.com/en-us/visualstudio/debugger/create-custom-views-of-native-objects?view=vs-2022)
- [STL/stl/debugger/STL.natvis at main · microsoft/STL · GitHub](https://github.com/microsoft/STL/blob/main/stl/debugger/STL.natvis)


- @2023 [C++&Visual Studio 便利なデバッグ変数情報の視覚化（natvis）と関数使用時の注意 - potisanのプログラミングメモ](https://potisan-programming-memo.hatenablog.jp/entry/2023/01/12/062155)
- @2020 [ブログズミ: [Visual Studio] .natvis/.natstepfilter をプロジェクトに追加してウォッチ・ステップインしやすくする](https://srz-zumix.blogspot.com/2020/05/visual-studio-natvisnatstepfilter.html)
- @2020 [組込 1 年目のエンジニアが開発環境を整備した話 - Qiita](https://qiita.com/utisam/items/dd8717e007326e360e41)
- @2014 [Fetching Title#n4u1](https://mariusbancila.ro/blog/2014/06/04/per-project-natvis-files-in-visual-studio-14/)

# C++TeamBlog
- [Project Support for Natvis - C++ Team Blog](https://devblogs.microsoft.com/cppblog/project-support-for-natvis/)
- @2021 [STL Visualizers on GitHub - C++ Team Blog](https://devblogs.microsoft.com/cppblog/stl-visualizers-on-github/)
- @2015 [Natvis support for Android debugging - C++ Team Blog](https://devblogs.microsoft.com/cppblog/natvis-support-for-android-debugging/)
- @2013 [Using Visual Studio 2013 to write maintainable native visualizations (natvis) - C++ Team Blog](https://devblogs.microsoft.com/cppblog/using-visual-studio-2013-to-write-maintainable-native-visualizations-natvis/)


# path

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

- @2015 [.natvisを使ってVisual Studioのデバッグを見やすくする - Qiita](https://qiita.com/bigengelt/items/91a4eff6a8385a30f6ae)

## sytem

`<VS Installation Folder>\Xml\Schemas\1033\natvis.xsd_`
`<VS Installation Folder>\Common7\Packages\Debugger\Visualizers_`

# 書式
## string
[デバッガーでの書式指定子 (C++) - Visual Studio (Windows) | Microsoft Learn](https://learn.microsoft.com/ja-jp/visualstudio/debugger/format-specifiers-in-cpp?view=vs-2022)

### std::u8string
```xml
<?xml version="1.0" encoding="utf-8"?>
<AutoVisualizer xmlns="http://schemas.microsoft.com/vstudio/debugger/natvis/2010">
  <Type Name="std::basic_string&lt;char8_t,*&gt;" Priority="High">
    <Intrinsic Name="size" Expression="_Mypair._Myval2._Mysize" />
    <Intrinsic Name="capacity" Expression="_Mypair._Myval2._Myres" />
    <!-- _BUF_SIZE = 16 / sizeof(char) &lt; 1 ? 1 : 16 / sizeof(char) == 16 -->
    <Intrinsic Name="bufSize" Expression="16" />
    <Intrinsic Name="isShortString" Expression="capacity() &lt; bufSize()" />
    <Intrinsic Name="isLongString" Expression="capacity() &gt;= bufSize()" />
    <DisplayString Condition="isShortString()">{_Mypair._Myval2._Bx._Buf,nas8}</DisplayString>
    <DisplayString Condition="isLongString()">{_Mypair._Myval2._Bx._Ptr,nas8}</DisplayString>
    <StringView Condition="isShortString()">_Mypair._Myval2._Bx._Buf,nas8</StringView>
    <StringView Condition="isLongString()">_Mypair._Myval2._Bx._Ptr,nas8</StringView>
    <Expand>
      <Item Name="[size]" ExcludeView="simple">size()</Item>
      <Item Name="[capacity]" ExcludeView="simple">capacity()</Item>
      <Item Name="[allocator]" ExcludeView="simple">_Mypair</Item>
      <ArrayItems>
        <Size>_Mypair._Myval2._Mysize</Size>
        <ValuePointer Condition="isShortString()">_Mypair._Myval2._Bx._Buf</ValuePointer>
        <ValuePointer Condition="isLongString()">_Mypair._Myval2._Bx._Ptr</ValuePointer>
      </ArrayItems>
    </Expand>
  </Type>
</AutoVisualizer>
```

## STL
- [STL/stl/debugger/STL.natvis at main · microsoft/STL · GitHub](https://github.com/microsoft/STL/blob/main/stl/debugger/STL.natvis#L172C17-L209C10)
### std::variant
- [visual c++ - How to display template parameter type name in natvis? - Stack Overflow](https://stackoverflow.com/questions/54458842/how-to-display-template-parameter-type-name-in-natvis)

```xml
    <Type
        Name="std::variant&lt;std::monostate,bool,float,*&gt;"
        Priority="High">
        <DisplayString Condition="_Which==0">{{null}}</DisplayString>
        <DisplayString Condition="_Which==1" Optional="true">{{bool}}</DisplayString>
        <DisplayString Condition="_Which==2" Optional="true">{{float}}</DisplayString>
        <DisplayString Condition="_Which==3" Optional="true">{{u8string}}</DisplayString>
        <DisplayString Condition="_Which==4" Optional="true">{{array}}</DisplayString>
        <DisplayString Condition="_Which==5" Optional="true">{{object}}</DisplayString>
        <Expand>
            <Item Name="which">_Which</Item>
            <Item Name="value0" Condition="_Which==0">null</Item>
            <Item Name="value1" Condition="_Which==1" Optional="true">std::get&lt;bool&gt;(*this)</Item>
            <Item Name="value2" Condition="_Which==2" Optional="true">std::get&lt;float&gt;()</Item>
            <Item Name="value3" Condition="_Which==3" Optional="true">std::get&lt;std::u8string&gt;()</Item>
            <Item Name="value4" Condition="_Which==4" Optional="true">[]</Item>
            <Item Name="value5" Condition="_Which==5" Optional="true">{{}}</Item>
        </Expand>
    </Type>
```

# libstc++

`compiler` を変えると `STL` の実装が変わる。
`NATVIS` も変わる。

- [https://source.chromium.org/chromium/chromium/src/+/main:tools/win/DebugVisualizers/libc++.natvis;drc=79b4f8b9d4a9dc7130463d2ca286f0b5b8e3d962](https://source.chromium.org/chromium/chromium/src/+/main:tools/win/DebugVisualizers/libc++.natvis;drc=79b4f8b9d4a9dc7130463d2ca286f0b5b8e3d962)

# libc++
- [Please consider shipping debugger visualizers for libstdc++/libc++ · Issue #3423 · microsoft/vscode-cpptools · GitHub](https://github.com/microsoft/vscode-cpptools/issues/3423)
- [Contributing debug visualizers for libc++ - Runtimes / C++ - LLVM Discussion Forums](https://discourse.llvm.org/t/contributing-debug-visualizers-for-libc/51956/4)
- [build/config/c++/libc++.natvis - chromium/src - Git at Google](https://chromium.googlesource.com/chromium/src/+/HEAD/build/config/c++/libc++.natvis)
