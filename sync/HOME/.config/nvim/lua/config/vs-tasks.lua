local M = {}

function M.setup()
  require("vstask").setup {
    cache_json_conf = true, -- don't read the json conf every time a task is ran
    cache_strategy = "last", -- can be "most" or "last" (most used / last used)
    use_harpoon = true, -- use harpoon to auto cache terminals
    telescope_keys = { -- change the telescope bindings used to launch tasks
      vertical = "<C-v>",
      split = "<C-p>",
      tab = "<C-t>",
      current = "<CR>",
    },
    autodetect = { -- auto load scripts
      npm = "on",
    },
    terminal = "toggleterm",
    term_opts = {
      vertical = {
        direction = "vertical",
        size = "80",
      },
      horizontal = {
        direction = "horizontal",
        size = "10",
      },
      current = {
        direction = "float",
      },
      tab = {
        direction = "tab",
      },
    },
  }

  vim.keymap.set("n", "<Leader>ta", function()
    require("telescope").extensions.vstask.tasks()
  end)
  vim.keymap.set("n", "<Leader>ti", function()
    require("telescope").extensions.vstask.inputs()
  end)
  vim.keymap.set("n", "<Leader>th", function()
    require("telescope").extensions.vstask.history()
  end)
  vim.keymap.set("n", "<Leader>tl", function()
    require("telescope").extensions.vstask.launch()
  end)
end

return M
