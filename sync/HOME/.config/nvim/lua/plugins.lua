-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
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
end

vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"
    use "tpope/vim-fugitive"
    use "airblade/vim-gitgutter"
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icon
        },
        config = function()
            vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true })
            require("nvim-tree").setup {}
        end,
    }

    use "neovim/nvim-lspconfig" -- Collection of configurations for the built-in LSP client

    -- use "itchyny/lightline.vim"
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("lualine").setup()
        end,
    }

    use {
        "tpope/vim-commentary",
        config = function()
            vim.api.nvim_set_keymap("n", "<C-_>", ":Commentary<CR>", { noremap = true })
            vim.api.nvim_set_keymap("", "<C-_>", ":Commentary<CR>", { noremap = true })
        end,
    }

    use {
        "sbdchd/neoformat",
        config = function()
            vim.api.nvim_set_keymap("n", "<S-f>", ":Neoformat<CR>", { noremap = true })
            vim.api.nvim_set_keymap("v", "<S-f>", ":Neoformat<CR>", { noremap = true })
            vim.api.nvim_set_var("neoformat_basic_format_retab", "1")
        end,
    }

    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { "kyazdani42/nvim-web-devicons" },
            -- { "nvim-telescope/telescope-ghq.nvim" },
            -- { "ousttrue/telescope-ghq.nvim" },
        },
        config = function()
            -- require("telescope").load_extension("ghq")

            local actions = require "telescope.actions"
            require("telescope").setup {
                defaults = { mappings = { i = {
                    ["<c-[>"] = actions.close,
                } } },
            }
            vim.api.nvim_set_keymap("n", "<Space><Space>", ":<C-u>Telescope<CR>", { noremap = true })
            vim.api.nvim_set_keymap("n", "<C-p>", ":<C-u>Telescope git_files<CR>", { noremap = true })
            -- vim.api.nvim_set_keymap("n", "<F3>", ":<C-u>Telescope ghq list<CR>", {})
        end,
    }
end)
