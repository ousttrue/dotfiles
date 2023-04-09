[[wayland]]
[[wayland_client]]

- [GitHub - okazoh-tk/minic: Minimal wayland compositor for learning](https://github.com/okazoh-tk/minic)

?
- [GitHub - ec1oud/grefsen: A Qt/Wayland desktop](https://github.com/ec1oud/grefsen)
- [GitHub - Link1J/Awning: A Wayland Compositor](https://github.com/Link1J/Awning)

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

## sway
[[sway]]

# weston
- [wayland / weston · GitLab](https://gitlab.freedesktop.org/wayland/weston)

# python
## newm
[[python]]
- [GitHub - jbuchermn/newm: Wayland compositor](https://github.com/jbuchermn/newm)

## qtile
- [[qtile]]

# backend

-   x11
-   drm
-   wayland
-   headless
-   fbdev

## RDP
[[RDP]]
- @2017 [Wayland RDP backend試してみた - Qiita](https://qiita.com/junjihashimoto@github/items/2c37ee557360a6459926)

```
ssh-keygen -f rdp.key
weston --backend=rdp-backend.so --rdp4-key=rdp.key
```

## VNC
[[vnc]]
