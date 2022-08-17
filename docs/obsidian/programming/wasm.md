wasm debug

[[zig]]

[WebAssembly | MDN](https://developer.mozilla.org/en-US/docs/WebAssembly)
- [WebAssembly](https://webassembly.org/)
- [Using the WebAssembly JavaScript API - WebAssembly | MDN](https://developer.mozilla.org/en-US/docs/WebAssembly/Using_the_JavaScript_API)
- [GitHub - WebAssembly/binaryen: Compiler infrastructure and toolchain library for WebAssembly](https://github.com/WebAssembly/binaryen)
- [GitHub - WebAssembly/wabt: The WebAssembly Binary Toolkit](https://github.com/WebAssembly/wabt)
- https://github.com/wasm3/wasm3
- [WebAssemblyコードのロードと実行 - WebAssembly | MDN](https://developer.mozilla.org/ja/docs/WebAssembly/Loading_and_running)

# browser

wasm に対して browser の関数をエクスポートするには関数ポインタを代入する。

```js
// get
const response = await fetch('add.wasm')
// byte array
const buffer = await response.arrayBuffer();
// compile
const compiled = await WebAssembly.compile(buffer);
// instanciate env に webgl などを埋め込む
const instance = await WebAssembly.instantiate(compiled, { env });
console.log(instance);
// call
const value = instance.exports.add(1, 2);
console.log(value);
```

- [WebAssembly.compile() - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/compile)
- [WebAssembly.Module - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Module)


## imports
```
WebAssembly.instantiate(bufferSource, importObject);
```


- [WebAssembly.Module.imports() - JavaScript | MDN](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Module/imports)
- [Emscripten で C/C++ から JS の関数を呼ぶには - DEV Community](https://dev.to/chikoski/emscripten-c-c-js-57fb)

## exports

wasm が browser に公開する

```js
// or access the buffer contents of an exported memory:
var i32 = new Uint32Array(obj.instance.exports.memory.buffer);

// or access the elements of an exported table:
var table = obj.instance.exports.table;
console.log(table.get(0)());
```

- [WebAssembly.Memory() - JavaScript | MDN](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Memory)
- [Memory in WebAssembly (and why it’s safer than you think) - Mozilla Hacks - the Web developer blog](https://hacks.mozilla.org/2017/07/memory-in-webassembly-and-why-its-safer-than-you-think/)


# debgger

- [Debugging WebAssembly with modern tools - Chrome Developers](https://developers.google.com/web/updates/2020/12/webassembly)
- [Improved WebAssembly debugging in Chrome DevTools - Chrome Developers](https://developers.google.com/web/updates/2019/12/webassembly)
* [WebAssemblyでもブラウザでステップ実行ができるようになってたので寄り道しながら頑張った話 - Qiita](https://qiita.com/lempiji/items/462cce79dab8166fa5a5)

# articles
- [WebAssemblyを試してみた - Calmery.me](http://calmery.hatenablog.com/entry/2017/03/08/222513)
- [まえがき | WEBASSEMBLY USUI BOOK](https://ukyo.github.io/wasm-usui-book/webroot/intro.html)
- [LuaをWebAssemblyにコンパイルして実行する話 - blog::wnotes.net](https://blog.wnotes.net/posts/webassembly-lua/)
- [Build your own WebAssembly Compiler](https://blog.scottlogic.com/2019/05/17/webassembly-compiler.html)
- [Modules — WebAssembly 2.0 (Draft 2022-08-11)](https://webassembly.org/docs/modules/)
