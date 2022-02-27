clangd
#vscode

https://clangd.llvm.org/

[* compile_commands.json または compile_flags.txt]
	https://clang.llvm.org/docs/JSONCompilationDatabase.html
	https://uchan.hateblo.jp/entry/2018/12/29/104132

cmake + ninja => COMPILE_EXPORT

llvm windows build/bin/cland.exe

code:setting.json
   "cmake.configureArgs": [
       "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
   ],
   "cmake.generator": "Ninja",

code:settings.json
    // clangd
    "C_Cpp.intelliSenseEngine": "Disabled",
    "clangd.arguments": [
        "--compile-commands-dir=${workspaceFolder}/build"
    ],
    "clangd.path": "${env:APPDATA}\\Code\\User\\globalStorage\\llvm-vs-code-extensions.vscode-clangd\\install\\12.0.0\\clangd_12.0.0\\bin\\clangd.exe",
