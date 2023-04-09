-  [clang-format configurator](https://zed0.co.uk/clang-format-configurator/)

- [clang-format を イイ感じに設定する - def yasuharu519(self):](https://yasuharu519.hatenablog.com/entry/2015/12/13/210825)
- [clang-format を導入してカスタマイズした :: プログラマになりたい人生 — プログラマになりたいおじさんの日記](https://blog.takuchalle.dev/post/2018/04/26/setup_clang_format/)

`.clang-format`
```.clang-format
BasedOnStyle: LLVM
# AllowShortIfStatementsOnASingleLine: false
# AllowShortBlocksOnASingleLine: false
AllowShortFunctionsOnASingleLine: false
AccessModifierOffset: -4 
BreakBeforeBraces: Allman # かっこの位置
IndentCaseLabels: false # switch case
IndentWidth: 4
SortIncludes: false
UseTab: Never
ColumnLimit: 0
TabWidth: 4
```

# BasedOnStyle
`Mozlilla`

# vscode
`.vscode/settings.json`
```json
// 親フォルダに遡って .clang-formatを探す。project-rootにおいておくべし
"C_Cpp.clang_format_style": "file" 
```

# 新規
```
$ clang-format -style=llvm -dump-config > .clang-format
```
