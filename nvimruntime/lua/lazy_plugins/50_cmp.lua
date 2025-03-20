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

local function config()
  local cmp = require "cmp"

  local formatting = {
    format = require("lspkind").cmp_format {
      mode = "symbol_text",
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        -- luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
        path = "[Path]",
        unihan = "[四角]",
        neoskk = "[NeoSkk]",
      },
    },
  }

  local common_map = {
    -- trigger
    ["<S-Space>"] = cmp.mapping.complete(),
    -- 選択(抜けない)
    ["<C-e>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert, count = 0 },
    -- 選択(抜ける)
    ["<CR>"] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
    --
    ["<ESC>"] = cmp.mapping.close(),
    ["<C-c>"] = cmp.mapping.abort(),
    --
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    --
    ["<Tab>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<S-Tab>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
  }

  -- c-n/c-p で insert しない
  local select_map = vim.tbl_extend("force", common_map, {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
  })

  -- c-n/c-p で insert する
  local insert_map = vim.tbl_extend("force", common_map, {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
  })

  vim.keymap.set("i", "<C-n>", function()
    if not cmp.visible() then
      require("cmp").complete()
    end
  end, {})

  cmp.setup {
    completion = {
      --completeopt = "menu,menuone,noinsert,noselect",
      autocomplete = false,
    },
    formatting = formatting,
    -- nvim-cmp/lua/cmp/entry.lua:443
    --   commen out if accept then
    -- matching = {
    --   disallow_partial_matching = false,
    --   disallow_fuzzy_matching = false,
    --   disallow_prefix_unmatching = false,
    --   disallow_partial_fuzzy_matching = false,
    -- },
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
    mapping = cmp.mapping.preset.insert(insert_map),
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
    ---@diagnostic disable-next-line
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
      "onsails/lspkind.nvim",
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
