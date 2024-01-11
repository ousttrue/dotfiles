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
                (code_fence_content) @codeblock
            ]]
          ),
          -- headline_highlights = false,
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
}
