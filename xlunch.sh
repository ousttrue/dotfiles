cd $HOME
export LANG=ja_JP.UTF-8
export DISPLAY=localhost:0.0 
export DefaultImModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

fcitx&
xrdb -merge ~/.Xresources
xlunch -W -x 0 -y 0 -w 500 -h 200 -q

