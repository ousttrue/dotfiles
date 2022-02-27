msys2
#pacman

https://avatars1.githubusercontent.com/u/6759993?s=200&v=4

[* fstab]
code:/etc/fstab
 # DO NOT REMOVE NEXT LINE. It remove cygdrive prefix from path
 none / cygdrive binary,posix=0,noacl,user 0 0
 
 C:/Users /home

#tmux

[* pacmanの更新]
$ pacman -Syu
-S sync
-y update
-u upgrade

[* vim]
code:.vimrc
 set background=dark
 set t_Co=256
