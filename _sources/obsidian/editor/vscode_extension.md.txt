[[vscode]]

[GitHub - microsoft/vscode-extension-samples: Sample code illustrating the VS Code extension API.](https://github.com/Microsoft/vscode-extension-samples)

[Extension Examples | 非公式 - Visual Studio Code Docs](https://vscode-doc-jp.github.io/docs/extensions/samples.html)
	- https://vscode-doc-jp.github.io/docs/extensions/example-hello-world.html
	- https://vscode-doc-jp.github.io/docs/extensions/example-word-count.html
	- https://vscode-doc-jp.github.io/docs/extensions/debugging-extensions.html
	
- [VS CodeのエクステンションをMarketPlaceに公開する - Qiita](https://qiita.com/YuichiNukiyama/items/ffcb32188f473b92133d)
- [Visual Studio Code 拡張機能のメッセージを言語設定に合わせてローカライズしてみる - Qiita](https://qiita.com/satokaz/items/f01ab4fc7f938904f5ae)

# package.json
## contributes
- [Contribution Points | Visual Studio Code Extension API](https://code.visualstudio.com/api/references/contribution-points)
### configuration

```json
{
  "contributes": {
    "configuration": {
      "title": "TypeScript",
      "properties": {
        "typescript.useCodeSnippetsOnMethodSuggest": {
          "type": "boolean",
          "default": false,
          "description": "Complete functions with their parameter signature."
        },
        "typescript.tsdk": {
          "type": ["string", "null"],
          "default": null,
          "description": "Specifies the folder path containing the tsserver and lib*.d.ts files to use."
        }
      }
    }
  }
}
```

[VSCode 拡張機能開発について](https://zenn.dev/yhsi/scraps/36dbb868d8322c)

```ts
  const config = vscode.workspace.getConfiguration("luaTestAdapter");
  const value = config.get<string>(section);
  // ${workspaceFolder} などの展開はここで手で実装するべし？
```

#### properties

# TextDOcumentContentProvider
[File System API | Visual Studio Code Extension API](https://code.visualstudio.com/api/extension-guides/virtual-documents)
- [VSCodeに英語翻訳拡張機能を自作する https://cfm-art.sakura.ne.jp/sys/archives/1106]
- https://satopirka.com/2017/12/vscodeのextensionを作った話/
- https://tekunabe.hatenablog.jp/entry/2019/01/12/vscode-l2mdtable
