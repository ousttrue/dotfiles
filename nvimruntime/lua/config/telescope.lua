local M = {}

local file_ignore_patterns = {
  "^node_modules[/\\]",
  "^%.git[/\\]",
  "^%.venv[/\\]",
  "^%.cache[/\\]",
}

local OBS_DIR = vim.fs.joinpath(vim.fn.fnamemodify("~", ":p"), "dotfiles/docs/obsidian")
if GET_SYSTEM() == "windows" then
  OBS_DIR = OBS_DIR:gsub("/", "\\"):gsub("\\+", "\\")
  if OBS_DIR[2] == ":" then
    OBS_DIR = OBS_DIR[1]:upper() .. ":" .. OBS_DIR:sub(3)
  end
end

local function setup_keymap()
  vim.keymap.set("n", "<Leader><Leader>", "<Cmd>Telescope<CR>", { noremap = true })

  local project_files_key = "<C-u>"
  if vim.startswith(vim.loop.cwd() or "", OBS_DIR) then
    -- print "OBS_DIR"
    vim.keymap.set("n", project_files_key, require("telescope.builtin").find_files, { noremap = true })
  else
    -- https://www.reddit.com/r/neovim/comments/p1xj92/make_telescope_git_files_revert_back_to_find/
    local function project_files(args)
      local name = vim.fn.expand "%"

      local _, ret, _ = require("telescope.utils").get_os_command_output {
        "git",
        "rev-parse",
        "--is-inside-work-tree",
      }
      if ret == 0 then
        require("telescope.builtin").git_files {
          show_untracked = true,
          -- file_ignore_patterns = { ".cache" },
          hidden = false,
        }
      else
        require("telescope.builtin").find_files {
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
    require("telescope.builtin").live_grep {
      cwd = vim.fn.getcwd(),
      hidden = true,
    }
    if #word > 0 then
      vim.cmd("normal! i\\b" .. word .. "\\b")
    end
  end
  vim.keymap.set("n", "<Leader>g", grep_under_cursor, { noremap = true })

  vim.keymap.set("n", "<Leader>b", require("telescope.builtin").buffers, { noremap = true })

  local function help_under_cursor()
    local word = vim.fn.expand "<cword>"
    require("telescope.builtin").help_tags()
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
end

function M.setup()
  local emoji = require("telescope").load_extension "emoji"
  if vim.fn.has "win32" == 1 then
    vim.g.sqlite_clib_path = "D:/msys64/mingw64/bin/libsqlite3-0.dll"
  end

  -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#mapping-c-u-to-clear-prompt
  require("telescope").setup {
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
          -- ["<Tab>"] = require "telescope.actions.layout".toggle_preview,
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
          ["<C-Down>"] = require("telescope.actions").cycle_history_next,
          ["<C-Up>"] = require("telescope.actions").cycle_history_prev,

          ["<CR>"] = require("telescope.actions").select_default + require("telescope.actions").center,
          -- qfs
          ["<C-G><C-G>"] = require("qfscope.actions").qfscope_search_filename,
          ["<C-G><C-F>"] = require("qfscope.actions").qfscope_grep_filename,
          ["<C-G><C-L>"] = require("qfscope.actions").qfscope_grep_line,
          ["<C-G><C-T>"] = require("qfscope.actions").qfscope_grep_text,
        },
      },
      file_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
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

  setup_keymap()
end

return M
