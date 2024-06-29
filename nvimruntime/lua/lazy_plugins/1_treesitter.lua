--
-- * syntax highlight
-- * motion
-- * etc...
--
return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nushell/tree-sitter-nu",
    },
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
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

      -- Option 3: treesitter as a main provider instead
      -- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
      -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
      require("ufo").setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      }
    end,
  },
  {
    "stevearc/aerial.nvim",
    -- branch = "v4",
    config = function()
      require("aerial").setup {
        nerd_font = "auto",

        backends = {
          -- ["_"] = { "lsp", "treesitter", "markdown", "man" },
          ["_"] = { "treesitter", "lsp", "markdown", "man" },
          -- toml = { "treesitter" },
          lua = { "lsp", "treesitter" },
        },

        lsp = {
          -- If true, fetch document symbols when LSP diagnostics update.
          diagnostics_trigger_update = true,

          -- Set to false to not update the symbols when there are LSP errors
          update_when_errors = true,

          -- How long to wait (in ms) after a buffer change before updating
          -- Only used when diagnostics_trigger_update = false
          update_delay = 300,

          -- Map of LSP client name to priority. Default value is 10.
          -- Clients with higher (larger) priority will be used before those with lower priority.
          -- Set to -1 to never use the client.
          priority = {
            -- pyright = 10,
          },
        },

        -- close_automatic_events = { "switch_buffer" },
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set({ "n", "v" }, "[a", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set({ "n", "v" }, "]a", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
        default_direction = "right",
        -- Options for opening aerial in a floating win
        float = {
          -- Controls border appearance. Passed to nvim_open_win
          border = "none",

          -- Determines location of floating window
          --   cursor - Opens float on top of the cursor
          --   editor - Opens float centered in the editor
          --   win    - Opens float centered in the window
          relative = "win",
          anchor = "NE",
          -- row = 1,
          -- col = 1,

          -- These control the height of the floating window.
          -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_height and max_height can be a list of mixed types.
          -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
          height = 0.8,
          width = 28,

          override = function(conf, source_winid)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,
        },
      }
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
    end,
  },
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
  {
    -- https://blog.atusy.net/2023/04/19/tsnode-marker-nvim/
    "atusy/tsnode-marker.nvim",
    lazy = true,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("tsnode-marker-markdown", {}),
        pattern = "markdown",
        callback = function(ctx)
          require("tsnode-marker").set_automark(ctx.buf, {
            target = { "code_fence_content" }, -- list of target node types
            hl_group = "CursorLine",           -- highlight group
          })
        end,
      })
    end,
  },
}
