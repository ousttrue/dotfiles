xrdb -merge ~/dotfiles/Xresources.wsl
setxkbmap -layout us
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx
#(fcitx-autostart > /dev/null 2>&1 &)
fcitx-autostart&
xset -r 49  > /dev/null 2>&1

# block xterm
/usr/bin/xterm
#/usr/bin/urxvt
#st -f "HackGenNerd Console-24"

