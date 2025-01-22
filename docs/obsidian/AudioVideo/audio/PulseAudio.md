[[alsa]]
[[bluetooth]]

- [PulseAudio - ArchWiki](https://wiki.archlinux.jp/index.php/PulseAudio)
- [PulseAudio - Gentoo Wiki](https://wiki.gentoo.org/wiki/PulseAudio)

`~/.config/pulse`
`/etc/pulse`

> ユーザーを audio グループに追加する必要はありません。[udev](https://wiki.archlinux.jp/index.php/Udev "Udev") と *logind* を使用して動的にユーザーに権限が与えられます

```
$ pactl info
Connection failure: Timeout
```

```
$ pactl info
```

# pavucontrol

[[gtk]]

# docker

- [DockerでPulseaudioを使って，ホストで音を出していてもコンテナで音を出せるようにする． - Qiita](https://qiita.com/Light606F/items/898081a73166c010473a)

# user service

[PulseAudio の自動起動を完全に無効化する方法](https://zenn.dev/noraworld/articles/disable-pulseaudio-autospawn)

# system service

[PulseAudioをsystem serviceとして動かす #Linux - Qiita](https://qiita.com/fujiba/items/9f90e90d5e9366ec8483)

## 24.04

```sh
sudo apt remove pipewire-audio-client-libraries # pipewire
sudo systemctl start pulseaudio.socket 
sudo systemctl enable --now pulseaudio.service
```

`stop pipewire-pulse`

- [sound - How to uninstall pipewire and go back to pulseaudio - Ask Ubuntu](https://askubuntu.com/questions/1407885/how-to-uninstall-pipewire-and-go-back-to-pulseaudio)
- [Red Hat Customer Portal - Access to 24x7 support and knowledge](https://access.redhat.com/ja/articles/7035126)
