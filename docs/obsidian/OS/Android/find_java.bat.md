[[Android]]

[[d8]] の実行時に、 `JAVA_HOME` を設定しているのに
`no suitable java...`
が出た。
以下のようにハードコーディングで避ける w
```bat
set java_exe=PATH_TO_JAVA_EXE
```
