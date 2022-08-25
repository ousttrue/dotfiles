[[RDP]]
[[KMS]]

- [Waylandとは？ - Qiita](https://qiita.com/maueki/items/9a3a8791a05c00b34c29)
- [作って学ぶWayland - Qiita](https://qiita.com/maueki/items/34323b2762e3c3342c51)
- [Waylandプログラミング入門 - ブログのタイトル](http://d.hatena.ne.jp/devm33/20140422/1398182440)
- [Wayland の Client と Compositor の概念を理解する - Qiita](https://qiita.com/naohikowatanabe/items/06a8b988b89b4b1ec899)

## compositor
- [[wlroots]]
- weston
- sway
- [[[Wayfire](https://wayfire.org/)]]
- [GitHub - ec1oud/grefsen: A Qt/Wayland desktop](https://github.com/ec1oud/grefsen)

## xdg-shell
- [xdg-shell | Clean Rinse](http://blog.mecheye.net/2014/06/xdg-shell/)
- [Wayland xdg-shell protocol - Tizen Wiki](https://wiki.tizen.org/Wayland_xdg-shell_protocol)

## RDP backend

[Wayland RDP backend試してみた - Qiita](https://qiita.com/junjihashimoto@github/items/2c37ee557360a6459926)

```
ssh-keygen -f rdp.key
weston --backend=rdp-backend.so --rdp4-key=rdp.key
```
