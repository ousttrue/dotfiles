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

    -- using packer.nvim

    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
    }

    use {
        "akinsho/bufferline.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("bufferline").setup {}
        end,
    }

    use {
        "Mofiqul/dracula.nvim",
        config = function()
            vim.cmd [[colorscheme dracula]]
        end,
    }

    use "tpope/vim-surround"
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
        -- tag = "1.6.7",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icon
        },
        config = function()
            -- vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", { noremap = true })
            vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true })
            vim.cmd [[
highlight NvimTreeOpenedFile gui=reverse
            ]]
            -- vim.g.nvim_tree_highlight_opened_files = 3
            -- vim.g.nvim_tree_indent_markers = 1
            -- vim.g.nvim_tree_git_hl = 0
            -- vim.g.nvim_tree_special_files = {}
            -- vim.g.nvim_tree_disable_window_picker = 1
            require("nvim-tree").setup {
                -- auto_close = false,
                -- auto_reload_on_write = true,
                -- disable_netrw = false,
                -- hide_root_folder = false,
                -- hijack_cursor = true,
                -- hijack_netrw = true,
                -- hijack_unnamed_buffer_when_opening = false,
                -- ignore_buffer_on_setup = false,
                -- open_on_setup = false,
                -- open_on_tab = false,
                -- sort_by = "name",
                -- update_cwd = false,
                -- view = {
                --     width = 30,
                --     height = 30,
                --     side = "left",
                --     preserve_window_proportions = false,
                --     number = false,
                --     relativenumber = false,
                --     signcolumn = "yes",
                --     mappings = {
                --         custom_only = false,
                --         list = {
                --             -- user mappings go here
                --         },
                --     },
                -- },
                -- hijack_directories = {
                --     enable = true,
                --     auto_open = true,
                -- },
                update_focused_file = {
                    enable = true,
                    update_cwd = false,
                    ignore_list = {},
                },
                -- ignore_ft_on_setup = {},
                -- system_open = {
                --     cmd = nil,
                --     args = {},
                -- },
                -- filters = {
                --     dotfiles = false,
                --     custom = {},
                --     exclude = {},
                -- },
                -- git = {
                --     enable = true,
                --     ignore = true,
                --     timeout = 400,
                -- },
                actions = {
                    --     change_dir = {
                    --         enable = true,
                    --         global = false,
                    --     },
                    open_file = {
                        --         quit_on_open = false,
                        --         resize_window = false,
                        window_picker = {
                            enable = false,
                            --             chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                            --             exclude = {
                            --                 filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                            --                 buftype = { "nofile", "terminal", "help" },
                            --             },
                        },
                    },
                },
                -- trash = {
                --     cmd = "trash",
                --     require_confirm = true,
                -- },
                -- log = {
                --     enable = false,
                --     truncate = false,
                --     types = {
                --         all = false,
                --         config = false,
                --         git = false,
                --     },
                -- },
                renderer = {
                    highlight_opened_files = "all",
                    highlight_git = true,
                },
            }
        end,
    }

    -- use "christoomey/vim-tmux-navigator"
    use {
        "preservim/vimux",
        config = function()
            -- Prompt for a command to run
            vim.api.nvim_set_keymap("n", "<F6>", ":VimuxPromptCommand<CR>", { silent = true, noremap = true })
            -- Run last command executed by VimuxRunCommand
            vim.api.nvim_set_keymap("n", "<F5>", ":VimuxRunLastCommand<CR>", { silent = true, noremap = true })
            -- Inspect runner pane
            vim.api.nvim_set_keymap("n", "<F7>", ":VimuxInspectRunner<CR>", { silent = true, noremap = true })
        end,
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                -- One of "all", "maintained" (parsers with maintainers), or a list of languages
                ensure_installed = { "python", "lua", "markdown", "zig", "html", "css" },

                -- Install languages synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- List of parsers to ignore installing
                -- ignore_install = { "javascript" },

                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,

                    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is the name of the parser)
                    -- list of language that will be disabled
                    -- disable = { "c", "rust" },

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    -- additional_vim_regex_highlighting = false,
                },
            }
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
                auto_open = true, -- automatically open the list when you have diagnostics
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

    use {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup {}
        end,
    }

    use {
        "hrsh7th/nvim-cmp",
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
        },
        config = function()
            local cmp = require "cmp"
            cmp.setup {
                -- snippet = {
                --     expand = function(args)
                --         require("luasnip").lsp_expand(args.body)
                --     end,
                -- },
                -- documentation = {
                --     border = "solid",
                -- },
                mapping = {
                    ["<c-p>"] = cmp.mapping.select_prev_item(),
                    ["<c-n>"] = cmp.mapping.select_next_item(),
                    ["<c-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<c-f>"] = cmp.mapping.scroll_docs(4),
                    ["<c-e>"] = cmp.mapping.close(),
                    -- ["<c-k>"] = cmp.mapping(function(fallback)
                    --     if luasnip.expand_or_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     else
                    --         fallback()
                    --     end
                    -- end, { "i", "s" }),
                },
            }
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
            vim.g.neoformat_enabled_python = { "yapf" }
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
    use "folke/lua-dev.nvim"

    use "kizza/actionmenu.nvim"

    use "godlygeek/tabular"

    use "ambergon/VimMDlink"
    use {
        "preservim/vim-markdown",
        config = function()
            vim.api.nvim_set_var("vim_markdown_folding_disabled", 1)
        end,
    }

    use { "vim-denops/denops-helloworld.vim", requires = { "vim-denops/denops.vim" } }
    use {
        "vim-skk/skkeleton",
        requires = { "vim-denops/denops.vim" },
        config = function()
            vim.cmd [[
call skkeleton#config({ 'globalJisyo': $HOME .. '/.skk/SKK-JISYO.L' })
imap <C-j> <Plug>(skkeleton-toggle)
cmap <C-j> <Plug>(skkeleton-toggle)
        ]]
        end,
    }

    use "ziglang/zig.vim"
    use "Fymyte/rasi.vim"
end)
