[[VT100]] と同じ？

- [GitHub - JustWhit3/osmanip: A cross-platform library for output stream manipulation using ANSI escape sequences.](https://github.com/JustWhit3/osmanip)

- [GitHub - JustWhit3/osmanip: A library for output stream manipulation using ANSI escape sequences.](https://github.com/JustWhit3/osmanip)
-
- [ANSI escape code - Wikipedia](https://en.wikipedia.org/wiki/ANSI_escape_code)
- [ANSI Escape Sequence](https://paulschou.com/tools/ansi/escape.html)
- [Terminal Escape Code Zen](https://www.askapache.com/linux/zen-terminal-escape-codes/)
- [ターミナルのechoやprintfに256色で色をつける 完全版 - vorfee's Tech Blog](https://vorfee.hatenablog.jp/entry/2015/03/17/173635)

# ANSI
- @2017 [ANSIエスケープシーケンス チートシート - Qiita](https://qiita.com/PruneMazui/items/8a023347772620025ad6)
- [ANSI escape code - Wikipedia](https://en.wikipedia.org/wiki/ANSI_escape_code)

# Control Sequence Introducer (CSI)
`\e[`

# C
## Linux
```c
#include <stdio.h>
#include <unistd.h>
int main(int argc, char *argv[]) { 
	if (isatty(fileno(stdout))) { 
		fputs("Detected a TTY\n", stderr);
		fputs("\033[31mRED \033[32mGREEN \033[34mBLUE\033[0m\n", stdout); 
	} else { 
		fputs("Not a TTY\n", stderr); 
	} 
}
```

## Windows
- [Windows向けのプログラムでANSIエスケープシーケンスを使うには - Qiita](https://qiita.com/mod_poppo/items/2ff384530c6f3215c635)

```c
// stream に対してANSIエスケープシーケンスを有効化
// 成功すれば true, 失敗した場合は false を返す 
bool enable_virtual_terminal_processing(FILE *stream) { 
	HANDLE handle = (HANDLE)_get_osfhandle(_fileno(stream)); 
	DWORD mode = 0;
	if (!GetConsoleMode(handle, &mode)) { 
		// 失敗 
		return false; 
	} 
	if (!SetConsoleMode(handle, mode | ENABLE_VIRTUAL_TERMINAL_PROCESSING)) { 
		// 失敗 
		// 古いWindowsコンソールの場合は GetLastError() == ERROR_INVALID_PARAMETER
		return false; 
	} 
	return true; 
}
```

# 色を変える
- [bash:tip_colors_and_formatting - FLOZz' MISC](https://misc.flogisoft.com/bash/tip_colors_and_formatting)

> `\e`はキーボードのESCキーを表しており、`\e`の代わりに`\033`（8進数形式のESC）や`\0x1b`、`\0x1B`、`\x1b`、`\x1B`

```
\e[31m

# 31: 色
# m: 終了
```

# カーソル移動
- [ANSIエスケープシーケンス チートシート - Qiita](https://qiita.com/PruneMazui/items/8a023347772620025ad6)

# 画面制御
- [付録　エスケープシーケンス　プログラミング](https://www.ns.kogakuin.ac.jp/~cu40887/handouts/escape.html)
- [画面をクリアする - Windows Console | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/console/clearing-the-screen)

```
\e[2J

# 2J: 画面クリア
```

```
\e[K

# K: カーソル位置から右をクリア
```

# ScreenSize
- [console - Getting terminal size in c for windows? - Stack Overflow](https://stackoverflow.com/questions/6812224/getting-terminal-size-in-c-for-windows)

# Scroll



