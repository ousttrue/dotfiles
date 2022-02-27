#vscode

Debug Adapter Protocol
[https://microsoft.github.io/debug-adapter-protocol/ Official page for Debug Adapter Protocol]

	https://code.visualstudio.com/api/extension-guides/debugger-extension
 DebugAdapterExecutable `communicate via stdin/stdout`
	DebugAdapterServer `TCP`

#vscode

code:launch.json
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

[* The Mock Debug Extension]
https://code.visualstudio.com/api/extension-guides/debugger-extension
https://github.com/Microsoft/vscode-mock-debug

[Debug Adapter Protocol]
