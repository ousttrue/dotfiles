[[AFrame]] [[xterm.js]]

https://xrterm.com/

@2021 [GitHub - szk/xrterm: Terminal Emulator for xR (VR/AR/MR) environment](https://github.com/szk/xrterm)

```js
> npm run start
"start": "concurrently --kill-others \"npm run server\" \"npm run client\"",

"server": "nodemon ./src/server/run.js",
"client": "webpack-dev-server --host 0.0.0.0 --hot --progress --port 8000 ",
```

# src/server/run.js

- [[node-pty]]
- websocket? 

# client scene/index.js
webpack で bundle. front

TODO:
	vite + typescript 化して読みやすくする
 