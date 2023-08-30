local M = {}

-- https://qiita.com/uhooi/items/99aeff822d4870a8e269
local lsp_names = function()
  local clients = {}
  for _, client in ipairs(vim.lsp.get_active_clients { bufnr = 0 }) do
    if client.name == "null-ls" then
      local sources = {}
      for _, source in ipairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
        table.insert(sources, source.name)
      end
      table.insert(clients, "null-ls(" .. table.concat(sources, ", ") .. ")")
    else
      table.insert(clients, client.name)
    end
  end
  return " " .. table.concat(clients, ", ")
end

-- https://qiita.com/Liquid-system/items/b95e8aec02c6b0de4235
function lsp_name()
  local msg = "No Active"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
      return client.name
    end
  end
  return msg
end

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
      -- lualine_a = { "branch" },
      lualine_b = {},
      lualine_c = {
        -- "diagnostics",
      },
      lualine_x = {
        lsp_names,
      },
      lualine_y = {
        "diff",
      },
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
