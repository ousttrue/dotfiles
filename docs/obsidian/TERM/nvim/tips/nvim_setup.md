[[nvim]]

`scriptnames`

- @2022 [vim沼: NeovimのReact、TypeScript、Tailwind CSS用セットアップ](https://zenn.dev/takuya/articles/4472285edbc132)

# first

lua を快適に編集する

- comment

```lua
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
      vim.api.nvim_set_keymap("n", "<C-_>", "gcc", {})
      vim.api.nvim_set_keymap("v", "<C-_>", "gc", {})
    end,
  },
```

- formatter

```lua
  {
    "ckipp01/stylua-nvim",
  },

local opts = { noremap = true, silent = true }
vim.api.nvim_buf_set_keymap(0, "n", "F", [[<cmd>lua require("stylua-nvim").format_file()<CR>]], opts)
```

- lualine

```lua
{
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end,
}
```

- git

```lua
"tpope/vim-fugitive",
```

# いろいろ

## highlgiht

## nvim-tree

## language server

## vscode task

## telescope

## tree-sitter
