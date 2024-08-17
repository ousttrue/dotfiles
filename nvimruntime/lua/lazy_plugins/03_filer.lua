local nerdtree = {
  "preservim/nerdtree",
  config = function()
    vim.keymap.set("n", "<Leader>e", ":NERDTreeToggle<CR>", { noremap = true })
  end,
}
local nvim_tree = {
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
}
local drex = {
  "theblob42/drex.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    require("drex.config").configure {
      icons = {
        file_default = "",
        dir_open = "",
        dir_closed = "",
        link = "",
        others = "",
      },
      colored_icons = true,
      hide_cursor = true,
      hijack_netrw = false,
      keepalt = false,
      sorting = function(a, b)
        local aname, atype = a[1], a[2]
        local bname, btype = b[1], b[2]

        local aisdir = atype == "directory"
        local bisdir = btype == "directory"

        if aisdir ~= bisdir then
          return aisdir
        end

        return aname < bname
      end,
      drawer = {
        side = "left",
        default_width = 30,
        window_picker = {
          enabled = true,
          labels = "abcdefghijklmnopqrstuvwxyz",
        },
      },
      -- actions = {
      --   files = {
      --     delete_cmd = nil,
      --   },
      -- },
      disable_default_keybindings = false,
      keybindings = {
        ["n"] = {
          ["<C-m>"] = { '<cmd>lua require("drex.elements").expand_element()<CR>', { desc = "expand element" } },
        },
      },
      -- on_enter = nil,
      -- on_leave = nil,
    }

    vim.keymap.set("n", "<Leader>e", ":DrexDrawerToggle<CR>", { noremap = true })
  end,
}
local always_show = { -- remains visible even if other settings would normally hide it
  --".gitignored",
  ".Xresources",
  ".bashrc",
  ".config",
  ".conkyrc",
  ".devcontainer",
  ".elinks",
  ".emacs.d",
  ".eslintrc.json",
  ".gitattributes",
  ".gitconfig",
  ".github",
  ".gitignore",
  ".gitmodules",
  ".inputrc",
  ".ladle",
  ".local",
  ".markdownlint-cli2.yaml",
  ".marksman.toml",
  ".mlterm",
  ".npmrc",
  ".nyagos",
  ".omnisharp",
  ".prettierrc",
  ".prettierrc.mjs",
  ".profile",
  ".remarkrc",
  ".storybook",
  ".textlintrc",
  ".tigrc",
  ".tmux.conf",
  ".uim",
  ".vimrc",
  ".vitepress",
  ".vscode",
  ".w3m",
  ".xinitrc",
  ".xsession",
  ".zshrc",
  "zig-out",
  ".vitepress",
}

