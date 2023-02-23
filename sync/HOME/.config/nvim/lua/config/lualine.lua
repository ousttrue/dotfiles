local M = {}
function M.setup()
  ---@diagnostic disable-next-line
  require("lualine").setup {
    options = {
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        "diff",
        -- "require'lsp-status'.status()",
        "diagnostics",
      },
      lualine_c = {
        -- "filename"
      },
      lualine_x = {
        "overseer",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    winbar = {
      lualine_a = {},
      lualine_b = {
        { "filename", path = 1 },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {
        "encoding",
        "fileformat",
        "filetype",
      },
      lualine_z = {},
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  }
end

return M
