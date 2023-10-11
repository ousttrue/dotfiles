[[zig]]

[WebAssembly | MDN](https://developer.mozilla.org/en-US/docs/WebAssembly)

- @2022 [興味のおもむくままにWASM/WASIらへん](https://zenn.dev/newgyu/scraps/ffbce244b960e6)

# Type
-   `i32`, `i64`, `f32`, `f64`

# module

## memory
## export
## import

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

# text形式
- [WebAssembly テキスト形式の理解 - WebAssembly | MDN](https://developer.mozilla.org/ja/docs/WebAssembly/Understanding_the_text_format)

# debgger
-  [Chrome ウェブストア - 拡張機能](https://chrome.google.com/webstore/detail/cc%20%20-devtools-support-dwa/pdcpmagijalfljmkmjngeonclgbbannb)

- [Debugging WebAssembly with modern tools - Chrome Developers](https://developers.google.com/web/updates/2020/12/webassembly)
- [Improved WebAssembly debugging in Chrome DevTools - Chrome Developers](https://developers.google.com/web/updates/2019/12/webassembly)
* [WebAssemblyでもブラウザでステップ実行ができるようになってたので寄り道しながら頑張った話 - Qiita](https://qiita.com/lempiji/items/462cce79dab8166fa5a5)

# articles
- [【WASM】Cコンパイラをブラウザ上で動かす - Kludge Factory](https://tyfkda.github.io/blog/2021/02/04/c-on-browser.html)
- [WebAssemblyを試してみた - Calmery.me](http://calmery.hatenablog.com/entry/2017/03/08/222513)
- [まえがき | WEBASSEMBLY USUI BOOK](https://ukyo.github.io/wasm-usui-book/webroot/intro.html)
- [LuaをWebAssemblyにコンパイルして実行する話 - blog::wnotes.net](https://blog.wnotes.net/posts/webassembly-lua/)
- [Build your own WebAssembly Compiler](https://blog.scottlogic.com/2019/05/17/webassembly-compiler.html)
- [Modules — WebAssembly 2.0 (Draft 2022-08-11)](https://webassembly.org/docs/modules/)

