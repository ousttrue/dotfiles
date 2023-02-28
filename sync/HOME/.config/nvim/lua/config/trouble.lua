local M = {}

function M.setup()
  local trouble = require "trouble"
  trouble.setup {
    mode = "document_diagnostics",
    -- auto_open = true,
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
