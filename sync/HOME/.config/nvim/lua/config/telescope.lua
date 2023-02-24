local M = {}

function M.setup()
  local actions = require "telescope.actions"
  local telescope = require "telescope"
  local sorters = require "telescope.sorters"
  local builtin = require "telescope.builtin"
  local utils = require "telescope.utils"

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
      file_sorter = sorters.get_generic_fuzzy_sorter,
      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        width = 0.95,
        height = 0.95,
        prompt_position = "top",
      },
    },
  }

  -- https://www.reddit.com/r/neovim/comments/p1xj92/make_telescope_git_files_revert_back_to_find/
  local function project_files()
    local _, ret, _ = utils.get_os_command_output { "git", "rev-parse", "--is-inside-work-tree" }
    if ret == 0 then
      builtin.git_files {
        show_untracked = true,
        file_ignore_patterns = { ".cache" },
      }
    else
      builtin.find_files {
        follow = true,
      }
    end
  end
  vim.keymap.set("n", "<C-P>", builtin.keymaps)
  vim.keymap.set("n", "<Leader><Space>", project_files, { noremap = true })
  vim.keymap.set("n", ";;", "<cmd>Telescope<CR>", { noremap = true })
  vim.keymap.set("n", "<Leader>b", builtin.buffers, { noremap = true })
  vim.keymap.set("n", "<Leader>h", builtin.help_tags, { noremap = true })
  -- vim.keymap.set("n", "<F3>", ":<C-u>Telescope ghq list<CR>", {})
end

return M
