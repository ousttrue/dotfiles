https://taskfile.dev/ja-JP/

- [go-task のデフォルトタスク](https://zenn.dev/raki/articles/2024-12-20_raki)

```yaml
# yaml-language-server: $schema=https://taskfile.dev/schema.json
# https://taskfile.dev/

version: "3"

tasks:
  default:
    cmds:
      - task --list --sort alphanumeric -t {{.TASKFILE}}
    silent: true
```
