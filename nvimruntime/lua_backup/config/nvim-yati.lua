local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup {
    yati = { enable = true },
  }
end

return M
