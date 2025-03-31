-- setup: LUA_PATH="$HOME/lua/?.lua;$HOME/lua/?/init.lua"
if os.getenv "USERPROFILE" then
  -- windows
else
  local home = os.getenv "HOME"
  package.path = string.format("%s;%s/lua/?.lua;%s/lua/?/init.lua", package.path, home, home)
end

---@class wezterm
local wezterm = require "wezterm"

local function file_exists(path)
  return #wezterm.glob(path) > 0
end

local HOME = require("common.path").get_home()

local config = {
  use_ime = true,
  -- ime_preedit_rendering = "System",
  color_scheme = require("wez.themes").get_today(),
  warn_about_missing_glyphs = false,
  initial_cols = 126,
  initial_rows = 50,
  window_background_opacity = 0.88,
  check_for_updates = false,
}

---@param config table
local function setup_windows(config)
  config.font_size = 13.0 -- 4k monitor with DPI scaling
  config.default_prog = { "pwsh", "-nologo" }
  -- config.allow_win32_input_mode = false
  config.font = wezterm.font_with_fallback({
    "JetBrains Mono",
    {family="Noto Serif CJK TC", --"Noto Sans Mono CJK TC",
     scale=1.0},
  })
  -- wezterm.font("Noto Serif CJK TC", {weight="DemiBold", stretch="Normal", style="Normal"}) -- C:\USERS\OUSTTRUE\APPDATA\LOCAL\MICROSOFT\WINDOWS\FONTS\NOTOSERIFCJK.TTC index=23 variation=0, DirectWrite

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
    config.default_prog = { HOME .. "/.dotnet/tools/pwsh" }
    config.enable_wayland = true
    config.window_decorations = "NONE"
  end

  -- if wezterm.gui == nil or wezterm.gui.screens().main.width > 3500 then
  --   -- 14 x 1.5
  --   config.font_size = 21.0 -- raw font size
  -- else
  --   config.font_size = 11.0 -- raw font size
  -- end
end

local function setup_osx(config)
  config.font_size = 18.0 -- raw font size
  config.default_prog = { "/opt/homebrew/bin/pwsh" }
end

local TARGET_MAP = {
  ["aarch64-apple-darwin"] = setup_osx,
  ["x86_64-pc-windows-msvc"] = setup_windows,
  ["x86_64-unknown-linux-gnu"] = setup_linux,
}

local setup = TARGET_MAP[wezterm.target_triple]
if setup then
  setup(config)
else
  -- fallback
  setup_linux(config)
end

config.keys = {
  -- CTRL-SHIFT-l activates the debug overlay
  { key = "L", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
}

require("wez.tab").setup(config)
require("wez.keybinds").setup(config)

config.tls_servers = { {
  bind_address = "0.0.0.0:8080",
} }

config.tls_clients = {
  {
    -- A handy alias for this session; you will use `wezterm connect server.name`
    -- to connect to it.
    name = "wsl",
    -- The host:port for the remote host
    remote_address = "wsl:8080",
    -- The value can be "user@host:port"; it accepts the same syntax as the
    -- `wezterm ssh` subcommand.
    bootstrap_via_ssh = "wsl",
  },
}

-- config.colors = {
--   cursor_bg = "#000000",
--   cursor_fg = "#FFFFFF",
--   cursor_border = "#000000",
-- }

-- config.force_reverse_video_cursor = true
config.default_cursor_style = "SteadyBlock"

return config
