---
aliases: [LanguageServerProtocol]
---

[[vscode]]
[[LSIF]]
[[codelens]]

- @2022 [言語サーバープロトコルの概要 - Visual Studio (Windows) | Microsoft Docs](https://docs.microsoft.com/ja-jp/visualstudio/extensibility/language-server-protocol?view=vs-2022)
- @2021 [SATySFi Language Server を作って快適に執筆してみた話](https://zenn.dev/monaqa/articles/2021-12-10-satysfi-language-server)
- @2021 [LSP のクライアントを実装してみたい - MemoBook](https://scrapbox.io/tamago324vim/LSP_%E3%81%AE%E3%82%AF%E3%83%A9%E3%82%A4%E3%82%A2%E3%83%B3%E3%83%88%E3%82%92%E5%AE%9F%E8%A3%85%E3%81%97%E3%81%A6%E3%81%BF%E3%81%9F%E3%81%84)
- @2020 [Language Server Protocol に対応したミニ言語処理系を作る](https://zenn.dev/takl/books/0fe11c6e177223)

# VSCode extension の実装
[[vscode]]
- [Language Server Extension Guide | Visual Studio Code Extension API](https://code.visualstudio.com/api/language-extensions/language-server-extension-guide)
- [vscode-extension-samples/lsp-sample at main · microsoft/vscode-extension-samples · GitHub](https://github.com/microsoft/vscode-extension-samples/tree/main/lsp-sample)

# Language Server Protocol
- `2016年6月に、Microsoftがlanguage server protocol公開`

- [Official page for Language Server Protocol](https://microsoft.github.io/language-server-protocol/)
	- [Language Servers](https://microsoft.github.io/language-server-protocol/implementors/servers/)
	- [GitHub - microsoft/vscode-extension-samples: Sample code illustrating the VS Code extension API.](https://github.com/microsoft/vscode-extension-samples)


## Client: vscode
- [Language Server Extension Guide | Visual Studio Code Extension API](https://code.visualstudio.com/api/language-extensions/language-server-extension-guide)
- [vscode-extension-samples/lsp-sample at main · microsoft/vscode-extension-samples · GitHub](https://github.com/microsoft/vscode-extension-samples/tree/main/lsp-sample)
- [LSP学習記 #1 - Qiita](https://qiita.com/vain0x/items/d050fe7c8b342ed2004e)
- [Pyright を LSP サーバとした自作 LSP クライアント（調査編） | フューチャー技術ブログ](https://future-architect.github.io/articles/20220302a/)

### LanguageClient
- [GitHub - microsoft/vscode-languageserver-node: Language server protocol implementation for VSCode. This allows implementing language services in JS/TS running on node.js](https://github.com/microsoft/vscode-languageserver-node)
- [xtext-languageserver-example/extension.ts at master · itemis/xtext-languageserver-example · GitHub](https://github.com/itemis/xtext-languageserver-example/blob/master/vscode-extension/src/extension.ts)
- [Language Client を作る｜Language Server Protocol に対応したミニ言語処理系を作る](https://zenn.dev/takl/books/0fe11c6e177223/viewer/096a43)

## Server

### textdocument/didOpen
- @2020 [LSP 実装メモ (Text Document Synchronization `textDocument/didOpen` 編) - あれ](https://tennashi.hatenablog.com/entry/2020/07/25/230916)

### textdocument/didChange
- @2020 [LSP 実装メモ (Text Document Synchronization `textDocument/didChange` 編) - あれ](https://tennashi.hatenablog.com/entry/2020/08/01/201225)

## Language Features
-   code comprehension features like Hover or Goto Definition.
-   coding features like diagnostics, code complete or code actions.

 ### textDocument/completion
 [textDocument/completion](https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocument_completion)


## LSIF: Language Server Index Format
[LSIF.dev](https://lsif.dev/)
- @2019 [Language Server Index Format](https://code.visualstudio.com/blogs/2019/02/19/lsif)
- @2020 [LSPから派生したLanguage Server Index Formatとは何か - Qiita](https://qiita.com/nakario/items/2a73065a1bc1540c1f00)

## vim
- [GitHub - dense-analysis/ale: Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support](https://github.com/w0rp/ale)
- [GitHub - jsfaint/gen_tags.vim: Async plugin for vim and neovim to ease the use of ctags/gtags](https://github.com/jsfaint/gen_tags.vim)

## c++
- [GitHub - jacobdufault/cquery: C/C++ language server supporting multi-million line code base, powered by libclang. Emacs, Vim, VSCode, and others with language server protocol support. Cross references, completion, diagnostics, semantic highlighting and more](https://github.com/cquery-project/cquery)
- [Building cquery · jacobdufault/cquery Wiki · GitHub](https://github.com/cquery-project/cquery/wiki/Building-cquery)

## python
[[python_lsp]]

## csharp
- [GitHub - OmniSharp/csharp-language-server-protocol: Language Server Protocol in C#](https://github.com/OmniSharp/csharp-language-server-protocol)
