local M = {}
function M.setup()
  ---@diagnostic disable-next-line
  require("lualine").setup {
    options = {
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "require'lsp-status'.status()",
        -- "diagnostics",
      },
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  }
end

return M
