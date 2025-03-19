return {
  {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.6",
    dependencies = {
      "danielfalk/smart-open.nvim",
      "nvim-lua/plenary.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- ex
      "nvim-telescope/telescope-frecency.nvim",
      "xiyaowong/telescope-emoji.nvim",
      "atusy/qfscope.nvim",
    },
    config = function()
      local ts_actions = require "telescope.actions"
      local ts_sorters = require "telescope.sorters"
      local ts_builtin = require "telescope.builtin"
      local ts_utils = require "telescope.utils"
      local ts_actions_layout = require "telescope.actions.layout"
      local qfs_actions = require "qfscope.actions"

      local ts = require "telescope"
      local emoji = ts.load_extension "emoji"
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
              -- ["<Tab>"] = ts_actions_layout.toggle_preview,
              ["<Tab>"] = false,
              ["<S-Tab>"] = false,
              -- clear. not preview scroll
              ["<C-u>"] = false,
              --
              ["<C-a>"] = { "<home>", type = "command" },
              ["<C-e>"] = { "<end>", type = "command" },
              --
              ["<C-f>"] = { "<Right>", type = "command" },
              ["<C-b>"] = { "<Left>", type = "command" },
              -- clear input to eol
              ["<C-k>"] = { "<C-o>d$", type = "command" },
              -- ["<C-h>"] = "which_key",
              ["<C-Down>"] = ts_actions.cycle_history_next,
              ["<C-Up>"] = ts_actions.cycle_history_prev,

              ["<CR>"] = ts_actions.select_default + ts_actions.center,
              -- qfs
              ["<C-G><C-G>"] = qfs_actions.qfscope_search_filename,
              ["<C-G><C-F>"] = qfs_actions.qfscope_grep_filename,
              ["<C-G><C-L>"] = qfs_actions.qfscope_grep_line,
              ["<C-G><C-T>"] = qfs_actions.qfscope_grep_text,
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

      local project_files_key = "<C-u>"
      if vim.startswith(vim.loop.cwd() or "", OBS_DIR) then
        -- print "OBS_DIR"
        vim.keymap.set("n", project_files_key, ts_builtin.find_files, { noremap = true })
      else
        -- https://www.reddit.com/r/neovim/comments/p1xj92/make_telescope_git_files_revert_back_to_find/
        local function project_files(args)
          local name = vim.fn.expand "%"

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

          local pos = name:find "/[^/]+$"
          if pos then
            local word = name:sub(1, pos)
            vim.cmd("normal! i" .. word)
          end
        end
        vim.keymap.set("n", project_files_key, project_files, { noremap = true })
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

      vim.keymap.set("n", "<Leader>b", ts_builtin.buffers, { noremap = true })

      local function help_under_cursor()
        local word = vim.fn.expand "<cword>"
        ts_builtin.help_tags()
        if #word > 0 then
          vim.cmd("normal! i" .. word)
        end
      end
      vim.keymap.set("n", "<space>h", help_under_cursor, { noremap = true })

      local function jump()
        local jumplist = vim.fn.getjumplist()
        require("telescope.builtin").jumplist {
          on_complete = {
            function(self)
              -- select current
              local n = #jumplist[1]
              if n ~= jumplist[2] then
                self:move_selection(jumplist[2] - #jumplist[1] + 1)
              end
            end,
          },
        }
      end
      vim.keymap.set("n", "<space>j", jump, { noremap = true })
    end,
  },
}
