[[AFrame]] [[xterm.js]]

https://xrterm.com/

# Version
@202111
[GitHub - szk/xrterm: Terminal Emulator for xR (VR/AR/MR) environment](https://github.com/szk/xrterm)

`xterm.js-4.13`
CursorRenderLayer.constructor
https://github.com/xtermjs/xterm.js/commit/c1b4f4edb15f9b9a55dabf373156417dfcea8cd8

# 構成
```js
> npm run start
"start": "concurrently --kill-others \"npm run server\" \"npm run client\"",

"server": "nodemon ./src/server/run.js",
"client": "webpack-dev-server --host 0.0.0.0 --hot --progress --port 8000 ",
```

## camera hit focus
## keyinput
## renderer


# src/server/run.js

- [[node-pty]]
- websocket? 

# client scene/index.js
webpack で bundle. front

TODO:
	vite + typescript 化して読みやすくする

# aframe-xterm-component
@2019
canvas 2d への描画からのコピーを使っているポイ。重い。`quest pro` が負荷で落ちた。
[GitHub - RangerMauve/aframe-xterm-component: Playing around with getting xterm.js working in Aframe VR](https://github.com/RangerMauve/aframe-xterm-component)

# XRTerm
@2020 Three.js の glContext で描画する AframeAddon がソースが無かった。weback よくわからん。
https://github.com/szk/xrterm
