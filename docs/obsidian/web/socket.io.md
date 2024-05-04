# version

## 4.0

- https://socket.io/docs/v3/migrating-from-3-x-to-4-0/

## 3.x

# erroor

## EIO 400

```json
{ "code": 5, "message": "Unsupported protocol version" }
```

https://stackoverflow.com/questions/66047026/socket-io-v3-unsupported-protocol-version-error

https://stackoverflow.com/questions/48920541/whats-the-meaning-of-eio-and-t-in-socketio


## Cannot read property 'emit' of undefined

```js
io.to('room_name').broadcast.emit()
// 👇
io.to('room_name').emit()
```
