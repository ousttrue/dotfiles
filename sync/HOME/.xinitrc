#!/bin/sh
xrdb -merge ~/.Xresources

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

exec dbus-launch --exit-with-session openbox-session

