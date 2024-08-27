`conhost` を代替する新しい API
Windows10 `1903`
from `17733` `1809`
[[windows_terminal]]

```
+----+ W       R +------+  +-----+
|host| ===Input=>|conpty|=>|child|
|    | <=Output= |      |<=|     |
+----+ R       W +------+  +-----+
```

> Windows 疑似コンソールは、疑似コンソール、ConPTY、または Windows PTY とも呼ばれ

# Articles

- @2018 [Windows Command-Line: Introducing the Windows Pseudo Console (ConPTY) - Windows Command Line](https://devblogs.microsoft.com/commandline/windows-command-line-introducing-the-windows-pseudo-console-conpty/)
- @2016 [24-bit Color in the Windows Console! - Windows Command Line](https://devblogs.microsoft.com/commandline/24-bit-color-in-the-windows-console/)

# Host

## CreatePipe + CreatePseudoConsole + CreateProcess

```c++
struct Pty {
  HPCON Console;
  HANDLE ReadPipe;
  HANDLE WritePipe;
};

Pty CreatePty(const COORD &size) {
  Pty pty = {0};

  HANDLE inPipeRead{INVALID_HANDLE_VALUE};
  if (!CreatePipe(&inPipeRead, &pty.WritePipe, NULL, 0)) {
    return {};
  }

  HANDLE outPipeWrite{INVALID_HANDLE_VALUE};
  if (!CreatePipe(&pty.ReadPipe, &outPipeWrite, NULL, 0)) {
    CloseHandle(inPipeRead);
    CloseHandle(pty.WritePipe);
    return {};
  }

  // Create the Pseudo Console of the required size, attached to the PTY-end
  // of the pipes
  auto hr =
      CreatePseudoConsole(size, inPipeRead, outPipeWrite, 0, &pty.Console);
  // Note: We can close the handles to the PTY-end of the pipes here
  // because the handles are dup'ed into the ConHost and will be released
  // when the ConPTY is destroyed.
  if (INVALID_HANDLE_VALUE != outPipeWrite) {
    CloseHandle(outPipeWrite);
  }
  if (INVALID_HANDLE_VALUE != inPipeRead) {
    CloseHandle(inPipeRead);
  }
  if (FAILED(hr)) {
    CloseHandle(pty.WritePipe);
    CloseHandle(pty.ReadPipe);
    return {};
  }

  assert(pty.Console);
  return pty;
}
```

### Redirect

[[fork]]

- [リダイレクトされた入出力を使用した子プロセスの作成 - Win32 apps | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows/win32/procthread/creating-a-child-process-with-redirected-input-and-output)
- [プロセス間通信ではまる: なひたふJTAG日記](http://nahitafu.cocolog-nifty.com/nahitafu/2008/04/post_bde3.html)
  > WaitForSingleObjectというのがありますが、これはパイプは監視できない
- [コマンドライン起動 « モルタルコのプログラマ日記](https://denasu.com/blog/2000/05/diary145)
  > PeekNamedPipe

### ConPty

- [疑似コンソール セッションの作成 - Windows Console | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows/console/creating-a-pseudoconsole-session)

## Read

```
// thread で drain
```

## Write

```
// 普通に書き込み
```

## GetSize

```c++
// Determine required size of Pseudo Console
COORD consoleSize{};
CONSOLE_SCREEN_BUFFER_INFO csbi{};
HANDLE hConsole{ GetStdHandle(STD_OUTPUT_HANDLE) };
if (GetConsoleScreenBufferInfo(hConsole, &csbi))
{
	consoleSize.X = csbi.srWindow.Right - csbi.srWindow.Left + 1;
	consoleSize.Y = csbi.srWindow.Bottom - csbi.srWindow.Top + 1;
}
```

## Resize の通知

```c
    COORD size;
    size.X = GetViewWidth(e.Source);
    size.Y = GetViewHeight(e.Source);
    // Call pseudoconsole API to inform buffer dimension update
    ResizePseudoConsole(m_hpc, size);
```

## API

### CreatePseudoConsole

- [CreatePseudoConsole function - Windows Console | Microsoft Docs](https://docs.microsoft.com/en-us/windows/console/createpseudoconsole)
- [Using the High-Level Input and Output Functions - Windows Console | Microsoft Docs](https://docs.microsoft.com/en-us/windows/console/using-the-high-level-input-and-output-functions)
- [Creating a Pseudoconsole session - Windows Console | Microsoft Docs](https://docs.microsoft.com/en-us/windows/console/creating-a-pseudoconsole-session#preparing-for-creation-of-the-child-process)
- [Console documentation - Windows Console | Microsoft Docs](https://docs.microsoft.com/en-us/windows/console/)
- [Using the Console - Windows Console | Microsoft Docs](https://docs.microsoft.com/en-us/windows/console/using-the-console)

# Child

## Read

### EscapeSequence

`ENABLE_VIRTUAL_TERMINAL_INPUT`

### RawMode

- [SetConsoleMode 関数 - Windows Console | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/console/setconsolemode)
- [入力バッファー イベントの読み取り - Windows Console | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/console/reading-input-buffer-events)

### Resize Event

## Write

[Windowsのコマンドプロンプトで色付き文字やUnicodeを表示する。](https://zenn.dev/s3pt3mb3r/articles/daefc84513f832)

### EscapeSequence

[[vt100]]

`ENABLE_VIRTUAL_TERMINAL_PROCESSING`
`ENABLE_WRAP_AT_EOL_OUTPUT`

- [SetConsoleMode 関数 - Windows Console | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/console/setconsolemode)
- [End of line cursor position differences when app is run in Windows Terminal · Issue #8312 · microsoft/terminal · GitHub](https://github.com/microsoft/terminal/issues/8312)

- [Windows向けのプログラムでANSIエスケープシーケンスを使うには - Qiita](https://qiita.com/mod_poppo/items/2ff384530c6f3215c635)
- [Console Virtual Terminal Sequences - Windows Console | Microsoft Learn](https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences)
- [コンソールの仮想ターミナル シーケンス - Windows Console | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/console/console-virtual-terminal-sequences)

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

# Impl

`cs`

- [GitHub - akobr/ConPty.Sample: Example of usage pseudo console in C#.](https://github.com/akobr/ConPty.Sample)
- [GitHub - waf/MiniTerm: Experiments with the new Windows PTY APIs](https://github.com/waf/MiniTerm)

`c`

- [GitHub - Biswa96/XConPty: Experiments with Pseudo Console in Windows 10](https://github.com/Biswa96/XConPty)

`cpp`

- [terminal/samples/ConPTY/EchoCon at main · microsoft/terminal · GitHub](https://github.com/microsoft/terminal/tree/master/samples/ConPTY/EchoCon)
- [VT100-Examples/vt_seq.md at master · 0x5c/VT100-Examples · GitHub](https://github.com/0x5c/VT100-Examples/blob/master/vt_seq.md)
