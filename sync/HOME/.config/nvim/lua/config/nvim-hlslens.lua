local M = {}

function M.setup()
  require("hlslens").setup {
    calm_down = true,
    nearest_only = true,
    nearest_float_when = "always",
  }
end

return M
