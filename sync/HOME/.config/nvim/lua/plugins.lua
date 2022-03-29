-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system {
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
    -- use {
    --     "bluz71/vim-moonfly-colors",
    --     config = function()
    --         vim.cmd [[colorscheme moonfly]]
    --     end,
    -- }
    use {
        "Mofiqul/dracula.nvim",
        config = function()
            vim.cmd [[colorscheme dracula]]
        end,
    }
    use "tpope/vim-fugitive"
    -- use {
    --     "airblade/vim-gitgutter",
    --     config = function()
    --         -- https://qiita.com/youichiro/items/b4748b3e96106d25c5bc
    --         --  git操作
    --         vim.api.nvim_set_keymap("n", "g[", ":GitGutterPrevHunk<CR>", { noremap = true })
    --         vim.api.nvim_set_keymap("n", "g]", ":GitGutterNextHunk<CR>", { noremap = true })
    --         vim.api.nvim_set_keymap("n", "gh", ":GitGutterLineHighlightsToggle<CR>", { noremap = true })
    --         vim.api.nvim_set_keymap("n", "gp", ":GitGutterPreviewHunk<CR>", { noremap = true })
    --         -- 記号の色を変更する
    --         vim.cmd [[
    -- highlight GitGutterAdd ctermfg=green guifg=#00FF00
    -- highlight GitGutterChange ctermfg=magenta guifg=#DDDD00
    -- highlight GitGutterDelete ctermfg=red guifg=FF0000
    -- ]]
    --         -- 反映時間を短くする(デフォルトは4000ms)
    --         vim.api.nvim_set_option("updatetime", 250)
    --     end,
    -- }
    -- https://riq0h.jp/2022/03/15/174239/
    use {
        "lewis6991/gitsigns.nvim",
        -- tag = 'release' -- To use the latest release
        config = function()
            require("gitsigns").setup()
        end,
    }
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
    use {
        "folke/lsp-colors.nvim",
        config = function()
            -- Lua
            require("lsp-colors").setup {
                Error = "#db4b4b",
                Warning = "#e0af68",
                Information = "#0db9d7",
                Hint = "#10B981",
            }
        end,
    }
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                auto_open = false, -- automatically open the list when you have diagnostics
            }
            -- Lua
            vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
            vim.api.nvim_set_keymap(
                "n",
                "<leader>xw",
                "<cmd>Trouble workspace_diagnostics<cr>",
                { silent = true, noremap = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>xd",
                "<cmd>Trouble document_diagnostics<cr>",
                { silent = true, noremap = true }
            )
            vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
            vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
            vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
        end,
    }

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
