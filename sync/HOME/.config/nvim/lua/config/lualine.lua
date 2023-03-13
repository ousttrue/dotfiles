local M = {}
function M.setup()
  -- local function qf()
  --   if vim.api.nvim_buf_get_option(0, "filetype") == "qf" then
  --     local l = vim.fn.getqflist()
  --     if #l > 0 then
  --       return "quickfix: " .. #l
  --     end
  --   end
  -- end

  ---@diagnostic disable-next-line
  require("lualine").setup {
    options = {
      globalstatus = true,
      disabled_filetypes = { -- Filetypes to disable lualine for.
        statusline = {}, -- only ignores the ft for statusline.
        winbar = { "qf" }, -- only ignores the ft for winbar.
      },
    },
    extensions = {
      "fugitive",
      "quickfix",
    },
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 500,
    },
    sections = {
      lualine_a = { "branch" },
      lualine_b = {},
      lualine_c = {
        "require'lsp-status'.status()",
        -- "diagnostics",
      },
      lualine_x = {
        "diff",
      },
      lualine_y = {},
      lualine_z = {
        "mode",
      },
    },
    winbar = {
      lualine_a = {
        { "filename", path = 1 },
      },
      lualine_b = {
        "aerial",
      },
      lualine_c = {},
      lualine_x = {
        "location",
        "progress",
      },
      lualine_y = {
        "filetype",
      },
      lualine_z = {
        "encoding",
        "fileformat",
      },
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
