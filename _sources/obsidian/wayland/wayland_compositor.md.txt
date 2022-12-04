[[wayland]]

- [[[Wayfire](https://wayfire.org/)]]
- [GitHub - ec1oud/grefsen: A Qt/Wayland desktop](https://github.com/ec1oud/grefsen)
- [[qtile]]

- @2017 [作って学ぶWayland - Qiita](https://qiita.com/maueki/items/34323b2762e3c3342c51)

# wlroots
- [wlroots](https://github.com/swaywm/wlroots)
- [Introduction -](https://way-cooler.org/book/wayland_introduction.html)

## sway

# weston
- [wayland / weston · GitLab](https://gitlab.freedesktop.org/wayland/weston)

# backend

-   x11
-   drm
-   wayland
-   headless
-   fbdev
-   rdp（リモートデスクトップ）

## RDP
[[RDP]]
- @2017 [Wayland RDP backend試してみた - Qiita](https://qiita.com/junjihashimoto@github/items/2c37ee557360a6459926)

```
ssh-keygen -f rdp.key
weston --backend=rdp-backend.so --rdp4-key=rdp.key
```

## VNC
[[vnc]]
