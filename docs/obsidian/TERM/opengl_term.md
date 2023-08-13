## kitty
[[wayland]]

## wezterm
[[wayland]]

- [Build from source - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/install/source.html)
```
vim wezterm-gui/Cargo.toml
```

- wayland-client
- wayland-protocol
- wayland-egl

## Alacritty
[[wayland]]
- [Alacritty - A cross-platform, OpenGL terminal emulator](https://alacritty.org/)
	- [alacritty/INSTALL.md at master · alacritty/alacritty · GitHub](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)
```
# Force support for only X11
cargo build --release --no-default-features --features=x11
```

- @2018 [LinuxデスクトップのターミナルアプリとしてAlacrittyを使い始めた - ぶていのログでぶログ](https://tech.buty4649.net/entry/2018/07/30/134654)

## other
- [Zutty - Zero-cost Unicode Teletype](https://tomscii.sig7.se/zutty/)
- [GitHub - bolner/CRTerm: CRT Terminal emulator (OpenGL)](https://github.com/bolner/CRTerm)
- [GitHub - refi64/uterm: A WIP terminal emulator, written in C++11 using Skia, libtsm, and GLFW](https://github.com/refi64/uterm)
