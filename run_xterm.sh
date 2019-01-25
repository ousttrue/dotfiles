export DefaultImModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

xrdb -merge ~/.Xresources
#DISPLAY=localhost:0 xterm

fcitx&
DISPLAY=localhost:0 xfce4-terminal

