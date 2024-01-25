=> mouse, keyboard
<= screen image

|          | local         | remote      |
| -------- | ------------- | ----------- |
| mouse    | browser event | ?           |
| keyboard | browser event | ?           |
| screen   | mediastream   | mediastream |

# impl

- `keyboard` `mouse` [Web Console - roy-n-roy メモ](https://roy-n-roy.nyan-co.page/Raspberry%20Pi/WebConsole/)
- `keyboard? => pty` [[xterm.js]]
- [Desktop mouse and keyboard controls - Game development | MDN](https://developer.mozilla.org/en-US/docs/Games/Techniques/Control_mechanisms/Desktop_with_mouse_and_keyboard)

入力にゲームエンジンを使う

- [GitHub - photonstorm/phaser: Phaser is a fun, free and fast 2D game framework for making HTML5 games for desktop and mobile web browsers, supporting Canvas and WebGL rendering.](https://github.com/photonstorm/phaser)

electron で中継

- [2022-01 日記](https://www.binzume.net/diary/2022-01)

## syncinput

[syncinput | Synchronous keyboard and mouse input for web applications. Useful for games and canvas / webgl synchronous content in web applications.](https://tentone.github.io/syncinput/)

# RDP

[[RDP]]

# VNC

[[vnc]]

# Selkies

[[Selkies]]

# Apache Guacamole

https://guacamole.apache.org/

[[vnc]] [[RDP]] [[pty]]

> supports standard protocols like VNC, RDP, and SSH

- @2022 [オンプレもマルチクラウドも Windows のリモートログインを一括集約、Apache Guacamole が便利な話 - Oisix ra daichi Creator's Blog（オイシックス・ラ・大地クリエイターズブログ）](https://creators.oisixradaichi.co.jp/entry/2022/04/28/133505)
- @2020 [第 613 回　 Apache Guacamole を使って Web ブラウザから Windows 10 にリモート接続する | gihyo.jp](https://gihyo.jp/admin/serial/01/ubuntu-recipe/0613)
