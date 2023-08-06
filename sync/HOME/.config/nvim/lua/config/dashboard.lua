local M = {}

local icons = {
  wsl = "🐣",
  linux = "🐧",
  mac = "🍎",
  windows = "🪟",
}

function M.setup()
  local dot = require "dot"

  local system = dot.get_system()

  local icon = icons[system]
  if icon then
    system = icon .. system
  end

  local custom_header = {
    "          ▀████▀▄▄              ▄█ ",
    "            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ",
    "    ▄        █          ▀▀▀▀▄  ▄▀  ",
    "   ▄▀ ▀▄      ▀▄              ▀▄▀  ",
    "  ▄▀    █     █▀   ▄█▀▄      ▄█    ",
    "  ▀▄     ▀▄  █     ▀██▀     ██▄█   ",
    "   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ",
    "    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ",
    "   █   █  █      ▄▄           ▄▀   ",
  }
  require("dashboard").setup {
    theme = "doom",
    config = {
      header = custom_header,
      -- week_header = {
      --   enable = false, --boolean use a week header
      --   -- concat  --concat string after time string line
      --   -- append  --table append after time string line
      -- },
      -- disable_move = true,
      center = {
        {
          icon = "",
          icon_hl = "group",
          desc = "description",
          desc_hl = "group",
          key = "shortcut key in dashboard buffer not keymap !!",
          key_hl = "group",
          action = "",
        },
      },
      footer = { system },
    },
    hide = {
      statusline = true, -- hide statusline default is true
      tabline = true, -- hide the tabline
      winbar = true, -- hide winbar
    },
  }
end

return M
