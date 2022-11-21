hls
#nginx

http://nginx-rtmp.blogspot.com/
	https://github.com/arut/nginx-rtmp-module
	https://github.com/arut/nginx-rtmp-module/wiki/Directives

`rtmp://rtmp.example.com/app[/name]`

https://qiita.com/okumurakengo/items/5627326ee833a3a5ea03

https://www.techlive.tokyo/archives/1343

[* Desktop]
`ffmpeg -r 30 -s 320x240 -f dshow -i video="BUFFALO BSW32KM01H Webcam" -g 10 -c:v libx264 -preset veryfast -pix_fmt yuv420p -f flv rtmp://host/hls/test`

`ffmpeg -rtbufsize 100M -f dshow -i video="BUFFALO BSW32KM01H Webcam" -framerate 15 -g 30 -preset veryfast -maxrate 768k -bufsize 8080k -vcodec libx264 -pix_fmt yuv420p -f flv rtmp://host/hls/test`

`-gがセグメント長を決める` フレームレートの２倍にすると 2s

`ffmpeg -y -rtbufsize 100M -f gdigrab -framerate 15 -draw_mouse 1 -i desktop -c:v libx264 -preset ultrafast -tune zerolatency -pix_fmt yuv422p -f flv rtmp://host/hls/test`

https://docs.peer5.com/guides/setting-up-hls-live-streaming-server-using-nginx/

[* sender]
keyframeの間隔を短く
https://stackoverflow.com/questions/30979714/how-to-change-keyframe-interval-in-ffmpeg

https://johnathan.org/originals/2016/07/attempting-to-stream-a-webcam-to-an-rtmp-server.html

# python
[[python]]
[pyOpenGL + ffmpeg.exeでmovie fileを作る。 - Qiita](https://qiita.com/gaziya5/items/42b9856849fbe98e40d7)
