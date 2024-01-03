[Plugin Development | Rollup](https://rollupjs.org/plugin-development/)

# write

```js
import { createFilter } from 'rollup-pluginutils'

export default function uperCase(options = {}) {
  // options.include(=含める), options.exclude(=除外する)は対応が必須
  const filter = createFilter(options.include, options.exclude)
  return {
    transform(code, id) {
      if (!filter(id)) return null // ファイルパスでフィルターする
      return code.toUpperCase() // 変換したコードを返す
    }
  }
}
```

# plugins
[GitHub - rollup/plugins: 🍣 The one-stop shop for official Rollup plugins](https://github.com/rollup/plugins)

- rollup-plugin-node-resolve
- rollup-plugin-commonjs
- rollup-plugin-json

- [Rollup plugin](https://zenn.dev/marumarumeruru/articles/0262c9de7963b9)
