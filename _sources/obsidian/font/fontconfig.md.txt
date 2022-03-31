fontconfig
#x11 #font

	https://wiki.archlinux.jp/index.php/フォント設定
	https://ja.wikipedia.org/wiki/Fontconfig
	https://www.archlinux.site/2017/04/fontconfig.html

[* fonts]
`~/.fonts`
`/usr/local/share/fonts/`

`sudo fc-cache -fv`

[* fonts.conf]
`~/.config/fontconfig/fonts.conf`

[* fc-list]

code:.Xresources
 xterm*faceName: Monoid:style=Regular:size=12:antialias=false
 xterm*faceNameDoublesize: Yu Gothic:size=10

[* fc-match]
code:fc.sh
 $  fc-match sans-serif
 ipag.ttf: "IPAGothic" "Regular"
 $  fc-match mono
 ipag.ttf: "IPAGothic" "Regular"

[* fc-cache]
code:sh
	$ fc-cache -fv
