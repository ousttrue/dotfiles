[[Linux]] [[DRM]] [[TerminalEmulator]]

# console
Linux の X を起動する前の黒い画面
`/dev/console`
- VGA 80x25
- showconsolefont
- setfont lat2-16 -m 8859-2
	- `/usr/share/kbd/consolefonts/`
`/etc/vconsole.conf`

# framebuffer

# kmscon
- [kmscon](https://www.freedesktop.org/wiki/Software/kmscon/)

# keymap
- [Arch Linux をおしゃれに最速インストール - おしゃれな気分でプログラミング](http://neko-mac.blogspot.com/2021/05/arch-linux.html)

```
# mkdir -p /usr/local/share/kbd/keymaps
# cp /usr/share/kbd/keymaps/i386/qwerty/us.map.gz /usr/local/share/kbd/keymaps/
# cd /usr/local/share/kbd/keymaps/
# gunzip us.map.gz
# mv us.map my_custom_us.map
# vim my_custom_us.map

keycode  58 = Control

/etc/vconsole.conf
KEYMAP=/usr/local/share/kbd/keymaps/us_custom.map
```
