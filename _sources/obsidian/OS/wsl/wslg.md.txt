[[OS/Linux/wsl]] [[Linux]] [[wayland]] [[RDP]]

- [WSL で Linux GUI アプリを実行する | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows/wsl/tutorials/gui-apps)
	- [GitHub - microsoft/wslg: Enabling the Windows Subsystem for Linux to include support for Wayland and X server related scenarios](https://github.com/microsoft/wslg)

![[WSLg_ArchitectureOverview.png]]
```
> wsl --status
既定の配布: Ubuntu-20.04
既定のバージョン: 2

Linux 用 Windows サブシステムの最終更新日: 2022/05/06
WSL の自動更新が有効になっています。

カーネル バージョン: 5.10.102.1
```

- @2022 [WSLgでWaylandネイティブでDvorak入力を行い、勝手にQWERTYになるのに対策し、日本語入力を行う - ncaq](https://www.ncaq.net/2022/10/20/22/08/43/)
- @2022 [WSL2,WSLgを使ったWindows上の開発環境構築2022版 - Qiita](https://qiita.com/yugo-yamamoto/items/28e3d2a090f8f546f3ec)
- @2021 [Windows 10 HomeでWSLgをさっそく試してみた](https://www.eisbahn.jp/yoichiro/2021/06/wslg.html)

# audio
[[PulseAudio]] 
```sh
sudo apt -y install pulseaudio alsa-utils
```

- @2023 [WSL2上のUbuntu20.04から簡単に音声再生／録音ができた - 佐藤百貨店](https://www.sato-susumu.com/entry/2023/01/21/154738)

```sh
> aplay /usr/share/sounds/alsa/Side_Right.wav
```

# IME
- @2022 [WSLgとFcitx5はWaylandをdisableにして使う - Qiita](https://qiita.com/kws_fx/items/614fadf7f5bdffb64bfe)

# bug
- [Buffered keyboard inputs are continue to be dispatched to newly started application in X · Issue #207 · microsoft/wslg · GitHub](https://github.com/microsoft/wslg/issues/207)

@2022 冬。解消した？
