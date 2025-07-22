local bl = require "bl"

local function g_match(src, pattern)
  local _s, _e = src:find(pattern)
  ---@type {s: integer?, e:integer?}
  local context = {
    s = _s,
    e = _e,
  }

  return function()
    if not context.e then
      return
    end
    local m = src:sub(context.s, context.e)

    local s, e = src:find(pattern, context.e + 1)
    local body
    if s and e then
      body = src:sub(context.e + 1, s - 1)
      context.s = s
      context.e = e
    else
      body = src:sub(context.e + 1)
      context.s = nil
      context.e = nil
    end
    return m, body
  end
end

return {
  -- { "echasnovski/mini.ai", version = false, opts={} },
  {
    "https://gitlab.com/itaranto/id3.nvim",
  },
  {
    "samsze0/jumplist.nvim",
    config = function()
      local jumplist = require "jumplist"
      jumplist.setup {}
      vim.keymap.set("n", "<leader>o", jumplist.jump_forward)
      vim.keymap.set("n", "<leader>i", jumplist.jump_back)
    end,
  },
  -- {
  --   "cbochs/portal.nvim",
  --   -- Optional dependencies
  --   dependencies = {
  --     "cbochs/grapple.nvim",
  --     "ThePrimeagen/harpoon",
  --   },
  --   config = function()
  --     -- require("portal").setup()
  --     vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
  --     vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")
  --   end,
  -- },
  {
    name = "ousttrue/neomarkdown.nvim",
    -- enabled = false,
    dir = vim.env["GHQ_ROOT"] .. "/github.com/ousttrue/neomarkdown.nvim",
    dev = true,
    config = function()
      local HtmlAnchor = require "neomarkdown.HtmlAnchor"
      local Url = require "neomarkdown.Url"
      require("neomarkdown").setup {
        filters = {
          function(url, content)
            if url:find "^https://www.google.com/search" then
              local links = {}
              for m, body in g_match(content, "<a%s[^>]*>.-</a>") do
                local a = HtmlAnchor.parse(m)
                local href = a.href
                if href then
                  if href.src:find "support.google.com" then
                  elseif href.src:find "accounts.google.com" then
                  elseif href.path == "/url" then
                    if bl.skip_url(href.query.q) then
                    else
                      table.insert(
                        links,
                        ('<h1><a href="%s">%s</a></h1>'):format(href.query.q, a.text:gsub("[%[%]]", "_"))
                      )
                      table.insert(links, body)
                    end
                  elseif href.src:find "start=" then
                    table.insert(
                      links,
                      ('<h1><a href="%s">%s</a></h1>'):format(
                        href:format {
                          query_filter = function(k, v)
                            if k == "q" or k == "start" then
                              return k, v
                            end
                          end,
                        },
                        a.text
                      )
                    )
                  end
                end
              end

              return ("<html><body>%s</body></html>"):format(table.concat(links, "\n"))
            end
          end,
        },
      }
    end,
  },
  {
    name = "ousttrue/unihan.nvim",
    dependencies = { "uga-rosa/utf8.nvim" },
    -- enabled = false,
    dir = vim.env["GHQ_ROOT"] .. "/github.com/ousttrue/unihan.nvim",
    dev = true,
    config = function()
      local function github_dir(path)
        return vim.fs.joinpath(os.getenv "GHQ_ROOT", "github.com", path)
      end
      require("unihan").setup {
        emoji = vim.fn.expand "~/.skk/emoji-data.txt",
        -- chinadat = vim.fn.expand "~/.skk/chinadat.csv",
        -- ghq get https://github.com/syimyuzya/guangyun0704
        kuankhiunn = github_dir "syimyuzya/guangyun0704/Kuankhiunn0704-semicolon.txt",
        user_dict = vim.fn.expand "~/dotfiles/user_dict.json",
      }

      vim.api.nvim_create_user_command("NeoSkkReload", function()
        require("neoskk").reload_dict()
      end, {})
    end,
  },
  {
    name = "ousttrue/neoskk",
    -- dependencies = { "ousttrue/unihan.nvim" },
    -- enabled = false,
    dir = vim.env["GHQ_ROOT"] .. "/github.com/ousttrue/neoskk",
    dev = true,
    -- "ousttrue/neoskk",
    config = function()
      require("neoskk").setup {}
      local opts = {
        remap = false,
        expr = true,
      }
      vim.keymap.set("i", "<C-j>", function()
        local neoskk = require "neoskk"
        return neoskk.toggle()
      end, opts)
      vim.keymap.set("i", "<C-b>", function()
        local neoskk = require "neoskk"
        return neoskk.toggle "zhuyin"
      end, opts)

      vim.keymap.set("v", "~", require("neoskk").kana_toggle, { noremap = true })
    end,
  },
  {
    "mvllow/modes.nvim",
    tag = "v0.2.1",
    opts = {},
  },
  {
    "fei6409/log-highlight.nvim",
    opts = {},
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {
        override = {
          fs = {
            icon = "󰯙 ",
            -- color = "#3178C6", -- TypeScriptの色
          },
          vs = {
            icon = "󰯙 ",
            -- color = "#3178C6", -- TypeScriptの色
          },
          gs = {
            icon = "󰯙 ",
            -- color = "#3178C6", -- TypeScriptの色
          },
        },
      }
    end,
  },
  {
    "EthanJWright/vs-tasks.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      vim.cmd [[
nnoremap <Leader>ta :lua require("telescope").extensions.vstask.tasks()<CR>
nnoremap <Leader>ti :lua require("telescope").extensions.vstask.inputs()<CR>
nnoremap <Leader>ti :lua require("telescope").extensions.vstask.clear_inputs()<CR>
nnoremap <Leader>th :lua require("telescope").extensions.vstask.history()<CR>
nnoremap <Leader>tl :lua require('telescope').extensions.vstask.launch()<cr>
nnoremap <Leader>tj :lua require("telescope").extensions.vstask.jobs()<CR>
nnoremap <Leader>t; :lua require("telescope").extensions.vstask.jobhistory()<CR>
      ]]
    end,
  },
  { "uga-rosa/utf8.nvim" },
  {
    "simeji/winresizer",
    init = function()
      vim.cmd [[
let g:winresizer_start_key = '<Space>e'
      ]]
    end,
  },
  -- { "mistweaverco/kulala.nvim", opts = {} },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
}
