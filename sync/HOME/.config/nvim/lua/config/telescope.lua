local M = {}

function M.setup()
  local actions = require "telescope.actions"
  local telescope = require "telescope"
  -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#mapping-c-u-to-clear-prompt
  ---@diagnostic disable-next-line
  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ["<c-[>"] = actions.close,
          -- clear. not preview scroll
          ["<C-u>"] = false,
        },
      },
      layout_config = {
        vertical = { width = 0.95 },
        -- other layout configuration here
      },
    },
  }

  -- telescope.load_extension("ghq")
  -- telescope.load_extension "projects"
  -- telescope.load_extension "packer"

  local builtin = require "telescope.builtin"
  local frecency = require("telescope").extensions.frecency

  local function frecency_cwd()
    frecency.frecency { workspace = "CWD" }
  end

  local function git_files()
    builtin.git_files {
      show_untracked = true,
      file_ignore_patterns = { ".cache" },
    }
  end
  vim.keymap.set("n", "<C-P>", builtin.keymaps)
  -- vim.keymap.set("n", "<Leader><Space>", builtin.live_grep, { noremap = true })
  vim.keymap.set("n", "<Leader><Space>", git_files, { noremap = true })
  vim.keymap.set("n", "<Leader>b", builtin.buffers, { noremap = true })
  vim.keymap.set("n", "<Leader>h", builtin.help_tags, { noremap = true })
  -- vim.keymap.set("n", "<F3>", ":<C-u>Telescope ghq list<CR>", {})
end

return M
