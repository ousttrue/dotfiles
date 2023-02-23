[[cmake]]

- [vscode-cmake-tools/kits.md at main · microsoft/vscode-cmake-tools · GitHub](https://github.com/microsoft/vscode-cmake-tools/blob/main/docs/kits.md)
- [CMake Kits — CMake Tools 1.4.0 documentation](https://vector-of-bool.github.io/docs/vscode-cmake-tools/kits.html)

```json
[
  {
    "name": "Clang 12.0.0 x86_64-pc-windows-msvc",
    "compilers": {
      "C": "C:\\Program Files\\LLVM\\bin\\clang.exe",
      "CXX": "C:\\Program Files\\LLVM\\bin\\clang++.exe"
    }
  },
  {
    "name": "Visual Studio Build Tools 2019 Release - amd64",
    "visualStudio": "43c71187",
    "visualStudioArchitecture": "x64",
    "preferredGenerator": {
      "name": "Visual Studio 16 2019",
      "platform": "x64",
      "toolset": "host=x64"
    }
  },
]
```

https://github.com/microsoft/vscode-cmake-tools
`src\kit.ts`
kit の種類毎に環境変数をセットするなど泥臭い処理をしている。

## User-local kits
`~/.local/share/CMakeTools/cmake-tools-kits.json`
`%LOCALAPPDATA%\CMakeTools\cmake-tools-kits.json`

 