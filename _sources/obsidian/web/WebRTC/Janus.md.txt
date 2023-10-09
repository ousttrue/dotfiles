[GitHub - meetecho/janus-gateway: Janus WebRTC Server](https://github.com/meetecho/janus-gateway)

- @2023 [メモ：お手軽にWebRTCでVideoChatをしたいので、Janus-gatewayをAWS EC2やRaspberry Pi4上に立てたときのメモ - cvl-robot's diary](https://cvl-robot.hateblo.jp/entry/2023/02/01/203417)
- @2022 [GStreamer から WebRTC Janus に配信を行う](https://www.gclue.jp/2022/09/gstreamer-webrtc-janus.html)
- @2020 [Janusで自前のWebRTCビデオチャットサーバー - みかんのゆるふわ技術ブログ](https://www.mikan-tech.net/entry/2020/05/02/173000)

`janus` は server アプリ だが https を host しない。
https server が必要である( [[WebRTC]] が [[https]] を必須とするため)
[[docker]] で構築するのがよさそう

# 構成
```

front
+-----+nginxとか
|https|
+-----+          +-----+
js ------------->|janus|
                 +-----+
```

front の js
server, iceServers, token, apiSecrets が供給される仕組み？
```js
			janus = new Janus(
				{
					server: server,
					iceServers: iceServers,
					token: token,
j					apisecret: apisecret,
	
```

# demos
`share/janus/demos`

```
% dpkg -L janus-demos
/.
/usr
/usr/share
/usr/share/doc
/usr/share/doc/janus-demos
/usr/share/doc/janus-demos/README.Debian
/usr/share/doc/janus-demos/copyright
/usr/share/doc/janus-demos/examples
/usr/share/doc/janus-demos/examples/adminconfig.js
/usr/share/doc/janus-demos/examples/config.js
/usr/share/janus
/usr/share/janus/demos
```

Nginx で host する。
```

% sudo apt install nginx
% ls /var/www/html/
index.nginx-debian.html

j$ sudo mv /var/www/html /var/www/html.bak
$ sudo ln -s /usr/share/janus/demos /var/www/html
```
- @2020 [Janusで自前のWebRTCビデオチャットサーバー - みかんのゆるふわ技術ブログ](https://www.mikan-tech.net/entry/2020/05/02/173000)

## echotest

# janus.js
- [JavaScript API](https://janus.conf.meetecho.com/docs/JS.html)

# lua plugin
[[lua]]

- [Lua plugin API](https://janus.conf.meetecho.com/docs/group__luapapi.html)
- [Janus Lua script for the Astricon 2017 Dangerous Demo · GitHub](https://gist.github.com/lminiero/9aeeda1be501fb636cad0c8057c6e076)
- [Tutorial: writing a Janus video call plugin in Lua | Meetecho Blog](https://www.meetecho.com/blog/tutorial-writing-a-janus-video-call-plugin-in-lua/)
- [Lua plugin documentation](https://janus.conf.meetecho.com/docs/lua.html)

- [webrtc-piano/webrtc-piano.lua at master · lminiero/webrtc-piano · GitHub](https://github.com/lminiero/webrtc-piano/blob/master/webrtc-piano.lua)

# js
- [GitHub - sjkummer/janus-gateway-js: Janus-gateway WebRTC client for Node.js and the browser.](https://github.com/sjkummer/janus-gateway-js)
