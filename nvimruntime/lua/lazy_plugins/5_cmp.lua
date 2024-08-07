local WINDOW = {
  documentation = {
    border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
  },
  completion = {
    border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
  },
}

local function make_sources(...)
  local sources = {}
  for _, src in ipairs { ... } do
    print(vim.inspect(src))
    table.insert(sources, { name = src })
  end
  return sources
end

local function cmp_im_setup()
  local cmp_im = require "cmp_im"
  cmp_im.setup {
    -- Enable/Disable IM
    enable = false,
    -- IM keyword pattern
    keyword = [[\l\+]],
    -- IM tables path array
    tables = require("cmp_im_zh").tables {
      -- "wubi",
      "pinyin",
    },
    -- Function to format IM-key and IM-tex for completion display
    format = function(key, text)
      ---@diagnostic disable-next-line: redundant-parameter
      return vim.fn.printf("%-15S %s", text, key)
    end,
    -- Max number entries to show for completion of each table
    maxn = 8,
  }
end

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "petertriho/cmp-git",
      "ray-x/cmp-treesitter",
      --
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-calc",
      "onsails/lspkind.nvim",
      --
      -- "saadparwaiz1/cmp_luasnip",
      -- "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",
      "yehuohan/cmp-im",
      "yehuohan/cmp-im-zh",
    },
    config = function()
      local cmp = require "cmp"

      cmp_im_setup()
      local formatting = {
        format = require("lspkind").cmp_format {
          mode = "symbol_text",
          menu = {
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[Latex]",
            path = "[Path]",
          },
        },

        -- format = require("lspkind").cmp_format {
        --   mode = "symbol", -- show only symbol annotations
        --   maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        --   -- can also be a function to dynamically calculate max width such as
        --   -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
        --   ellipsis_char = "...",    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        --   show_labelDetails = true, -- show labelDetails in menu. Disabled by default
        --
        --   -- The function below will be called before any actual modifications from lspkind
        --   -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        --   -- before = function(entry, vim_item)
        --   --   return vim_item
        --   -- end,
        -- },
      }

      cmp.setup {
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm { select = true },
        },
        sources = make_sources("nvim_lsp_signature_help", "nvim_lsp", "buffer", "IM", "emoji",),
        window = WINDOW,
        formatting = formatting,
      }

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = make_sources("git", "buffer", "path"),
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = make_sources "buffer",
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = make_sources("path", "cmdline"),
        window = WINDOW,
        formatting = formatting,
      })
    end,
    event = "InsertEnter",
  },
}
