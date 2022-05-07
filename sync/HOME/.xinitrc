#!/bin/sh
xrdb -merge ~/.Xresources
if which xset > /dev/null 2>&1; then
    xset s off -dpms
fi
if which setxkbmap > /dev/null 2>&1; then
    setxkbmap -option ctrl:nocaps
fi

eval "$(dbus-launch --sh-syntax --exit-with-session)"

if which ibus-daemon > /dev/null 2>&1; then
    export GTK_IM_MODULE=ibus
    export QT_IM_MODULE=ibus
    export XMODIFIERS=@im=ibus
    ibus-daemon -drx
fi

if which tint2 > /dev/null 2>&1; then
    tint2&
fi

if which conky > /dev/null 2>&1; then
    conky&
fi

if which volumeicon > /dev/null 2>&1; then
    volumeicon&
fi

if which mpd > /dev/null 2>&1; then
    mpd
fi

exec openbox-session

