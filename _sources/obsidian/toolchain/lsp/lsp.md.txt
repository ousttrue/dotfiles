---
aliases: [LanguageServerProtocol]
---

> `2016年6月に、Microsoftがlanguage server protocol公開`

- [コンパイラを書いてセルフホストした](https://zenn.dev/myuon/articles/76047d5d575346)

[[vscode]]
[[vscode_extension]]
[[LSIF]]
[[codelens]]

- @2022 [言語サーバープロトコルの概要 - Visual Studio (Windows) | Microsoft Docs](https://docs.microsoft.com/ja-jp/visualstudio/extensibility/language-server-protocol?view=vs-2022)

# tutorial

- [Language Server Extension Guide | Visual Studio Code Extension API](https://code.visualstudio.com/api/language-extensions/language-server-extension-guide)
- [vscode-extension-samples/lsp-sample at main · microsoft/vscode-extension-samples · GitHub](https://github.com/microsoft/vscode-extension-samples/tree/main/lsp-sample)

# impl

[[lsp_impl]]

## python

- @2022 [Pyright を LSP サーバとした自作 LSP クライアント（実装編） | フューチャー技術ブログ](https://future-architect.github.io/articles/20220303a/)
- @2022 [Pyright を LSP サーバとした自作 LSP クライアント（調査編） | フューチャー技術ブログ](https://future-architect.github.io/articles/20220302a/)
- ⭐@2021 [VSCode用の言語サーバ拡張機能をPythonでつくってみた - Qiita](https://qiita.com/www-tacos/items/23e63c4572c9f52b9825)

## golang

- @2020 [すべてのエディタでSQLの自動補完をするためにSQL Language Server(sqls)を作った - Qiita](https://qiita.com/lighttiger2505/items/5782debc59ae163a4d81)
  - [Golangで作るSQL Language Server(sqls) - Speaker Deck](https://speakerdeck.com/lighttiger2505/golangdezuo-rusql-language-server-sqls)

# linter & formatter

- [[efm-languageserver]]
- [GitHub - iamcco/diagnostic-languageserver: diagnostic language server integrate with linters](https://github.com/iamcco/diagnostic-languageserver)

# client

client を開始し、server を起動する。

```json
	"dependencies": {
		"vscode-languageclient": "^7.0.0"
	},
```

- [vscode-languageclient - npm](https://www.npmjs.com/package/vscode-languageclient)
- [GitHub - microsoft/vscode-languageserver-node: Language server protocol implementation for VSCode. This allows implementing language services in JS/TS running on node.js](https://github.com/microsoft/vscode-languageserver-node)

### ServerOptions

#### module

```json
	const serverOptions: ServerOptions = {
		run: {
			module: serverModule,
			transport: TransportKind.ipc
		},
		debug: {
			module: serverModule,
			transport: TransportKind.ipc,
			options: debugOptions
		}
	};
```

#### command

`stdout & stdin`

```json
const serverOptions = {
	command: "node",
	args: [
		context.extensionPath + "/oreore.js",
		"--language-server"
	]
};
```

zls

```ts
let serverOptions: ServerOptions = {
  command: zlsPath,
  args: debugLog ? ["--enable-debug-log"] : [],
};
```

#### TCP

- [python-language-server/extension.ts at develop · palantir/python-language-server · GitHub](https://github.com/palantir/python-language-server/blob/develop/vscode-client/src/extension.ts#L27)

```ts
const serverOptions: ServerOptions = function () {
  return new Promise((resolve, reject) => {
    var client = new net.Socket();
    client.connect(addr, "127.0.0.1", function () {
      resolve({
        reader: client,
        writer: client,
      });
    });
  });
};
```

# Languages

## zig

- [GitHub - zigtools/zls-vscode: ZLS Client for VSCode](https://github.com/zigtools/zls-vscode)

## c++

### ccls

- [GitHub - MaskRay/ccls: C/C++/ObjC language server supporting cross references, hierarchies, completion and semantic highlighting](https://github.com/MaskRay/ccls)

### cquery

- [GitHub - jacobdufault/cquery: C/C++ language server supporting multi-million line code base, powered by libclang. Emacs, Vim, VSCode, and others with language server protocol support. Cross references, completion, diagnostics, semantic highlighting and more](https://github.com/cquery-project/cquery)
- [Building cquery · jacobdufault/cquery Wiki · GitHub](https://github.com/cquery-project/cquery/wiki/Building-cquery)

### LspCpp

- [GitHub - kuafuwang/LspCpp: A Language Server Protocol implementation in C++](https://github.com/kuafuwang/LspCpp)

## python

[[python_lsp]]

## sphinx

- [GitHub - swyddfa/esbonio: A language server for working with Sphinx projects.](https://github.com/swyddfa/esbonio)

## csharp

[[OmniSharp]]

## markdown

- [「Visual Studio Code」のMarkdown機能が言語サーバーに ～他のエディター、ツールでの活用に道筋 - 窓の杜](https://forest.watch.impress.co.jp/docs/news/1432780.html)

# LSIF: Language Server Index Format

[LSIF.dev](https://lsif.dev/)

- @2019 [Language Server Index Format](https://code.visualstudio.com/blogs/2019/02/19/lsif)
- @2020 [LSPから派生したLanguage Server Index Formatとは何か - Qiita](https://qiita.com/nakario/items/2a73065a1bc1540c1f00)
