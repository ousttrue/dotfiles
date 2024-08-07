return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
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

      -- vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", { noremap = true })
      vim.keymap.set("n", "<Leader>e", ":NvimTreeFindFileToggle<CR>", { noremap = true })

      require("nvim-tree").setup {
        -- sync_root_with_cwd = true,
        -- respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          -- update_root = true,
          ignore_list = { ".git", "gitcommit" },
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
          indent_width = 2,
          indent_markers = {
            enable = true,
          },
          highlight_git = true,
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
          icons = {
            show = {
              git = false,
            },
          },
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
    end,
  },
  -- {
  --   "nvim-tree/nvim-web-devicons",
  --   config = function()
  --     require("nvim-web-devicons").setup {
  --       override = {
  --         fs = {
  --           icon = "󰯙 ",
  --           -- color = "#3178C6", -- TypeScriptの色
  --         },
  --         vs = {
  --           icon = "󰯙 ",
  --           -- color = "#3178C6", -- TypeScriptの色
  --         },
  --         gs = {
  --           icon = "󰯙 ",
  --           -- color = "#3178C6", -- TypeScriptの色
  --         },
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --     -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  --   },
  --   config = require("config.neo-tree").setup,
  -- },
  -- {
  --   "tamago324/lir.nvim",
  --   dependencies = "nvim-lua/plenary.nvim",
  --   config = function()
  --     local actions = require "lir.actions"
  --     local mark_actions = require "lir.mark.actions"
  --     local clipboard_actions = require "lir.clipboard.actions"
  --     require("lir").setup {
  --       show_hidden_files = false,
  --       ignore = {}, -- { ".DS_Store", "node_modules" } etc.
  --       devicons = {
  --         enable = false,
  --         highlight_dirname = false,
  --       },
  --       mappings = {
  --         ["l"] = actions.edit,
  --         ["<C-s>"] = actions.split,
  --         ["<C-v>"] = actions.vsplit,
  --         ["<C-t>"] = actions.tabedit,
  --
  --         ["h"] = actions.up,
  --         ["q"] = actions.quit,
  --
  --         ["K"] = actions.mkdir,
  --         ["N"] = actions.newfile,
  --         ["R"] = actions.rename,
  --         ["@"] = actions.cd,
  --         ["Y"] = actions.yank_path,
  --         ["."] = actions.toggle_show_hidden,
  --         ["D"] = actions.delete,
  --
  --         ["J"] = function()
  --           mark_actions.toggle_mark()
  --           vim.cmd "normal! j"
  --         end,
  --         ["C"] = clipboard_actions.copy,
  --         ["X"] = clipboard_actions.cut,
  --         ["P"] = clipboard_actions.paste,
  --       },
  --       float = {
  --         winblend = 0,
  --         curdir_window = {
  --           enable = false,
  --           highlight_dirname = false,
  --         },
  --
  --         -- -- You can define a function that returns a table to be passed as the third
  --         -- -- argument of nvim_open_win().
  --         -- win_opts = function()
  --         --   local width = math.floor(vim.o.columns * 0.8)
  --         --   local height = math.floor(vim.o.lines * 0.8)
  --         --   return {
  --         --     border = {
  --         --       "+", "─", "+", "│", "+", "─", "+", "│",
  --         --     },
  --         --     width = width,
  --         --     height = height,
  --         --     row = 1,
  --         --     col = math.floor((vim.o.columns - width) / 2),
  --         --   }
  --         -- end,
  --       },
  --       hide_cursor = true,
  --     }
  --
  --     vim.api.nvim_create_autocmd({ "FileType" }, {
  --       pattern = { "lir" },
  --       callback = function()
  --         -- use visual mode
  --         vim.api.nvim_buf_set_keymap(
  --           0,
  --           "x",
  --           "J",
  --           ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
  --           { noremap = true, silent = true }
  --         )
  --
  --         -- echo cwd
  --         vim.api.nvim_echo({ { vim.fn.expand "%:p", "Normal" } }, false, {})
  --       end,
  --     })
  --
  --     vim.keymap.set("n", "<c-p>", require("lir.float").toggle(), {})
  --   end,
  -- },
}
