local function setup()
  -- local function on_cursor_hold()
  --   vim.diagnostic.open_float()
  -- end
  -- local diagnostic_hover_augroup_name = "lspconfig-diagnostic"
  -- vim.api.nvim_set_option("updatetime", 500)
  -- vim.api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
  -- vim.api.nvim_create_autocmd({ "CursorHold" }, { group = diagnostic_hover_augroup_name, callback = on_cursor_hold })
  -- https://neovim.io/doc/user/diagnostic.html
  vim.diagnostic.config {
    severity_sort = true,
    -- underline = true,
    update_in_insert = false,
    virtual_text = false,
    -- virtual_text = {
    --   format = function(diagnostic)
    --     return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
    --   end,
    -- },

    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "",
      },
    },
    float = {
      source = true, -- Or "if_many"
      config = { border = "rounded" },
    },
  }

  vim.keymap.set("n", "ga", vim.diagnostic.open_float, { noremap = true })
  -- -- vim.keymap.set("n", "<Leader>e", vim.diagnostic.show_line_diagnostics, { noremap = true })
  -- vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, { noremap = true })
end

return {
  setup = setup,
}
