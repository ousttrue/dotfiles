local M = {}

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  --vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  --vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
  vim.keymap.set("n", "<C-e>", function() end, { buffer = bufnr })
  vim.keymap.set("n", "u", api.tree.change_root_to_parent, { buffer = bufnr })
  vim.keymap.set("n", "h", api.node.navigate.parent_close, { buffer = bufnr })
end

function M.setup()
  -- vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", { noremap = true })
  vim.keymap.set("n", "<Leader>e", ":NvimTreeFindFileToggle<CR>", { noremap = true })

  require("nvim-tree").setup {
    -- sync_root_with_cwd = true,
    -- respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    view = {
      width = 36,
      -- float = {
      --     enable = true,
      --     quit_on_focus_loss = true,
      --     open_win_config = {
      --         relative = "editor",
      --         border = "rounded",
      --         width = 30,
      --         height = 30,
      --         row = 1,
      --         col = 1,
      --     },
      -- },
    },
    renderer = {
      indent_width = 1,
      indent_markers = {
        enable = true,
      },
      -- icons = {
      --   glyphs = {
      --     git = {
      --       unstaged = "",
      --       staged = "✓",
      --       unmerged = "",
      --       renamed = "➜",
      --       untracked = "ﰂ",
      --       deleted = "ﯰ",
      --       ignored = "◌",
      --     },
      --   },
      -- },
    },
    filters = {
      -- dotfiles = true,
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = false,
        global = false,
        restrict_above_cwd = false,
      },
    },
    on_attach = my_on_attach,
  }
end

return M
