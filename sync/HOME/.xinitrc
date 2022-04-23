xrdb -merge ~/.Xresources

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
ibus-daemon -drx

if [ `which tint2 > /dev/null` ]; then
    tint2&
fi
exec openbox-session

