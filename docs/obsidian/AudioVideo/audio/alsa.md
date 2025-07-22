[[Linux]]
[[PulseAudio]]

https://gist.github.com/fd0/ddc3ad21e1ae77242628

# pacman

- https://wiki.archlinux.jp/index.php/Advanced_Linux_Sound_Architecture

```sh
$ sudo pacman -S alsa-utils
```

## test

```sh
$ speaker-test -c 2
```

[Linuxで音声の出力先をUSBスピーカーにする #RaspberryPi - Qiita](https://qiita.com/nobwak/items/a104640c5c0702486f6c)

```sh
$ speaker-test -Dplughw:MicroII
```

- https://askubuntu.com/questions/810815/ubuntu-16-04-hdmi-audio-not-working-speaker-test-works

```sh
$ speaker-test -Dhw:1,3
```

# 動作確認

```
$ aplay -L
$ cat /sys/class/sound/card*/id
$ aplay --list-devices
```

- alsamixer `M` でミュート切り替え

# mpd
