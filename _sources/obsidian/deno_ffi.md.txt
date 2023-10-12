
- [Deno を始める - 第4回 (OS 機能と FFI の利用) | 豆蔵デベロッパーサイト](https://developer.mamezou-tech.com/deno/getting-started/04-using-os-and-ffi/)


# uint8array to pointer

```js
// double pointer を作るのに必要だったり
const vertPtr = new BigUint64Array(1);
vertPtr[0] = BigInt(Deno.UnsafePointer.value(Deno.UnsafePointer.of(p)));
```
