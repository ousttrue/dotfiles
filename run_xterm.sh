export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
xrdb -merge ~/.Xresources
DISPLAY=localhost:0 xterm

