[ディスプレイマネージャ - ArchWiki](https://wiki.archlinux.jp/index.php/%E3%83%87%E3%82%A3%E3%82%B9%E3%83%97%E3%83%AC%E3%82%A4%E3%83%9E%E3%83%8D%E3%83%BC%E3%82%B8%E3%83%A3)

[[LoginManager]]
[[OS/X11/X11]]
[[PulseAudio]]
[[elogind]]

|     | console | X11 | wayland | logind   |
| --- | ------- | --- | ------- | -------- |
| ly  | ok      |     |         | not used |

# platform

## console

## X11

`/etc/X11/default-display-manager`

`session`

環境変数を設定してから, `/etc/X11/XSession` を呼びだす？

- @2021 [ディスプレイマネージャの変更[ubuntu] #ubuntu20.04 - Qiita](https://qiita.com/shou_san/items/1bb140c4bfa47cb0fbe8)
  `/etc/X11/default-display-manager`
  `/etc/systemd/system/dislpay-manager.service`

## wayland

# gdm

## 3

# lightdm

- /usr/share/lightdm/lightdm.conf.d/\*.conf
- /etc/lightdm/lightdm.conf.d/\*.conf => empty
- /etc/lightdm/lightdm.conf
- [Site Unreachable](https://moebuntu.blog.fc2.com/blog-entry-675.html)

```conf
greeter-session=unity-greeter
user-session=xubuntu
```

- @2018 [ディスプレイマネージャーLightDMの導入 - fuhaのゲームとかLinuxとか色々](https://fuha.hatenablog.com/entry/20180121/1516545356)

# greetd

[[greetd]]

