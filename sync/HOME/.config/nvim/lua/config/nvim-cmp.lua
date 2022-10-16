local M = {}

function M.setup()
    local cmp = require "cmp"
    local lspkind = require "lspkind"
    cmp.setup {
        mapping = cmp.mapping.preset.insert {
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-l>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "buffer" },
        },
        experimental = {
            ghost_text = true,
        },
        formatting = {
            format = lspkind.cmp_format {
                mode = "symbol", -- show only symbol annotations
                maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

                -- The function below will be called before any actual modifications from lspkind
                -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                -- before = function(entry, vim_item)
                --     -- ...
                --     return vim_item
                -- end,
            },
        },
    }
end

return M
