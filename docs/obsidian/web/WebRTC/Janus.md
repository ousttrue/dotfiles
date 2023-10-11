[GitHub - meetecho/janus-gateway: Janus WebRTC Server](https://github.com/meetecho/janus-gateway)

- @2023 [メモ：お手軽にWebRTCでVideoChatをしたいので、Janus-gatewayをAWS EC2やRaspberry Pi4上に立てたときのメモ - cvl-robot's diary](https://cvl-robot.hateblo.jp/entry/2023/02/01/203417)
- @2022 [GStreamer から WebRTC Janus に配信を行う](https://www.gclue.jp/2022/09/gstreamer-webrtc-janus.html)


# wsl build 動確
`prefix=$HOME/local`
- @2020 [Janusで自前のWebRTCビデオチャットサーバー - みかんのゆるふわ技術ブログ](https://www.mikan-tech.net/entry/2020/05/02/173000)
- @2022 [DockerでNode/Nginx/Janusを単体で動かす。NginxでJanusのデモページをホスティングする。 - ゼロからの開発日誌](https://nucamisoo.hatenablog.com/entry/2022/08/21/155935)

## libnice
`meson`
https://github.com/libnice/libnice

## libsrtp
`meson`
https://github.com/cisco/libsrtp

## janus
`autotools`, `glib-2.0`
[GitHub - meetecho/janus-gateway: Janus WebRTC Server](https://github.com/meetecho/janus-gateway)
```
PKG_CONFIG_PATH=$HOME/local/lib/x86_64-linux-gnu/pkgconfig ./configure --prefix $HOME/local
make
make install
make configs
```
`${PREFIX}/etc/janus/janus.jcfg`

## 自己証明書
```
$ sudo apt-get install ssl-cert
$ sudo make-ssl-cert generate-default-snakeoil
/etc/ssl/certs/ssl-cert-snakeoil.pem # 一般権限
/etc/ssl/private/ssl-cert-snakeoil.key # 700/600 rot 権限
```

## janus https
`${PREFIX}/etc/janus/janus.transport.http.jcfg`
```
general: {
        https = true
        secure_port = 8089
}
certificates: {
        cert_pem = "/etc/ssl/certs/ssl-cert-snakeoil.pem"
        cert_key = "/etc/ssl/private/ssl-cert-snakeoil.key"
}
```

## launch
`$ janus`

## host frontend
`localhost:8081`
```
$ cd `${PREFIX}/share/janus/demos`
$ npx http-server
```
`https`
```
$ npx local-ssl-proxy --source 8082 --target 8081
```

`OK` 動いた

# mjr
- [Janus: オープンソースWebRTCサーバ - panda's tech note](https://ja.tech.jar.jp/webrtc/janus.html)
`shared/janus/recordings/`

# Core


# Plugins
- EchoTest Plugin
- VideoCall Plugin
- SIP Plugin
- NoSIP Plugin
- AudioBridge Plugin
- VideoRoom Plugin
- Record&Play Plugin
- VoiceMail Plugin
- Javascript Plugin

## Streaming Plugin
	`janus.plugin.streaming.jcfg`
    `udpsink` @2022 [GStreamer から WebRTC Janus に配信を行う](https://www.gclue.jp/2022/09/gstreamer-webrtc-janus.html)## lua plugin
[[lua]]

## Lua Plugin
 [Lua plugin API](https://janus.conf.meetecho.com/docs/group__luapapi.html)
- [Janus Lua script for the Astricon 2017 Dangerous Demo · GitHub](https://gist.github.com/lminiero/9aeeda1be501fb636cad0c8057c6e076)
	- [webrtc-piano/webrtc-piano.lua at master · lminiero/webrtc-piano · GitHub](https://github.com/lminiero/webrtc-piano/blob/master/webrtc-piano.lua)
- [Tutorial: writing a Janus video call plugin in Lua | Meetecho Blog](https://www.meetecho.com/blog/tutorial-writing-a-janus-video-call-plugin-in-lua/)
- [Lua plugin documentation](https://janus.conf.meetecho.com/docs/lua.html)

# flutter
- [Integrating WebRTC in Flutter Simplified using Janus Gateway and flutter janus client | by Shivansh Talwar | Medium](https://medium.com/@shivanshtalwar0/integrating-webrtc-in-flutter-simplified-using-janus-gateway-and-flutter-janus-client-6013dbd3a3ee)
