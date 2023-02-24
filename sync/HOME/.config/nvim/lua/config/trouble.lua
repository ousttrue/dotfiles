local M = {}

function M.setup()
  require("trouble").setup {
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
    -- use_diagnostic_signs = true,
  }
end

return M
