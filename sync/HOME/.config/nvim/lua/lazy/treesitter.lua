return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- run = function()
    --   require("nvim-treesitter.install").update { with_sync = true }
    -- end,
    config = require("config.nvim-treesitter").setup,
    dependencies = "nvim-treesitter/playground",
  },
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
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
  {
    "stevearc/aerial.nvim",
    config = function()
      require("config.aerial").setup()
    end,
  },
  {
    "andymass/vim-matchup",
    config = function()
      -- vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("headlines").setup {
        markdown = {
          query = vim.treesitter.query.parse(
            "markdown",
            [[
(atx_heading [
  (atx_h2_marker)
] @headline)
(code_fence_content) @codeblock
            ]]
          ),
          -- headline_highlights = false,
          fat_headlines = false,
        },
      }
    end, -- or `opts = {}`
  },
  -- {
  --   "Jxstxs/conceal.nvim",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = function()
  --     local conceal = require "conceal"
  --
  --     -- should be run before .generate_conceals to use user Configuration
  --     conceal.setup {
  --       -- ["lua"] = {
  --       --   enabled = true,
  --       --   keywords = {
  --       --     ["local"] = {
  --       --       enabled = false, -- to disable concealing for "local"
  --       --     },
  --       --     ["return"] = {
  --       --       conceal = "R", -- to set the concealing to "R"
  --       --     },
  --       --     ["for"] = {
  --       --       highlight = "keyword", -- to set the Highlight group to "@keyword"
  --       --     },
  --       --   },
  --       -- },
  --       ["language"] = {
  --         enabled = false, -- to disable the whole language
  --       },
  --     }
  --
  --     -- generate the scm queries
  --     -- only need to be run when the Configuration changes
  --     conceal.generate_conceals()
  --
  --     -- bind a <leader>tc to toggle the concealing level
  --     vim.keymap.set("n", "<leader>tc", function()
  --       require("conceal").toggle_conceal()
  --     end, { silent = true })
  --   end,
  -- },
  {
    "https://github.com/atusy/treemonkey.nvim",
    init = function()
      vim.keymap.set({ "x", "o" }, "m", function()
        require("treemonkey").select { ignore_injections = false }
      end)
    end,
  },
  {
    "drybalka/tree-climber.nvim",
    config = function()
      local keyopts = { noremap = true, silent = true }
      vim.keymap.set({ "n", "v", "o" }, "H", require("tree-climber").goto_parent, keyopts)
      vim.keymap.set({ "n", "v", "o" }, "L", require("tree-climber").goto_child, keyopts)
      -- vim.keymap.set({ "n", "v", "o" }, "J", require("tree-climber").goto_next, keyopts)
      -- vim.keymap.set({ "n", "v", "o" }, "K", require("tree-climber").goto_prev, keyopts)
      vim.keymap.set({ "v", "o" }, "in", require("tree-climber").select_node, keyopts)
      -- vim.keymap.set("n", "<c-k>", require("tree-climber").swap_prev, keyopts)
      -- vim.keymap.set("n", "<c-j>", require("tree-climber").swap_next, keyopts)
      vim.keymap.set("n", "<c-h>", require("tree-climber").highlight_node, keyopts)
    end,
  },
}
