#!/bin/sh
set -x
xrdb -merge ~/.Xresources

if which xset > /dev/null 2>&1; then
    xset s off -dpms
fi
#if which setxkbmap > /dev/null 2>&1; then
#    #setxkbmap -option ctrl:nocaps
#    setxkbmap jp
#fi

#eval "$(dbus-launch --sh-syntax --exit-with-session)"

if which fcitx5 > /dev/null 2>&1; then
    export GTK_IM_MODULE=fcitx5
    export QT_IM_MODULE=fcitx5
    export XMODIFIERS=@im=fcitx5
    fcitx5&
elif which ibus-daemon > /dev/null 2>&1; then
    export GTK_IM_MODULE=ibus
    export QT_IM_MODULE=ibus
    export XMODIFIERS=@im=ibus
    ibus-daemon -drx
fi

if which mpd > /dev/null 2>&1; then
    mpd
fi

# exec startlxqt
exec openbox-session
# exec openbox
# exec blackbox
# exec berry
# exec xterm
# exec qtile start
