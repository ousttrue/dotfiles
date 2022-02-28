clang-format
#vscode_c++

https://yasuharu519.hatenablog.com/entry/2015/12/13/210825

code:.clang-format
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

code:.vscode/settings.json
	"C_Cpp.clang_format_style": "file" // 親フォルダに遡って .clang-formatを探す。project-rootにおいておくべし

code:.clang-format
 ColumnLimit: 0
 TabWidth: 4


$ clang-format -style=llvm -dump-config > .clang-format
