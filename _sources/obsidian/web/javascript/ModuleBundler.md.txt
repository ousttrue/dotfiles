[[javascript]]

- @2023 [Module Bundlerの歴史を振り返って今採用すべきBundlerを考える](https://tyotto-good.com/module-bundler/history)
- @2016 [Rollupがちょうどいい感じ #JavaScript - Qiita](https://qiita.com/cognitom/items/e3ac0da00241f427dad6)

# vite
[[Vite]]

# rollup
- [ESM + Typescript + Jest の monorepo を Lerna と Rollup で npm に上がるまで](https://zenn.dev/mkpoli/articles/1d11ee2edd5bee#rollup-%E3%82%92%E4%BD%BF%E3%81%86)
- @2019 [Rollup 1.0、ライブラリバンドリングにコード分割をもたらす](https://www.infoq.com/jp/news/2019/05/rollup-code-splitting/)

```
> npx rollup -c
```

`rollup.config.js`
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
