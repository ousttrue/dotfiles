return {
  {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.6",
    dependencies = {
      "danielfalk/smart-open.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "xiyaowong/telescope-emoji.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
      local ts_actions = require "telescope.actions"
      local ts_sorters = require "telescope.sorters"
      local ts_builtin = require "telescope.builtin"
      local ts_utils = require "telescope.utils"
      local ts_actions_layout = require "telescope.actions.layout"

      local ts = require "telescope"
      -- ts.load_extension "frecency"
      if vim.fn.has "win32" == 1 then
        vim.g.sqlite_clib_path = "D:/msys64/mingw64/bin/libsqlite3-0.dll"
      end

      local file_ignore_patterns = {
        "^node_modules[/\\]",
        "^%.git[/\\]",
        "^%.venv[/\\]",
        "^%.cache[/\\]",
      }
      -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#mapping-c-u-to-clear-prompt
      ts.setup {
        extensions = {
          -- frecency = {
          --   auto_validate = true,
          --   db_safe_mode = false,
          --   matcher = "fuzzy",
          --   path_display = { "filename_first" },
          -- },
        },
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--hidden",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          file_ignore_patterns = file_ignore_patterns,
          mappings = {
            i = {
              -- ["<c-[>"] = actions.close,
              ["<Tab>"] = ts_actions_layout.toggle_preview,
              -- clear. not preview scroll
              ["<C-u>"] = false,
              ["<C-f>"] = { "<Right>", type = "command" },
              ["<C-b>"] = { "<Left>", type = "command" },
              -- clear input to eol
              ["<C-k>"] = { "<C-o>d$", type = "command" },
              -- ["<C-h>"] = "which_key",
              ["<C-Down>"] = ts_actions.cycle_history_next,
              ["<C-Up>"] = ts_actions.cycle_history_prev,
            },
          },
          file_sorter = ts_sorters.get_generic_fuzzy_sorter,
          -- initial_mode = "normal",
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            width = 0.95,
            height = 0.95,
            prompt_position = "top",
          },
          selection_caret = " ",
          multi_icon = "✓ ",
          dynamic_preview_title = true,
        },
        -- https://www.reddit.com/r/neovim/comments/16ikt0q/telescope_live_grep_search_some_hidden_files/
        pickers = {
          git_files = {
            show_untracked = true,
            hidden = false,
          },
          find_files = {
            follow = true,
            ignore = false,
            hidden = false,
          },
        },
      }

      --
      -- keymap
      --
      local OBS_DIR = vim.fs.joinpath(vim.fn.fnamemodify("~", ":p"), "dotfiles/docs/obsidian")
      if GET_SYSTEM() == "windows" then
        OBS_DIR = OBS_DIR:gsub("/", "\\"):gsub("\\+", "\\")
        if OBS_DIR[2] == ":" then
          OBS_DIR = OBS_DIR[1]:upper() .. ":" .. OBS_DIR:sub(3)
        end
      end

      local C_P = "<Leader>p"
      if vim.startswith(vim.loop.cwd() or "", OBS_DIR) then
        vim.keymap.set("n", C_P, ts_builtin.find_files, { noremap = true })
      else
        -- https://www.reddit.com/r/neovim/comments/p1xj92/make_telescope_git_files_revert_back_to_find/
        local function project_files()
          local _, ret, _ = ts_utils.get_os_command_output {
            "git",
            "rev-parse",
            "--is-inside-work-tree",
          }
          if ret == 0 then
            ts_builtin.git_files {
              show_untracked = true,
              -- file_ignore_patterns = { ".cache" },
              hidden = false,
            }
          else
            ts_builtin.find_files {
              follow = true,
              hidden = false,
            }
          end
        end
        vim.keymap.set("n", C_P, project_files, { noremap = true })
      end

      local function grep_under_cursor()
        local word = vim.fn.expand "<cword>"
        ts_builtin.live_grep {
          cwd = vim.fn.getcwd(),
          hidden = true,
        }
        if #word > 0 then
          vim.cmd("normal! i\\b" .. word .. "\\b")
        end
      end
      vim.keymap.set("n", "<Leader>g", grep_under_cursor, { noremap = true })
      -- vim.keymap.set("n", "<Leader> ", ":Telescope frecency<CR>", { silent = true, noremap = true })
    end,
  },
}
