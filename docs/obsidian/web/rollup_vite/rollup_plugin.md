[Plugin Development | Rollup](https://rollupjs.org/plugin-development/)

https://github.com/antfu/vite-plugin-inspect

# Output Generation Hooks


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

- @2022 [Rollup plugin](https://zenn.dev/marumarumeruru/articles/0262c9de7963b9)

# build hook

## options
`begin`

## buildStart
`begin`

## buildEnd
`end`

## closeBundle
`end`

## resolveId(source: string): string | null
`import`
- [x] @2023 [rollupのプラグインの仕組みを知る](https://zenn.dev/irico/scraps/7bd7210d6f2dc3)
string を返すと load に来る

## load(id: string): result
`import`
imort の中身？を返す

## transform
`import`
中身を書き換える

```ts
{ 
	transform (code, id) { 
		if (!filter(id)) return null  // ファイルパスでフィルターする 
		return code.toUpperCase()  // 変換したコードを返す 
	} 
}
```
