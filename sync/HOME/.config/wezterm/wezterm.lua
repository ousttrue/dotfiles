---@class wezterm
local wezterm = require "wezterm"

local function file_exists(path)
  return #wezterm.glob(path) > 0
end

local HOME = require("common.path").get_home()

local config = {
  use_ime = true,
  color_scheme = require("wez.themes").get_today(),
  warn_about_missing_glyphs = false,
  initial_cols = 126,
  initial_rows = 52,
}

---@param config table
local function setup_windows(config)
  config.font_size = 13.0 -- 4k monitor with DPI scaling
  local PWSH = { "C:/Program Files/PowerShell/7/pwsh.exe", "-nologo" }
  local NUSHELL = { HOME .. "/.cargo/bin/nu.exe" }
  local NYAGOS = { HOME .. "/go/bin/nyagos.exe" }

  if file_exists(NYAGOS[1]) then
    config.default_prog = NYAGOS
  elseif file_exists(PWSH[1]) then
    config.default_prog = PWSH
  elseif file_exists(NUSHELL[1]) then
    config.default_prog = NUSHELL
  end
  -- config.allow_win32_input_mode = false

  -- wsl
  local wsl_domains = wezterm.default_wsl_domains()
  for _, dom in ipairs(wsl_domains) do
    if dom then
      dom.default_cwd = "~"
      local m = string.match(dom.name, "^WSL:(.+)")
      -- if m then
      --     dom.default_prog = { "~/go/bin/nyagos" }
      --   dom.default_cwd = string.format("//wsl$/%s/home/%s", m, os.getenv "USERNAME")
      -- end
    end
  end
  config.wsl_domains = wsl_domains
end

---@param config table
local function setup_linux(config)
  local NYAGOS = { HOME .. "/go/bin/nyagos" }
  if file_exists(NYAGOS[1]) then
    config.default_prog = NYAGOS
  else
    config.default_prog = { "bash" }
  end

  if wezterm.gui == nil or wezterm.gui.screens().main.width > 3500 then
    -- 14 x 1.5
    config.font_size = 21.0 -- raw font size
  else
    config.font_size = 11.0 -- raw font size
  end
end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  setup_windows(config)
else
  setup_linux(config)
end

config.keys = {
  -- CTRL-SHIFT-l activates the debug overlay
  { key = "L", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
}

require("wez.tab").setup(config)
require("wez.keybinds").setup(config)

return config
