local M = {}

function M.setup()
  local cmp = require "cmp"
  local lspkind = require "lspkind"
  local luasnip = require "luasnip"
  local dot = require "dot"
  local feedkeys = require "cmp.utils.feedkeys"

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
  end

  local function custom_next(fallback)
    if cmp.visible() then
      cmp.select_next_item()
      -- https://www.reddit.com/r/neovim/comments/z9os8x/strange_behaviour_cursor_jumping_with_tabkey/
      -- elseif luasnip.expand_or_jumpable() then
      --   luasnip.expand_or_jump()
      --   -- elseif has_words_before() then
      --   --   cmp.complete()
    else
      fallback()
    end
  end

  local function custom_prev(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
      -- elseif luasnip.jumpable(-1) then
      --   luasnip.jump(-1)
    else
      fallback()
    end
  end

  local function custom_enter(fallback)
    -- if cmp.get_active_entry() then
    if cmp.visible() then
      cmp.confirm { select = false }
      local key = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
      vim.api.nvim_feedkeys(key, "n", false)
    else
      fallback()
    end
  end

  local function custom_escape(fallback)
    if cmp.visible() then
      cmp.close()
    end
    fallback()
    vim.fn.feedkeys "l"
  end

  local modes = { "i", "s", "c" }

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    -- completion = {
    --   autocomplete = false,
    -- },

    window = {
      completion = cmp.config.window.bordered {
        border = dot.border,
      },
      documentation = cmp.config.window.bordered {
        border = dot.border,
      },
    },

    mapping = cmp.mapping.preset.insert {
      ["<Tab>"] = cmp.mapping(custom_next, modes),
      ["<S-Tab>"] = cmp.mapping(custom_prev, modes),
      ["<C-n>"] = cmp.mapping(custom_next, modes),
      ["<C-p>"] = cmp.mapping(custom_prev, modes),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-[>"] = custom_escape,
      -- ["<C-Space>"] = cmp.mapping.complete(),
      -- ["<C-l>"] = cmp.mapping.complete(),
      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = custom_enter,
      ["<C-e>"] = cmp.mapping.confirm { select = true },
    },

    sources = {
      { group_index = 1, name = "nvim_lsp" },
      -- { group_index = 1, name = "luasnip", option = { use_show_condition = false } },
      { group_index = 1, name = "nvim_lsp_signature_help" },
      -- { group_index = 1, name = "calc" },
      -- { group_index = 1, name = "nvim_lua" },
      {
        group_index = 2,
        name = "buffer",
        option = {
          get_bufnrs = function()
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              bufs[vim.api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(bufs)
          end,
        },
      },
    },
    formatting = {
      format = lspkind.cmp_format {
        mode = "symbol",
        maxwidth = 50,
        ellipsis_char = "...",
        before = function(entry, vim_item)
          vim_item.menu = entry.source.name
          return vim_item
        end,
      },
    },
    experimental = {
      ghost_text = true,
    },
  }

  cmp.setup.cmdline({ "/", "?" }, {
    -- mapping = cmp.mapping.preset.cmdline(command_mapping),
    sources = cmp.config.sources({
      { name = "nvim_lsp_document_symbol" },
    }, {
      { name = "buffer" },
    }),
  })

  cmp.setup.cmdline({ ":", "Create file " }, {
    -- mapping = cmp.mapping.preset.cmdline(command_mapping),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline", keyword_length = 2 },
    }),
  })

  vim.keymap.set("i", "<C-x><C-o>", cmp.complete, { noremap = true })
end

return M
