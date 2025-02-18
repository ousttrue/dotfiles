# no prefix

| key | custom                          | default               | +          |
| --- | ------------------------------- | --------------------- | ---------- |
| K   | カーソル下を split/float したい | lsp.buf.hover()       | keywordprg |
| Q   |                                 | close current content |

# ][

| key | custom            | default    |
| --- | ----------------- | ---------- |
| d   |                   | diagnostic |
| ][  | `:cnext` `:cprev` | section    |

# ctrl

| key                  | note                                   |
| -------------------- | -------------------------------------- |
| ctrl-d               | `:quit`                                |
| ctrl-n/p             | hover の next/prev                     |
| ctrl-o / ctrl-i(Tab) | `Tab / Shift-Tab` と `ctrl-o` に分けた |

# g

| key | custom                  | default                        |
| --- | ----------------------- | ------------------------------ |
| ga  | diagnostics ?           | message: charcode under cursor |
| gb  |                         |
| gc  |                         | comment                        |
| gd  |                         | goto local definition          |
| gD  |                         | goto global declaration        |
| ge  |                         |
| gf  | gF                      | edit under cursor              |
| gF  |                         | edit line under cursor         |
| gg  |                         | home                           |
| gh  | TODO: help under cursor | select highlight               |
| gH  |                         | select highlight line          |
| gq  |                         | lsp format ?                   |
| gr  | lsp ref                 |
| gx  |                         | jump under cursor              |

# <SPACE> (leader)

| key |       |
| --- | ----- |
| p   | files |
