# WebSocket

```js
stream.on('message', (message, isBinary) => {
	// @ts-ignore
	ptyProcess.write(isBinary ? message.toString() : message);
});
```
