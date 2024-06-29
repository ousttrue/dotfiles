local M = {
  setup = function()
    --
    -- install
    --
    local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        -- "--branch=stable", -- latest stable release
        lazypath,
      }
    end
    vim.opt.rtp:prepend(lazypath)

    --
    -- plugins
    --
    local plugins = {}
    table.insert(plugins, { import = "lazy_plugins.0_minimum" })
    table.insert(plugins, { import = "lazy_plugins.1_treesitter" })
    table.insert(plugins, { import = "lazy_plugins.telescope" })
    table.insert(plugins, { import = "lazy_plugins.filer" })
    -- table.insert(plugins, { import = "lazy_plugins.extend" })
    -- table.insert(plugins, { import = "lazy_plugins.9_denops" })
    table.insert(plugins, { import = "lazy_plugins.git" })
    -- table.insert(plugins, { import = "lazy_plugins.cmp" })
    -- table.insert(plugins, { import = "lazy_plugins.colorschemes" })
    table.insert(plugins, { import = "lazy_plugins.2_lsp" })

    local opts = {
      change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = false, -- get a notification when changes are found
      },
      performance = {
        rtp = {
          reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
          ---@type string[]
          paths = {
            MY_RUNIME(),
          }, -- add any custom paths here that you want to includes in the rtp
        },
      },
    }

    require("lazy").setup(plugins, opts)
  end,
}
return M
