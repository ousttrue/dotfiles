xrdb -merge ~/.Xresources

if [ `which tint2 > /dev/null` ]; then
    tint2&
fi
exec openbox-session

