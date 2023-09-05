[[docker]]

- [Development containers](https://containers.dev/)
- [Dev Containers - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Developing inside a Container using Visual Studio Code Remote Development](https://code.visualstudio.com/docs/devcontainers/containers)

- @2022 [VSCode Devcontainer 放浪記](https://zenn.dev/streamwest1629/articles/vscode_wanderer-in-devcontainer)
- @2022 [devcontainer cli が便利だったので紹介します - MoguraDev](https://mogura.dev/articles/devcontainer-cli/)
- @2022 [Dev Container が VSCode から CLI にもやって来た](https://zenn.dev/hankei6km/articles/devcontainers-in-cli-ci)
- @2022 [dev container CLIとDevelopment Containers Specificationについて](https://zenn.dev/nmemoto/articles/devcontainer-cli)
- @2022 [Devcontainer(Remote Container) いいぞという話 ~開発環境を整える~ - Qiita](https://qiita.com/yoshii0110/items/c480e98cfe981e36dd56)
- @2022 [VSCode Dev Containerを使った開発環境構築 | KINTO Tech Blog | キントテックブログ](https://blog.kinto-technologies.com/posts/2022-12-10-VSCodeDevContainer/)

# folder
```
. (repo directory)
├ .devcointainer
│ ├ devcontainer.json (required)
│ ├ Dockerfile (optional)
│ ├ docker-compose.yml (optional)
```

## devcontainer.json
```json5
// For format details, see https://aka.ms/devcontainer.json. For config options, see the
// README at: https://github.com/devcontainers/templates/tree/main/src/cpp
{
	"name": "C++",
	"build": {
		"dockerfile": "Dockerfile"
	},

	// Features to add to the dev container. More info: https://containers.dev/features.
	// "features": {},

	// Configure tool-specific properties.
	"customizations": {
		// Configure properties specific to VS Code.
		"vscode": {
			"settings": {},
			"extensions": [
				"streetsidesoftware.code-spell-checker"
			]
		}
	}

	// Use 'forwardPorts' to make a list of ports inside the container available locally.
	// "forwardPorts": [],

	// Use 'postCreateCommand' to run commands after the container is created.
	// "postCreateCommand": "gcc -v",

	// Uncomment to connect as root instead. More info: https://aka.ms/dev-containers-non-root.
	// "remoteUser": "root"
}
```

# tutorial
- [Get started with development Containers in Visual Studio Code](https://code.visualstudio.com/docs/devcontainers/tutorial)
