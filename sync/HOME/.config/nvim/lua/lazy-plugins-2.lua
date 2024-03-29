local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
local dot = require "dot"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

---@param repos string
---@varagss opt {name: string, bg: string, sys: string?}
local function make_colorscheme(repos, ...)
  local plugin = {
    repos,
  }
  for _, opt in ipairs { ... } do
    if opt.sys then
      plugin.config = function()
        -- vim.cmd(string.format("colorscheme %s", name))
        require("dot").colorscheme[opt.sys] = { opt.name, opt.bg }
        -- print(vim.inspect(require("dot").colorscheme))
      end
    end
  end
  return plugin
end

local plugins = {
  { "rktjmp/lush.nvim" },

  -- dark
  make_colorscheme("marcopaganini/termschool-vim-theme", { name = "termschool", bg = "dark" }),
  make_colorscheme("folke/tokyonight.nvim", { name = "tokyonight", bg = "dark" }),
  make_colorscheme(
    "EdenEast/nightfox.nvim",
    { name = "nightfox", bg = "dark" },
    { name = "carbonfox", bg = "dark", sys = "windows" }
  ),
  make_colorscheme("jnurmine/Zenburn", { name = "zenburn", bg = "dark", sys = "msys" }),
  make_colorscheme("shaunsingh/moonlight.nvim", { name = "moonlight", bg = "dark", sys = "mingw64" }),
  make_colorscheme("savq/melange-nvim", { name = "melange", bg = "dark" }),
  -- too short
  -- make_colorscheme("fenetikm/falcon", "falcon", "dark"),
  -- make_colorscheme("shaunsingh/nord.nvim", "nord", "dark"),
  -- make_colorscheme("nordtheme/vim", "nord"),
  -- make_colorscheme("cocopon/iceberg.vim", "iceberg", "dark"),
  -- make_colorscheme("AlessandroYorba/Sierra", "sierra", "dark"),

  make_colorscheme("mcchrish/zenbones.nvim", { name = "zenbones", bg = "light" }),
  make_colorscheme("xero/miasma.nvim", { name = "miasma", bg = "dark", sys = "linux" }),
  -- make_colorscheme("FrenzyExists/aquarium-vim", "aquarium"),
  make_colorscheme("junegunn/seoul256.vim", { name = "seoul256", bg = "light", sys = "wsl" }),
  -- make_colorscheme("ldelossa/vimdark", "vimdark"),
  -- make_colorscheme("Mitgorakh/snow", "snow", "light", "mac"),
  make_colorscheme("NLKNguyen/papercolor-theme", { name = "PaperColor", bg = "light", sys = "mac" }),
  -- make_colorscheme("yasukotelin/shirotelin", "shirotelin", "light", "mac"),
  --

  -- { "Bekaboo/dropbar.nvim" },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  },
  {
    "gw31415/fzyselect.vim",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fzyselect",
        callback = function()
          vim.keymap.set("n", "i", "<Plug>(fzyselect-fzy)", { buffer = true })
          vim.keymap.set("n", "<cr>", "<Plug>(fzyselect-retu)", { buffer = true })
          vim.keymap.set("n", "<esc>", "<cmd>clo<cr>", { buffer = true })
        end,
      })
      vim.ui.select = require("fzyselect").start
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  -- icon
  -- {
  --   "ibhagwan/fzf-lua",
  --   config = function()
  --     require("fzf-lua").setup {}
  --   end,
  -- },
  -- {
  --   "stevearc/dressing.nvim",
  --   config = function()
  --     require("dressing").setup {
  --       select = {
  --         -- Priority list of preferred vim.select implementations
  --         backend = { "fzf_lua" },
  --         fzf_lua = {
  --           winopts = {
  --             height = 0.9,
  --             width = 0.8,
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup {
        disable_legacy_commands = true,
      }
    end,
  },
  { "nvim-tree/nvim-web-devicons" },
  -- { "https://github.com/kyazdani42/nvim-web-devicons" },
  -- { "https://github.com/adelarsq/vim-devicons-emoji" },
  -- { "Allianaab2m/nvim-material-icon-v3" },
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("config.starter").setup()
    end,
  },

  { "tpope/vim-surround" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },

  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    opts = {
      signs = true,
    },
  },
  {
    "uga-rosa/ccc.nvim",
    config = function()
      vim.opt.termguicolors = true

      local ccc = require "ccc"
      local mapping = ccc.mapping

      ccc.setup {
        -- Your preferred settings
        -- Example: enable highlighter
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
        mappings = {
          ["<ESC>"] = mapping.quit,
          [","] = mapping.decrease10,
          ["."] = mapping.increase10,
        },
      }

      vim.keymap.set("n", "gc", ":CccPick<CR>")
    end,
  },
  { "nvim-lua/plenary.nvim" },
  {
    "simeji/winresizer",
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = require("config.nvim-tree").setup,
  },
  {
    "petertriho/nvim-scrollbar",
    dependencies = "kevinhwang91/nvim-hlslens",
    config = function()
      require("config.nvim-scrollbar").setup()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    -- dependencies = {
    --   "nvim-tree/nvim-web-devicons",
    -- },
    config = function()
      require("config.lualine").setup()
    end,
  },
  {
    "akinsho/bufferline.nvim",
    -- tag = "v3.*",
    -- dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("config.bufferline").setup()
    end,
  },
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- run = function()
    --   require("nvim-treesitter.install").update { with_sync = true }
    -- end,
    config = require("config.nvim-treesitter").setup,
    dependencies = "nvim-treesitter/playground",
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "kevinhwang91/promise-async",
    },
    config = function()
      require("config.nvim-ufo").setup()
    end,
  },
  -- git
  { "tpope/vim-fugitive" },
  { "rbong/vim-flog" },
  -- {
  --   "dinhhuy258/git.nvim",
  --   config = function()
  --     require("git").setup()
  --   end,
  -- },
  -- {
  --   "rhysd/git-messenger.vim",
  -- },
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-telescope/telescope-frecency.nvim",
      "xiyaowong/telescope-emoji.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("config.telescope").setup()
    end,
  },
  -- {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   config = function()
  --     require("config.telescope-frecency").setup()
  --   end,
  --   dependencies = { "kkharji/sqlite.lua" },
  -- },
  {
    "tyru/open-browser.vim",
    config = function()
      vim.keymap.set({ "n", "v" }, "gx", "<Plug>(openbrowser-smart-search)")
    end,
  },
  {
    "voldikss/vim-floaterm",
    config = function()
      require("config.floaterm").setup()
    end,
  },
  -- cmp
  {
    "L3MON4D3/LuaSnip",
    -- tag = "v1.*",
    config = function()
      require("config.LuaSnip").setup()
    end,
    -- dependencies = { "rafamadriz/friendly-snippets", },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      --
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-calc",
      "onsails/lspkind.nvim",
      --
      "saadparwaiz1/cmp_luasnip",
      -- "hrsh7th/cmp-vsnip",
      -- "hrsh7th/vim-vsnip",
      -- "hrsh7th/vim-vsnip-integ",
    },
    config = function()
      require("config.nvim-cmp").setup()
    end,
    event = "InsertEnter",
  },
  -- comment
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        mappings = { basic = false, extra = false },
      }

      local api = require "Comment.api"
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

      -- Toggle current line (linewise) using C-/
      vim.keymap.set("n", "<C-_>", api.toggle.linewise.current)

      -- Toggle selection (linewise)
      vim.keymap.set("x", "<C-_>", function()
        vim.api.nvim_feedkeys(esc, "nx", false)
        api.toggle.linewise(vim.fn.visualmode())
      end)
    end,
  },
  -- formatter
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = require("config.null-ls").setup,
  },
  -- lsp
  {
    "folke/neodev.nvim",
    config = function()
      -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
      require("neodev").setup {
        -- add any options here, or leave empty to use the default settings
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.nvim-lspconfig").setup()
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
      "rcarriga/nvim-notify",
      -- "b0o/schemastore.nvim",
    },
  },
  -- outline
  {
    "stevearc/aerial.nvim",
    config = function()
      require("config.aerial").setup()
    end,
  },
  -- nu
  {
    "LhKipp/nvim-nu",
    config = function()
      require("nu").setup {
        -- use_lsp_features = true, -- requires https://github.com/jose-elias-alvarez/null-ls.nvim
        -- lsp_feature: all_cmd_names is the source for the cmd name completion.
        -- It can be
        --  * a string, which is interpreted as a shell command and the returned list is the source for completions (requires plenary.nvim)
        --  * a list, which is the direct source for completions (e.G. all_cmd_names = {"echo", "to csv", ...})
        --  * a function, returning a list of strings and the return value is used as the source for completions
        -- all_cmd_names = [[nu -c 'help commands | get name | str join "\n"']],
      }
    end,
  },
  -- glsl
  {
    "tikhomirov/vim-glsl",
  },
  -- go
  -- {
  --   "fatih/vim-go",
  -- },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}

require("lazy").setup(plugins)
