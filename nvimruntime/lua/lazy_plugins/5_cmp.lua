return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
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
      local lspkind = require "lspkind"

      local cmp = require "cmp"

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
          return vim.fn.printf("%-15S %s", text, key)
        end,
        -- Max number entries to show for completion of each table
        maxn = 8,
      }

      cmp.setup {
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          end,
        },

        window = {
          documentation = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
          },
          completion = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
          },
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

        sources = cmp.config.sources(
          {
            { name = "nvim_lsp" },
          },
          -- {
          --   { name = "treesitter" },
          -- },
          {
            { name = "buffer" },
          },
          {
            { name = "IM" },
          }
        ),

        formatting = {
          format = lspkind.cmp_format {
            mode = "symbol_text",
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Latex]",
            },
          },
        },
      }

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = "buffer" },
        }),
      })

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
      })
    end,
    event = "InsertEnter",
  },
}
