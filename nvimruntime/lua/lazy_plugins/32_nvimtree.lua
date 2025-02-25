-- https://github.com/nvim-tree/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local function on_attach(bufnr)
      local api = require "nvim-tree.api"

      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      -- vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts "Up")
      vim.keymap.set("n", "?", api.tree.toggle_help, opts "Help")
      vim.keymap.set("n", "<C-[>", api.tree.close, opts "quit")
    end

    require("nvim-tree").setup {
      on_attach = on_attach,
      view = {
        float = {
          enable = true,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = vim.o.columns,
            height = vim.o.lines,
          },
        },
      },
    }

    -- vim.keymap.set("n", "<C-e>", ":NvimTreeOpen<CR>", {})
    vim.keymap.set("n", "<C-e>", ":NvimTreeFindFile<CR>", {})
  end,
}
