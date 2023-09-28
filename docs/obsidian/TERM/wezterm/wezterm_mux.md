[Multiplexing - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/multiplexing.html)

- @2022 [Hello, Wezterm | katsyoshi のめもみたいなの](https://blog.katsyoshi.org/blog/2022/03/19/hello-wezterm/)

```sh
/usr/local/bin/wezterm-mux-server --daemonize
```

# event: mux-startup
[mux-startup - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/mux-events/mux-startup.html)

# TLSDomainServer
- [object: TlsDomainServer - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/config/lua/TlsDomainServer.html)

# wsl

ssh
```
> sudo apt install openssh-server
```

sh
```
!/bin/sh
/bin/bash --login -c wezterm-mux-server --daemonize &
```

unit
```
```

```
> systemctl --user enable wezterm.service
```

起動保持
```
> wsl /bin/bash --login -c btm
```
