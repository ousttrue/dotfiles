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
    table.insert(plugins, { import = "lazy_plugins.01_new" })
    table.insert(plugins, { import = "lazy_plugins.10_treesitter" })
    table.insert(plugins, { import = "lazy_plugins.20_telescope" })
    table.insert(plugins, { import = "lazy_plugins.30_filer" })
    table.insert(plugins, { import = "lazy_plugins.40_lsp" })
    -- table.insert(plugins, { import = "lazy_plugins.50_cmp" })
    -- if vim.fn.has "win64" ~= 0 then
    -- table.insert(plugins, { import = "lazy_plugins.90_denops" })
    -- else
    --   -- use fcitx
    -- end
    table.insert(plugins, { import = "lazy_plugins.60_edit" })
    table.insert(plugins, { import = "lazy_plugins.70_git" })
    table.insert(plugins, { import = "lazy_plugins.80_ui" })

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
