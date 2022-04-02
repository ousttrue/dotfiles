fontconfig

- [Fontconfigでデフォルトのフォントを設定する方法 | 普段使いのArch Linux](https://www.archlinux.site/2017/04/fontconfig.html)

`~/.fonts`
`/usr/local/share/fonts/`

`sudo fc-cache -fv`

# fonts.conf
`~/.config/fontconfig/fonts.conf`

# fc-list
[[xresource]]

```
xterm*faceName: Monoid:style=Regular:size=12:antialias=false
xterm*faceNameDoublesize: Yu Gothic:size=10
```
# fc-match
```
$  fc-match sans-serif
ipag.ttf: "IPAGothic" "Regular"
$  fc-match mono
ipag.ttf: "IPAGothic" "Regular"
```

# fc-cache
```
$ fc-cache -fv
```
