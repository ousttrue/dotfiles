[[javascript]]

- @2023 [tyotto-good.com/module-bundler/history](https://tyotto-good.com/module-bundler/history)

# rollup
- [ESM + Typescript + Jest の monorepo を Lerna と Rollup で npm に上がるまで](https://zenn.dev/mkpoli/articles/1d11ee2edd5bee#rollup-%E3%82%92%E4%BD%BF%E3%81%86)

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
