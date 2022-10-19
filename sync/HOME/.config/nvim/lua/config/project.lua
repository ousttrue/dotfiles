local M = {}

function M.setup()
  require("project_nvim").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    detection_methods = { "pattern" },
  }
end

return M