local neo_tree = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    vim.keymap.set("n", "<Leader>e", ":Neotree toggle<CR>", { noremap = true })

    local function open_all_subnodes(state)
      local node = state.tree:get_node()
      local filesystem_commands = require "neo-tree.sources.filesystem.commands"
      filesystem_commands.expand_all_nodes(state, node)
    end

    require("neo-tree").setup {
      close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = "rounded",
      enable_git_status = false,
      enable_diagnostics = false,
      -- enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
      -- event_handlers = {
      --   {
      --     event = "neo_tree_popup_input_ready",
      --     ---@param input NuiInput
      --     handler = function(input)
      --       -- enter input popup with normal mode by default.
      --       vim.cmd "stopinsert"
      --     end,
      --   },
      -- },
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
      sort_case_insensitive = false, -- used when sorting files and directories in the tree
      sort_function = nil, -- use a custom function for sorting files and directories in the tree
      -- sort_function = function (a,b)
      --       if a.type == b.type then
      --           return a.path > b.path
      --       else
      --           return a.type > b.type
      --       end
      --   end , -- this sorts files and directories descendantly
      -- A list of functions, each representing a global custom command
      -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
      -- see `:h neo-tree-custom-commands-global`
      window = {
        position = "left",
        width = 30,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["<c-b>"] = "nil",
          ["<c-f>"] = "nil",
          ["<space>"] = {
            "toggle_node",
            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
          },
          ["<2-LeftMouse>"] = "open",
          ["<cr>"] = "open",
          ["<esc>"] = "cancel", -- close preview or floating neo-tree window
          ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
          -- Read `# Preview Mode` for more information
          ["l"] = "open",
          ["S"] = "open_split",
          ["s"] = "open_vsplit",
          -- ["S"] = "split_with_window_picker",
          -- ["s"] = "vsplit_with_window_picker",
          ["t"] = "open_tabnew",
          -- ["<cr>"] = "open_drop",
          -- ["t"] = "open_tab_drop",
          ["w"] = "open_with_window_picker",
          --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
          ["h"] = "close_node",
          -- ['C'] = 'close_all_subnodes',
          ["z"] = "close_all_nodes",
          ["Z"] = open_all_subnodes,
          ["a"] = {
            "add",
            -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
            config = {
              show_path = "none", -- "none", "relative", "absolute"
            },
          },
          ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
          ["d"] = "delete",
          ["r"] = "rename",
          -- ["y"] = "copy_to_clipboard",
          ["x"] = "cut_to_clipboard",
          ["p"] = "paste_from_clipboard",
          ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
          -- ["c"] = {
          --  "copy",
          --  config = {
          --    show_path = "none" -- "none", "relative", "absolute"
          --  }
          --}
          ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
          ["i"] = "show_file_details",
          -- ["y"] = function(state)
          --   -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
          --   -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
          --   local node = state.tree:get_node()
          --   local filename = node.name
          --   vim.fn.setreg("+", filename)
          --   vim.notify("Copied: " .. filename)
          -- end,
          ["Y"] = function(state)
            -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
            -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            vim.fn.setreg("+", filepath)
            vim.notify("Copied: " .. filepath)
          end,
        },
      },
      nesting_rules = {},
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_by_name = {
            ".git"
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
          -- always_show = always_show,
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            --".DS_Store",
            --"thumbs.db"
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",  -- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["/"] = "noop", --"fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
            -- ["D"] = "fuzzy_sorter_directory",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
            ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
            ["oc"] = { "order_by_created", nowait = false },
            ["od"] = { "order_by_diagnostics", nowait = false },
            ["og"] = { "order_by_git_status", nowait = false },
            ["om"] = { "order_by_modified", nowait = false },
            ["on"] = { "order_by_name", nowait = false },
            ["os"] = { "order_by_size", nowait = false },
            ["ot"] = { "order_by_type", nowait = false },
          },
          fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
            ["<down>"] = "move_cursor_down",
            ["<C-n>"] = "move_cursor_down",
            ["<up>"] = "move_cursor_up",
            ["<C-p>"] = "move_cursor_up",
          },
        },

        commands = {}, -- Add a custom command or override a global one using the same function name
      },
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "󱇧 ", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "✖ ", -- this can only be used in the git_status source
            renamed = "󰁕 ", -- this can only be used in the git_status source
            -- Status type
            untracked = " ",
            ignored = "󰍵 ",
            unstaged = "",
            staged = "",
            conflict = "󰉁 ",
          },
        },
      },
    }

    vim.cmd [[nnoremap \ :Neotree reveal<cr>]]
  end,
}
local lir = {
  "tamago324/lir.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local actions = require "lir.actions"
    local mark_actions = require "lir.mark.actions"
    local clipboard_actions = require "lir.clipboard.actions"
    require("lir").setup {
      show_hidden_files = false,
      ignore = {}, -- { ".DS_Store", "node_modules" } etc.
      devicons = {
        enable = false,
        highlight_dirname = false,
      },
      mappings = {
        ["l"] = actions.edit,
        ["<C-s>"] = actions.split,
        ["<C-v>"] = actions.vsplit,
        ["<C-t>"] = actions.tabedit,

        ["h"] = actions.up,
        ["q"] = actions.quit,

        ["K"] = actions.mkdir,
        ["N"] = actions.newfile,
        ["R"] = actions.rename,
        ["@"] = actions.cd,
        ["Y"] = actions.yank_path,
        ["."] = actions.toggle_show_hidden,
        ["D"] = actions.delete,

        ["J"] = function()
          mark_actions.toggle_mark()
          vim.cmd "normal! j"
        end,
        ["C"] = clipboard_actions.copy,
        ["X"] = clipboard_actions.cut,
        ["P"] = clipboard_actions.paste,
      },
      float = {
        winblend = 0,
        curdir_window = {
          enable = false,
          highlight_dirname = false,
        },

        -- -- You can define a function that returns a table to be passed as the third
        -- -- argument of nvim_open_win().
        -- win_opts = function()
        --   local width = math.floor(vim.o.columns * 0.8)
        --   local height = math.floor(vim.o.lines * 0.8)
        --   return {
        --     border = {
        --       "+", "─", "+", "│", "+", "─", "+", "│",
        --     },
        --     width = width,
        --     height = height,
        --     row = 1,
        --     col = math.floor((vim.o.columns - width) / 2),
        --   }
        -- end,
      },
      hide_cursor = true,
    }

    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = { "lir" },
      callback = function()
        -- use visual mode
        vim.api.nvim_buf_set_keymap(
          0,
          "x",
          "J",
          ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
          { noremap = true, silent = true }
        )

        -- echo cwd
        vim.api.nvim_echo({ { vim.fn.expand "%:p", "Normal" } }, false, {})
      end,
    })

    vim.keymap.set("n", "<c-p>", require("lir.float").toggle(), {})
  end,
}

return {
  neo_tree,
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {
        override = {
          fs = {
            icon = "󰯙 ",
            -- color = "#3178C6", -- TypeScriptの色
          },
          vs = {
            icon = "󰯙 ",
            -- color = "#3178C6", -- TypeScriptの色
          },
          gs = {
            icon = "󰯙 ",
            -- color = "#3178C6", -- TypeScriptの色
          },
        },
      }
    end,
  },
}
