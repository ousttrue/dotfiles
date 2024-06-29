local M = {}

function M.setup()
  local trouble = require "trouble"
  trouble.setup {
    mode = "document_diagnostics",
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
    icons = true,
    -- signs = {
    --   -- icons / text used for a diagnostic
    --   error = "",
    --   warning = "",
    --   hint = "",
    --   information = "",
    --   other = "﫠",
    -- },
    use_diagnostic_signs = true,
  }

  -- vim.keymap.set("n", "<Tab>", function()
  --   trouble.next { skip_groups = false, jump = true }
  -- end, {})
  -- vim.keymap.set("n", "<S-Tab>", function()
  --   trouble.previous { skip_groups = false, jump = true }
  -- end, {})
end

return M
