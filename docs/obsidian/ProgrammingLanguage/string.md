埋め込み文字列

# python

https://docs.python.org/3.8/reference/lexical_analysis.html#f-strings

`f-string` `Formatted string literals`

```py
name = 'world'
str = f'hello {name}'
```

# js

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals

`Template literals` `Template strings`

```js
const name = "world";
const str = `hello ${name}`;
```

## vscode

`powershell` と同じ感じ

```json
{
  hoge = "${workspaceFolder}",
  path = "${env:PATH}",
}
```

# powershell

部分式展開

- single quote は展開されない

```powershell
$str = "1 + 2 = $(1 + 2)"
```

文字列展開

```powershell
$name = 'world'
$str = "helo $name"
$str = "helo ${name}"
```

環境変数

```powershell
$env:PATH += ";C:\dir"
```
