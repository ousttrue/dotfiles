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
    local dir = "lazy_plugins."
    local plugins = {}
    table.insert(plugins, { import = dir .. "01_new" })
    table.insert(plugins, { import = dir .. "10_treesitter" })
    table.insert(plugins, { import = dir .. "20_telescope" })
    table.insert(plugins, { import = dir .. "30_neotree" })
    -- table.insert(plugins, { import = dir .."31_snacks" })
    -- table.insert(plugins, { import = dir .."32_nvimtree" })
    table.insert(plugins, { import = dir .. "40_lsp" })
    -- table.insert(plugins, { import = dir .."41_diagnostics" })
    table.insert(plugins, { import = dir .. "50_cmp" })
    -- table.insert(plugins, { import = dir .."51_sekme" })
    -- if vim.fn.has "win64" ~= 0 then
    -- table.insert(plugins, { import = dir .."90_denops" })
    -- else
    --   -- use fcitx
    -- end
    table.insert(plugins, { import = dir .. "60_edit" })
    table.insert(plugins, { import = dir .. "70_git" })
    table.insert(plugins, { import = dir .. "71_markdown" })

    table.insert(plugins, { import = dir .. "80_ui" })

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
      dev = {
        -- Directory where you store your local plugin projects. If a function is used,
        -- the plugin directory (e.g. `~/projects/plugin-name`) must be returned.
        ---@type string | fun(plugin: LazyPlugin): string
        path = "E:/repos/github.com/ousttrue",
        ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
        patterns = {},    -- For example {"folke"}
        fallback = false, -- Fallback to git when local plugin doesn't exist
      },
    }

    require("lazy").setup(plugins, opts)
  end,
}
return M
