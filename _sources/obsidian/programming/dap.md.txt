
`Debug Adapter Protocol`
[Official page for Debug Adapter Protocol](https://microsoft.github.io/debug-adapter-protocol/)

- [GitHub - vain0x/debug-adapter-examples: Examples of Debug Adapter Protocol (DAP) implementation](https://github.com/vain0x/debug-adapter-examples)
- [BOOK TECH | 【試し読みあり】Visual Studio Codeデバッグ技術](https://book-tech.com/books/b7e7bbb1-964a-4918-b02a-9597a3f82957)

# .vscode/launch.json
```json
{
     "version": "0.2.0",
     "configurations": [
         {
             "name": "MoonSharp Attach",
             "type": "moonsharp-debug", // debugger type. launch adapter exe
             "request": "attach",
             "debugServer": 41912,
         }
     ]
}
```

# The Mock Debug Extension
- https://code.visualstudio.com/api/extension-guides/debugger-extension
 DebugAdapterExecutable `communicate via stdin/stdout`
	DebugAdapterServer `TCP`
 
- https://github.com/Microsoft/vscode-mock-debug

# Python
- @2022 [VSCode + debugpy でPython CLIをターミナルから快適にデバッグする](https://zenn.dev/shun_kashiwa/articles/debug-python-cli-with-debugpy-vscode)

# nvim
[[nvim_dap]]