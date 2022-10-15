local M = {}

function M.setup()
    -- Indicate first time installation
    local packer_bootstrap = false

    -- packer.nvim configuration
    local conf = {
        display = {
            open_fn = function()
                return require("packer.util").float { border = "rounded" }
            end,
        },
    }

    -- Check if packer.nvim is installed
    -- Run PackerCompile if there are changes in this file
    local function packer_init()
        local fn = vim.fn
        local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
        if fn.empty(fn.glob(install_path)) > 0 then
            packer_bootstrap = fn.system {
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/wbthomason/packer.nvim",
                install_path,
            }
            vim.cmd [[packadd packer.nvim]]
        end
        vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    end

    -- Plugins
    local function plugins(use)
        use { "wbthomason/packer.nvim" }

        use {
            "sainnhe/everforest",
            config = function()
                vim.cmd "colorscheme everforest"
            end,
        }

        use {
            "goolord/alpha-nvim",
            config = require("config.alpha").setup,
        }

        use {
            "TimUntersberger/neogit",
            requires = "nvim-lua/plenary.nvim",
            config = require("config.neogit").setup,
        }

        use {
            "nvim-tree/nvim-tree.lua",
            requires = "nvim-tree/nvim-web-devicons", -- optional, for file icons
            config = require("config.nvim-tree").setup,
        }

        use {
            "sbdchd/neoformat",
            config = require("config.neoformat").setup,
        }

        use {
            "tpope/vim-commentary",
            config = require("config.vim-commentary").setup,
        }

        use {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.0",
            -- or                            , branch = '0.1.x',
            requires = "nvim-lua/plenary.nvim",
            config = require("config.telescope").setup,
        }

        if packer_bootstrap then
            print "Restart Neovim required after installation!"
            require("packer").sync()
        end
    end

    packer_init()

    local packer = require "packer"
    packer.init(conf)
    packer.startup(plugins)
end

return M
