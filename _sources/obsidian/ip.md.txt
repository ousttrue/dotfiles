# ip command

## temp

### static ip
```
# ip addr add 192.168.0.1/24 dev enp0
# ip link set enp0 up
```

### route
```
# ip route add default via 192.168.0.1
```

### dns
`/etc/resolv.conf`
```
nameserver 192.168.0.1
```

## permanently
## Arch
`netctl`
- [Arch Linuxで固定IPを簡単に設定する - Qiita](https://qiita.com/acro5piano/items/b590ac7d75f6ceaa3f12)
```
# systemctl start netctl
# netctl start ether-static
# systemctl enable netctl
# netctl enable ether-static
```

## Gentoo
## Ubuntu
