[[vite]]

[Rollup | Rollup](https://rollupjs.org/)

- [ESM + Typescript + Jest の monorepo を Lerna と Rollup で npm に上がるまで](https://zenn.dev/mkpoli/articles/1d11ee2edd5bee#rollup-%E3%82%92%E4%BD%BF%E3%81%86)
- @2023 [古い環境からViteへの載せ替えについて – wit](https://whyisthis.dev/others/old-env-to-vite/)
- @2022 [Viteで従来型静的サイトの開発環境を構築するためにプラグインをたくさん作った #TypeScript - Qiita](https://qiita.com/macropygia/items/d37fd20a16fcef26914b)
- @2019 [Rollup 1.0、ライブラリバンドリングにコード分割をもたらす](https://www.infoq.com/jp/news/2019/05/rollup-code-splitting/)
- [x] @2016 [Rollupがちょうどいい感じ #JavaScript - Qiita](https://qiita.com/cognitom/items/e3ac0da00241f427dad6)

# Version
## 4
- @2023

# 実行
## 単体
`input`, `output`

## as lib


# config
```sh
// build
rollup -c
```

`rollup.config.js`
- @2019 [最近作ったRollup.jsの設定詳細 (2019年7月版) #es6 - Qiita](https://qiita.com/otolab/items/95313254b62f5c0b6c10)

```js
import path from 'path'
const PACKAGE_ROOT_PATH = process.cwd()
import includePaths from 'rollup-plugin-includepaths';
export default [
  {
    input: path.join(PACKAGE_ROOT_PATH, 'out', 'browser', 'public', 'Terminal.mjs'),
    output: [
      {
        file: `dist/xterm.mjs`,
        format: 'esm',
        sourcemap: true,
      },
    ],
    plugins: [
      includePaths({ paths: ["./out"] })
    ]
  }
]
```

```js
// rollup.config.js
import nodeResolve from 'rollup-plugin-node-resolve' 
import commonjs from 'rollup-plugin-commonjs' 
import babel from 'rollup-plugin-babel' 

export default { 
	entry: 'src/main.js', 
	dest: 'dist/bundle.js', 
	plugins: [ 
		nodeResolve({ jsnext: true }), // npmモジュールを`node_modules`から読み込む 
		commonjs(), // CommonJSモジュールをES6に変換 
		babel() // ES5に変換 
	] 
}
```

# as lib
```js
// build.js
const
  rollup = require('rollup'),
  npm = require('rollup-plugin-npm'),
  commonjs = require('rollup-plugin-commonjs'),
  babel = require('rollup-plugin-babel'),
  name = 'awesomeapp'

rollup
  .rollup({
    // rollup.config.jsと同じようにentryやpluginを指定
    entry: 'dist/main.js',
    plugins: [npm({ jsnext: true }), commonjs(), babel()]
  })
  .then(bundle => {
    // ES6形式で出力
    bundle.write({ format: 'es6', dest: `dist/${name}.es6.js` })
    // AMD形式で出力
    bundle.write({ format: 'amd', dest: `dist/${name}.amd.js` })
    // CommonJSで出力
    bundle.write({ format: 'cjs', dest: `dist/${name}.cjs.js` })
    // グローバル変数を使う形式で出力
    bundle.write({
      format: 'iife',
      dest: `dist/${name}.js`,
      moduleName: name // iifeで出力する場合は、moduleNameの指定が必須
    })
  })
  .catch(error => {
    console.error(error)
  })
```


# plugin
[[rollup_plugin]]
