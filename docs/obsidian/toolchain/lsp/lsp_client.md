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


