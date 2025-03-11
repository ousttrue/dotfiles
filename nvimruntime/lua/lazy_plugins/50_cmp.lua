-- https://github.com/hrsh7th/nvim-cmp

local function make_sources(...)
  local sources = {}
  for _, src in ipairs { ... } do
    -- print(vim.inspect(src))
    table.insert(sources, { name = src })
  end
  return sources
end

-- local function cmp_im_setup()
--   local cmp_im = require "cmp_im"
--   cmp_im.setup {
--     -- Enable/Disable IM
--     enable = false,
--     -- IM keyword pattern
--     keyword = [[\l\+]],
--     -- IM tables path array
--     tables = require("cmp_im_zh").tables {
--       -- "wubi",
--       "pinyin",
--     },
--     -- Function to format IM-key and IM-tex for completion display
--     format = function(key, text)
--       ---@diagnostic disable-next-line: redundant-parameter
--       return vim.fn.printf("%-15S %s", text, key)
--     end,
--     -- Max number entries to show for completion of each table
--     maxn = 8,
--   }
-- end

-- cmp.register_source(
--   "unihan",
--   require("cmp-unihan").new {
--     data = vim.fn.expand "~/.skk/Unihan_DictionaryLikeData.txt",
--     trigger_characters = { ";" },
--     keyword_pattern = [=[;\zs\d\d*]=],
--   }
-- )

-- cmp_im_setup()
-- local formatting = {
--   format = require("lspkind").cmp_format {
--     mode = "symbol_text",
--     menu = {
--       buffer = "[Buffer]",
--       nvim_lsp = "[LSP]",
--       -- luasnip = "[LuaSnip]",
--       nvim_lua = "[Lua]",
--       latex_symbols = "[Latex]",
--       path = "[Path]",
--       unihan = "[四角]",
--     },
--   },
--
--   -- format = require("lspkind").cmp_format {
--   --   mode = "symbol", -- show only symbol annotations
--   --   maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
--   --   -- can also be a function to dynamically calculate max width such as
--   --   -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
--   --   ellipsis_char = "...",    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
--   --   show_labelDetails = true, -- show labelDetails in menu. Disabled by default
--   --
--   --   -- The function below will be called before any actual modifications from lspkind
--   --   -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
--   --   -- before = function(entry, vim_item)
--   --   --   return vim_item
--   --   -- end,
--   -- },
-- }

local function config()
  local cmp = require "cmp"

  local select_map = {
    -- c-n/c-p で insert しない
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    ["<ESC>"] = cmp.mapping.close(),
    -- 選択(抜けない)
    ["<C-e>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert, count = 0 },
    -- 選択(抜ける)
    ["<CR>"] = cmp.mapping.confirm { select = false, behavior = cmp.ConfirmBehavior.Replace },
    -- insertする
    ["<Tab>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<Space>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-c>"] = cmp.mapping.abort(),
    --
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
  }

  cmp.setup {
    --   completion = {
    --     completeopt = "menu,menuone,noinsert,noselect",
    --   },
    --   formatting = formatting,
    --   matching = { disallow_partial_matching = false },
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert(select_map),
    sources = cmp.config.sources(
      --
      {
        { name = "nvim_lsp" },
      },
      --
      {
        { name = "buffer" },
      }
    ),
  }
  --   sources = make_sources(
  --   -- "nvim_lsp_signature_help",
  --     "nvim_lsp",
  --     "buffer",
  --     "IM",
  --     "unihan",
  --     "emoji"
  --   -- "skkeleton"
  --   ),

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype("gitcommit", {
    sources = make_sources("git", "buffer", "path"),
  })
end

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      -- "petertriho/cmp-git",
      -- "ray-x/cmp-treesitter",
      --
      -- "hrsh7th/cmp-nvim-lua",
      -- "hrsh7th/cmp-calc",
      -- "onsails/lspkind.nvim",
      --
      -- "L3MON4D3/LuaSnip",
      -- "saadparwaiz1/cmp_luasnip",
      -- "hrsh7th/cmp-vsnip",
      -- "hrsh7th/vim-vsnip",
      -- "hrsh7th/vim-vsnip-integ",
      -- "yehuohan/cmp-im",
      -- "yehuohan/cmp-im-zh",
      -- "uga-rosa/cmp-skkeleton",
      -- "uga-rosa/utf8.nvim",
      -- "ousttrue/cmp-unihan",
      -- { dir = "E:/repos/github.com/ousttrue/cmp-unihan" },
    },
    config = config,
    -- event = "InsertEnter",
  },
}
