local M = {}

function M.setup()
  require("aerial").setup {
    backends = {
      -- ["_"] = { "lsp", "treesitter", "markdown", "man" },
      ["_"] = { "treesitter", "lsp", "markdown", "man" },
      toml = { "treesitter" },
    },
    -- close_automatic_events = { "switch_buffer" },
    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    on_attach = function(bufnr)
      -- Jump forwards/backwards with '{' and '}'
      vim.keymap.set("n", "[a", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "]a", "<cmd>AerialNext<CR>", { buffer = bufnr })
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
end

return M
