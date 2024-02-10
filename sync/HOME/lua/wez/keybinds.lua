---@class wezterm
local wezterm = require "wezterm"

local M = {}

---@param keys table
local function setup_keys(keys)
  local function bind(mods, key, action)
    table.insert(keys, { key = key, mods = mods, action = action })
  end

  -- ???
  -- https://github.com/wez/wezterm/discussions/556
  bind("CTRL", "/", wezterm.action { SendString = "\x1f" })
  bind("CMD", "h", wezterm.action.SendKey { key = "h", mods = "ALT" })
  bind("CMD", "j", wezterm.action.SendKey { key = "j", mods = "ALT" })
  bind("CMD", "k", wezterm.action.SendKey { key = "k", mods = "ALT" })
  bind("CMD", "l", wezterm.action.SendKey { key = "l", mods = "ALT" })

  -- LEADER
  bind("LEADER", "r", "ReloadConfiguration")
  bind("LEADER", "[", "ActivateCopyMode")
  bind("LEADER", "q", wezterm.action { CloseCurrentTab = { confirm = false } })
  bind("LEADER", "c", "ShowLauncher")
  bind("LEADER", " ", wezterm.action { PasteFrom = "PrimarySelection" })
  bind("LEADER", "[", "ActivateCopyMode")

  -- CTRL / SHIFT
  bind("SHIFT", "PageUp", wezterm.action.ScrollByPage(-1))
  bind("SHIFT", "PageDown", wezterm.action.ScrollByPage(1))
  bind("SHIFT", "Insert", wezterm.action { PasteFrom = "Clipboard" })
  bind("CTRL|SHIFT", " ", "QuickSelect")
  bind("CTRL|SHIFT", "c", wezterm.action { CopyTo = "Clipboard" })
  bind("CTRL|SHIFT", "v", wezterm.action { PasteFrom = "Clipboard" })
  bind("CMD", "c", wezterm.action { CopyTo = "Clipboard" })
  bind("CMD", "v", wezterm.action { PasteFrom = "Clipboard" })

  -- ALT
  bind("ALT", "c", wezterm.action { SpawnTab = "CurrentPaneDomain" })
  bind("CMD", "c", wezterm.action { SpawnTab = "CurrentPaneDomain" })
  bind("ALT", "LeftArrow", wezterm.action { MoveTabRelative = -1 })
  bind("ALT", "RightArrow", wezterm.action { MoveTabRelative = 1 })
  bind("CMD", "LeftArrow", wezterm.action { MoveTabRelative = -1 })
  bind("CMD", "RightArrow", wezterm.action { MoveTabRelative = 1 })

  -- bind("ALT", "h", wezterm.action { ActivateTabRelative = -1 })
  -- bind("ALT", "l", wezterm.action { ActivateTabRelative = 1 })
  bind("ALT", ",", wezterm.action { ActivateTabRelative = -1 })
  bind("ALT", ".", wezterm.action { ActivateTabRelative = 1 })
  bind("CMD", ",", wezterm.action { ActivateTabRelative = -1 })
  bind("CMD", ".", wezterm.action { ActivateTabRelative = 1 })
  bind("ALT", "LeftArrow", wezterm.action { MoveTabRelative = -1 })
  bind("ALT", "RightArrow", wezterm.action { MoveTabRelative = 1 })
end

---@param config table
function M.setup(config)
  config.disable_default_key_bindings = true
  config.leader = { key = "t", mods = "CTRL", timeout_milliseconds = 1000 }
  -- config.leader = { key = "x", mods = "CTRL", timeout_milliseconds = 1000 }
  config.launch_menu = {
    {
      args = { "top" },
    },
    {
      -- Optional label to show in the launcher. If omitted, a label
      -- is derived from the `args`
      label = "XXXBash",
      -- The argument array to spawn.  If omitted the default program
      -- will be used as described in the documentation above
      args = { "bash", "-l" },

      -- You can specify an alternative current working directory;
      -- if you don't specify one then a default based on the OSC 7
      -- escape sequence will be used (see the Shell Integration
      -- docs), falling back to the home directory.
      -- cwd = "/some/path"

      -- You can override environment variables just for this command
      -- by setting this here.  It has the same semantics as the main
      -- set_environment_variables configuration option described above
      -- set_environment_variables = { FOO = "bar" },
    },
  }

  config.keys = config.keys or {}

  setup_keys(config.keys)
end

return M
