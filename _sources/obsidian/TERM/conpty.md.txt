[[conhost]] を代替する新しい API
Windows10 `1903`
from `17733` `1809`

[[windows_terminal]] [[vt100]]

> Windows 疑似コンソールは、疑似コンソール、ConPTY、または Windows PTY とも呼ばれ

# escape sequence
`ENABLE_VIRTUAL_TERMINAL_PROCESSING`
[コンソールの仮想ターミナル シーケンス - Windows Console | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows/console/console-virtual-terminal-sequences)

# API
## CreatePseudoConsole
- [CreatePseudoConsole function - Windows Console | Microsoft Docs](https://docs.microsoft.com/en-us/windows/console/createpseudoconsole)

## SetConsoleMode
- [SetConsoleMode 関数 - Windows Console | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/console/setconsolemode)

# Input
- [入力バッファー イベントの読み取り - Windows Console | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/console/reading-input-buffer-events)

# Articles
- @2018 [Windows Command-Line: Introducing the Windows Pseudo Console (ConPTY) - Windows Command Line](https://devblogs.microsoft.com/commandline/windows-command-line-introducing-the-windows-pseudo-console-conpty/)
- @2016 [24-bit Color in the Windows Console! - Windows Command Line](https://devblogs.microsoft.com/commandline/24-bit-color-in-the-windows-console/)

HOST側
Client側 => VT
- [Using the High-Level Input and Output Functions - Windows Console | Microsoft Docs](https://docs.microsoft.com/en-us/windows/console/using-the-high-level-input-and-output-functions)
- [Creating a Pseudoconsole session - Windows Console | Microsoft Docs](https://docs.microsoft.com/en-us/windows/console/creating-a-pseudoconsole-session#preparing-for-creation-of-the-child-process)
- [Console documentation - Windows Console | Microsoft Docs](https://docs.microsoft.com/en-us/windows/console/)
- [Using the Console - Windows Console | Microsoft Docs](https://docs.microsoft.com/en-us/windows/console/using-the-console)

`cs`
- [GitHub - akobr/ConPty.Sample: Example of usage pseudo console in C#.](https://github.com/akobr/ConPty.Sample)
- [GitHub - waf/MiniTerm: Experiments with the new Windows PTY APIs](https://github.com/waf/MiniTerm)

`c`
- [GitHub - Biswa96/XConPty: Experiments with Pseudo Console in Windows 10](https://github.com/Biswa96/XConPty)

`cpp`
- [terminal/samples/ConPTY/EchoCon at main · microsoft/terminal · GitHub](https://github.com/microsoft/terminal/tree/master/samples/ConPTY/EchoCon)
