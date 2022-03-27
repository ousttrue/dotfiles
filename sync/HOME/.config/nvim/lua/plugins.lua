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

    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icon
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    }

    use "neovim/nvim-lspconfig" -- Collection of configurations for the built-in LSP client

    use "itchyny/lightline.vim"

    use {
        "tpope/vim-commentary",
        config = function()
            vim.api.nvim_set_keymap("n", "<C-_>", ":Commentary<CR>", { noremap = true })
            vim.api.nvim_set_keymap("", "<C-_>", ":Commentary<CR>", { noremap = true })
        end,
    }

    use {
        "Chiel92/vim-autoformat",
        config = function()
            vim.api.nvim_set_keymap("n", "<S-f>", ":Autoformat<CR>", { noremap = true })
            vim.api.nvim_set_keymap("v", "<S-f>", ":Autoformat<CR>", { noremap = true })
        end,
    }
end)
