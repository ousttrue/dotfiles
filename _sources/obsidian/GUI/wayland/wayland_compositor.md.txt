[[wayland]]
[[wayland_client]]

- [GitHub - okazoh-tk/minic: Minimal wayland compositor for learning](https://github.com/okazoh-tk/minic)

- [GitHub - wiztk/compositor](https://github.com/wiztk/compositor)
  - 依存 skia
- [GitHub - ec1oud/grefsen: A Qt/Wayland desktop](https://github.com/ec1oud/grefsen)
- [GitHub - Link1J/Awning: A Wayland Compositor](https://github.com/Link1J/Awning)
- [GitHub - st3r4g/swvkc: experimental Wayland Vulkan compositor](https://github.com/st3r4g/swvkc)

- @2017 [作って学ぶWayland - Qiita](https://qiita.com/maueki/items/34323b2762e3c3342c51)
  X11上での実行専用。

```c
#include <cstdio>
#include <wayland-server.h>

int main(int argc, char *argv[])
{
    wl_display* display = wl_display_create();

    printf("hello, wayland\n");
    wl_display_run(display);

    return 0;
}
```

# wlroots

- [wlroots](https://github.com/swaywm/wlroots)
- [Introduction -](https://way-cooler.org/book/wayland_introduction.html)

## tiling

### Hyprland

[GitHub - hyprwm/Hyprland: Hyprland is a highly customizable dynamic tiling Wayland compositor that doesn't sacrifice on its looks.](https://github.com/hyprwm/Hyprland)

- [Arch LinuxとHyprlandをインストールする - Qiita](https://qiita.com/k0kubun/items/f80817d34a3eba5122bc#nvidia%E7%94%A8%E3%81%AE%E5%AF%BE%E5%BF%9C)
- [NixOSとHyprlandで最強のLinuxデスクトップ環境を作る](https://zenn.dev/asa1984/scraps/e4d8b9947d8351)

### tinywl

[tinywl · master · wlroots / wlroots · GitLab](https://gitlab.freedesktop.org/wlroots/wlroots/-/tree/master/tinywl)

### sway

[[sway]]

# python

## newm

[[python]]

- [GitHub - jbuchermn/newm: Wayland compositor](https://github.com/jbuchermn/newm)

## qtile

- [[qtile]]

# backend

- x11
- drm
- wayland
- headless
- fbdev

## RDP

[[RDP]]

- @2017 [Wayland RDP backend試してみた - Qiita](https://qiita.com/junjihashimoto@github/items/2c37ee557360a6459926)

```
ssh-keygen -f rdp.key
weston --backend=rdp-backend.so --rdp4-key=rdp.key
```

## VNC

[[vnc]]

# browser

https://github.com/udevbe/greenfield
