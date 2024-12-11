- [デバッガの使用  |  Android オープンソース プロジェクト  |  Android Open Source Project](https://source.android.com/docs/core/tests/debug/gdb?hl=ja)

# gdbserver

- [Attaching GDB to Android apps' native libraries · GitHub](https://gist.github.com/sekkr1/6adf2741ed3bc741b53ab276d35fd047)
  `%ANDROID_HOME%\ndk\21.4.7075529\prebuilt\android-arm64\gdbserver\gdbserver`

# lldb

- [Tutorial — The LLDB Debugger](https://lldb.llvm.org/use/tutorial.html)

## lldb-server

- [Remote Debugging — The LLDB Debugger](https://lldb.llvm.org/use/remote.html)
- [はじめてのLLDB Android ARM64解析入門 - 株式会社Ninjastars 技術系ブログ](https://www.ninjastars-net.com/entry/2020/04/27/180000)

```
$ adb shell cat /data/local/tmp/lldb-server | run-as com.example.gl2handtrackOXR sh -c 'cat > /data/data/com.example.gl2handtrackOXR/lldb/bin/lldb-server && chmod 700 /data/data/com.example.gl2handtrackOXR/lldb/bin/lldb-server'
$ adb shell cat /data/local/tmp/start_lldb_server.sh | run-as com.example.gl2handtrackOXR sh -c 'cat > /data/data/com.example.gl2handtrackOXR/lldb/bin/start_lldb_server.sh && chmod 700 /data/data/com.example.gl2handtrackOXR/lldb/bin/start_lldb_server.sh'
Starting LLDB server: /data/data/com.example.gl2handtrackOXR/lldb/bin/start_lldb_server.sh /data/data/com.example.gl2handtrackOXR/lldb unix-abstract /com.example.gl2handtrackOXR-0 platform-1667219227646.sock "lldb process:gdb-remote packets"
```
