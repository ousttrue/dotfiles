local M = {}
local DOT = require "dot"

function M.setup()
  local actions = require "telescope.actions"
  local telescope = require "telescope"
  local sorters = require "telescope.sorters"
  local builtin = require "telescope.builtin"
  local utils = require "telescope.utils"
  telescope.load_extension "emoji"
  telescope.load_extension "notify"
  -- telescope.load_extension("ui-select")

  -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#mapping-c-u-to-clear-prompt
  ---@diagnostic disable-next-line
  local setup = {
    defaults = {
      mappings = {
        i = {
          ["<c-[>"] = actions.close,
          -- clear. not preview scroll
          ["<C-u>"] = false,
        },
      },
      file_sorter = sorters.get_generic_fuzzy_sorter,
      -- initial_mode = "normal",

      sorting_strategy = "ascending",
      layout_strategy = "vertical",
      layout_config = {
        width = 0.95,
        height = 0.95,
        prompt_position = "top",
      },
    },
  }

  if DOT.get_system() ~= "msys" then
    setup.vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob",
      "!.git",
    }
  end

  telescope.setup(setup)

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
  -- vim.keymap.set("n", "<C-P>", builtin.keymaps)

  vim.keymap.set("n", "<Leader><Space>", project_files, { noremap = true })
  vim.keymap.set("n", "<Leader>g", function()
    local word = vim.fn.expand "<cword>"
    builtin.live_grep {
      cwd = vim.fn.getcwd(),
    }
    if #word > 0 then
      vim.cmd("normal! i\\b" .. word .. "\\b")
    end
  end, { noremap = true })
  vim.keymap.set("n", "[[", builtin.resume, { noremap = true })
  vim.keymap.set("n", "<Leader>b", builtin.buffers, { noremap = true })
  vim.keymap.set("n", "<Leader>h", builtin.help_tags, { noremap = true })
  -- vim.keymap.set("n", "<F3>", ":<C-u>Telescope ghq list<CR>", {})
  vim.keymap.set("n", "<leader>f", ":Telescope find_files<cr>" .. "'" .. vim.fn.expand "<cword>")

  -- vim.keymap.set("n", "*", function()
  --   local word = vim.fn.expand "<cword>"
  --   builtin.current_buffer_fuzzy_find()
  --   -- builtin.grep_string { shorten_path = true, word_match = "-w", only_sort_text = true, search = "" }
  --   if #word > 0 then
  --     vim.cmd("normal! i" .. word)
  --   end
  -- end, { noremap = true })
end

return M
