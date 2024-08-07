--
-- https://lazy.folke.io/
--
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
    -- highlight
    table.insert(plugins, { import = "lazy_plugins.1_treesitter" })
    -- finder
    table.insert(plugins, { import = "lazy_plugins.2_telescope" })
    -- left panel
    table.insert(plugins, { import = "lazy_plugins.3_filer" })
    -- formatter
    table.insert(plugins, { import = "lazy_plugins.4_lsp" })
    -- completion
    table.insert(plugins, { import = "lazy_plugins.5_cmp" })
    -- skk
    -- table.insert(plugins, { import = "lazy_plugins.6_denops" })
    -- git
    table.insert(plugins, { import = "lazy_plugins.7_git" })

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
            "~/dotfiles/nvimruntime",
            "~/AppData/Local/nvim-data/lazy/vimim",
            -- MY_RUNIME(),
          }, -- add any custom paths here that you want to includes in the rtp
        },
      },
    }

    require("lazy").setup(plugins, opts)
  end,
}
return M
