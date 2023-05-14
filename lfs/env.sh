LFS=$HOME/lfs/mnt
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE

echo LFS: $LFS 
echo LC_ALL: $LC_ALL
echo LFS_TGT: $LFS_TGT
echo PATH: $PATH
echo CONFIG_SITE: $CONFIG_SITE

unalias -a

PS1="LFS:\w\$ "

