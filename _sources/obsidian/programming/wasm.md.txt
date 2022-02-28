wasm debug
#wasm

https://developers.google.com/web/updates/2020/12/webassembly
https://developers.google.com/web/updates/2019/12/webassembly


wasm

#wast

	https://webassembly.org/
		https://developer.mozilla.org/en-US/docs/WebAssembly/Using_the_JavaScript_API
	https://github.com/WebAssembly/binaryen
	https://github.com/WebAssembly/wabt

	https://github.com/wasm3/wasm3

[** articles]
	https://qiita.com/lempiji/items/462cce79dab8166fa5a5
	[WebAssemblyとは？〜実際にC言語をブラウザで動かす〜【2019年6月版】 https://qiita.com/umamichi/items/c62d18b7ed81fdba63c2]
	[(Learn the Hard Way)nodejs-8でのWebAssembly自体を調べてみた https://qiita.com/bellbind/items/a6435b0c8f10306128b8]
	http://calmery.hatenablog.com/entry/2017/03/08/222513
	https://ukyo.github.io/wasm-usui-book/webroot/intro.html

https://blog.wnotes.net/posts/webassembly-lua/

[* Table]

[** types]
	i32, i64
	f32, f64
`c` と `cpp` でマングルが違う
C: `add` => `_add`
C++:  extern "C" 
[** load]
	https://developer.mozilla.org/ja/docs/WebAssembly/Loading_and_running

code:run.js
 const response = await fetch('add.wasm')
 const buffer = await response.arrayBuffer();
 const compiled = await WebAssembly.compile(buffer);
 const instance = await WebAssembly.instantiate(compiled);
 console.log(instance);
 const value = instance.exports.add(1, 2);
 console.log(value);

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/compile
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Module
code:Module.js
 const compiled = await WebAssembly.compile(buffer);
 
 // await 抜きで同じ？
 var compiled = new WebAssembly.Module(buffer);

[* memory]
code:.js
   // or access the buffer contents of an exported memory:
   var i32 = new Uint32Array(obj.instance.exports.memory.buffer);
 
   // or access the elements of an exported table:
   var table = obj.instance.exports.table;
   console.log(table.get(0)());

	https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/WebAssembly/Memory
	https://users.rust-lang.org/t/wasm-memory-buffer-empty-after-allocating-vec-u8/18112
	https://hacks.mozilla.org/2017/07/memory-in-webassembly-and-why-its-safer-than-you-think/

[* WebAssembly 1.0(Wasm)]
	
	[ゼロからはじめるWebAssembly入門(2017/01更新) https://qiita.com/OMOIKANESAN/items/1ffc06ef6283befc4355]
	https://developer.mozilla.org/en-US/docs/WebAssembly

[* compiler]
https://blog.scottlogic.com/2019/05/17/webassembly-compiler.html

[* module]
https://webassembly.org/docs/modules/
