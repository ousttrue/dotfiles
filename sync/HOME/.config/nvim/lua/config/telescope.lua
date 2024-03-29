local M = {}
local DOT = require "dot"

function M.setup()
  -- local actions = require "telescope.actions"
  local telescope = require "telescope"
  local sorters = require "telescope.sorters"
  local builtin = require "telescope.builtin"
  local utils = require "telescope.utils"
  local action_layout = require "telescope.actions.layout"
  -- telescope.load_extension "emoji"
  -- telescope.load_extension "notify"
  telescope.load_extension "ui-select"
  -- -- telescope.load_extension "live_grep_args"
  --
  -- -- https://github.com/nvim-telescope/telescope.nvim/issues/2027
  -- vim.api.nvim_create_autocmd("WinLeave", {
  --   callback = function()
  --     if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
  --       vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
  --     end
  --   end,
  -- })
  --

  local file_ignore_patterns = { "node_modules", ".git", ".venv", ".cache" }
  -- -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#mapping-c-u-to-clear-prompt
  -- ---@diagnostic disable-next-line
  telescope.setup {
    defaults = {
      --     vimgrep_arguments = {
      --       "rg",
      --       "--hidden",
      --       "--color=never",
      --       "--no-heading",
      --       "--with-filename",
      --       "--line-number",
      --       "--column",
      --       "--smart-case",
      --     },
      mappings = {
        i = {
          -- ["<c-[>"] = actions.close,
          ["<Tab>"] = action_layout.toggle_preview,
          -- clear. not preview scroll
          ["<C-u>"] = false,
          ["<C-f>"] = { "<Right>", type = "command" },
          ["<C-b>"] = { "<Left>", type = "command" },
          -- clear input to eol
          ["<C-k>"] = { "<C-o>d$", type = "command" },
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
    -- https://www.reddit.com/r/neovim/comments/16ikt0q/telescope_live_grep_search_some_hidden_files/
    pickers = {
      --     colorscheme = {
      --       enable_preview = true,
      --     },
      live_grep = {
        file_ignore_patterns = file_ignore_patterns,
        additional_args = function(_)
          return { "--hidden" }
        end,
      },
      git_files = {
        show_untracked = true,
        file_ignore_patterns = file_ignore_patterns,
        hidden = false,
      },
      find_files = {
        file_ignore_patterns = file_ignore_patterns,
        follow = true,
        hidden = false,
      },
    },
  }

  --
  -- keymap
  --
  local OBS_DIR = string.gsub(DOT.get_dotdir() .. "\\docs\\obsidian", "/", "\\")
  local C_P = "<C-p>"
  if vim.startswith(vim.loop.cwd() or "", OBS_DIR) then
    vim.keymap.set("n", C_P, builtin.find_files, { noremap = true })
  else
    -- https://www.reddit.com/r/neovim/comments/p1xj92/make_telescope_git_files_revert_back_to_find/
    local function project_files()
      local _, ret, _ = utils.get_os_command_output { "git", "rev-parse", "--is-inside-work-tree" }
      if ret == 0 then
        builtin.git_files {
          show_untracked = true,
          file_ignore_patterns = { ".cache" },
          hidden = false,
        }
      else
        builtin.find_files {
          follow = true,
          hidden = false,
        }
      end
    end
    vim.keymap.set("n", C_P, project_files, { noremap = true })
  end

  local function grep_under_cursor()
    local word = vim.fn.expand "<cword>"
    builtin.live_grep {
      cwd = vim.fn.getcwd(),
      hidden = true,
    }
    if #word > 0 then
      vim.cmd("normal! i\\b" .. word .. "\\b")
    end
  end
  vim.keymap.set("n", "<Leader>g", grep_under_cursor, { noremap = true })
  -- -- vim.keymap.set("n", "<leader>g", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
  -- vim.keymap.set("n", "<Leader>g", builtin.live_grep, { noremap = true })

  -- vim.keymap.set("n", "[[", builtin.resume, { noremap = true })
  vim.keymap.set("n", "<Leader><space>", builtin.buffers, { noremap = true })
  -- vim.keymap.set("n", "<Leader>h", builtin.help_tags, { noremap = true })
  -- -- vim.keymap.set("n", "<F3>", ":<C-u>Telescope ghq list<CR>", {})
  -- vim.keymap.set("n", "<leader>f", ":Telescope find_files<cr>" .. "'" .. vim.fn.expand "<cword>")
  --
  -- -- vim.keymap.set("n", "*", function()
  -- --   local word = vim.fn.expand "<cword>"
  -- --   builtin.current_buffer_fuzzy_find()
  -- --   -- builtin.grep_string { shorten_path = true, word_match = "-w", only_sort_text = true, search = "" }
  -- --   if #word > 0 then
  -- --     vim.cmd("normal! i" .. word)
  -- --   end
  -- -- end, { noremap = true })
end

return M
