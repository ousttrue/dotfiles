# FileType event

## if found treesitter

- [How to get treesitter parser based on filetype if parser name differs? - Tree-sitter - Neovim Discourse](https://neovim.discourse.group/t/how-to-get-treesitter-parser-based-on-filetype-if-parser-name-differs/2479)

- TSInstall
- TSEnable

```lua
print(require("nvim-treesitter.parsers").filetype_to_parsername["cs"])
```

## else

- enable
