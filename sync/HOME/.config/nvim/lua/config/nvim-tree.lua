local M = {}

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
      mappings = {
        list = {
          -- remove a default mapping
          { key = "<C-e>", action = "" },
          { key = "u", action = "dir_up" },
          { key = "h", action = "close_node" },
        },
      },
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
  }
end

return M
