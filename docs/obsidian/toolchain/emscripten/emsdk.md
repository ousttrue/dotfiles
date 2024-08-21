https://emscripten.org/docs/tools_reference/emsdk.html

- https://github.com/emscripten-core/emsdk

- [Emscriptenの導入メモ(Windows) #Emscripten - Qiita](https://qiita.com/RYOSKATE/items/918f2fda3c6f20c7f6ba)

# emsdk.py

`.ps` や `.sh` はラッパー。

```sh
EMSDK_PY="%~dp0python\2.7.13.1_64bit\python-2.7.13.amd64\python.exe"
PYTHONHOME=
PYTHONPATH=

call %EMSDK_PY% "%~dp0\emsdk.py" %*
```

# emsdk install latest

`EMSDK_DIR/upstream`
`EMSDK_DIR/python`
`EMSDK_DIR/java`
`EMSDK_DIR/node`

# emsdk install activate

`.emscripten`

```py
import os
emsdk_path = os.path.dirname(os.getenv('EM_CONFIG')).replace('\\', '/')
NODE_JS = emsdk_path + '/node/18.20.3_64bit/bin/node.exe'
PYTHON = emsdk_path + '/python/3.9.2-nuget_64bit/python.exe'
JAVA = emsdk_path + '/java/8.152_64bit/bin/java.exe'
LLVM_ROOT = emsdk_path + '/upstream/bin'
BINARYEN_ROOT = emsdk_path + '/upstream'
EMSCRIPTEN_ROOT = emsdk_path + '/upstream/emscripten'
```

```
Resolving SDK alias 'latest' to '3.1.64'
Resolving SDK version '3.1.64' to 'sdk-releases-fd61bacaf40131f74987e649a135f1dd559aff60-64bit'
Setting the following tools as active:
   node-18.20.3-64bit
   python-3.9.2-nuget-64bit
   java-8.152-64bit
   releases-fd61bacaf40131f74987e649a135f1dd559aff60-64bit

Next steps:
- Consider running `emsdk activate` with --permanent or --system
  to have emsdk settings available on startup.
Adding directories to PATH:
PATH += %SMSDK_DIR%\emsdk
PATH += %SMSDK_DIR%\emsdk\upstream\emscripten

Setting environment variables:
EMSDK = %EMSDK_DIR%/emsdk
EMSDK_NODE = %EMSDK_DIR%\emsdk\node\18.20.3_64bit\bin\node.exe
EMSDK_PYTHON = %EMSDK_DIR%\emsdk\python\3.9.2-nuget_64bit\python.exe
JAVA_HOME = %EMSDK_DIR%\emsdk\java\8.152_64bit
The changes made to environment variables only apply to the currently running shell instance. Use the 'emsdk_env.bat' to re-enter this environment later, or if you'd like to register this environment permanently, rerun this command with the option --permanent.
```
