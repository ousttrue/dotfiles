local M = {}

M.list = {
  function()
    -- ⭐
    return wezterm.font("Firge35 Console", { weight = "Regular", stretch = "Normal", style = "Normal" })
  end,
  function()
    -- ⭐
    return wezterm.font("Inconsolata", { weight = "Light", stretch = "Normal", style = "Normal" })
  end,
  function()
    -- ⭐
    return wezterm.font("Anonymous Pro", { weight = "Regular", stretch = "Normal", style = "Normal" })
  end,
  function()
    -- ⭐
    return wezterm.font("Terminus (TTF)", { weight = "Medium", stretch = "Normal", style = "Normal" })
  end,
  -- function()
  --   return wezterm.font("IBM Plex Mono", { weight = "Light", stretch = "Normal", style = "Normal" })
  -- end,
  -- function()
  --   return wezterm.font("Lab Mono", { weight = "Regular", stretch = "Normal", style = "Normal" })
  -- end,
  function()
    -- ⭐
    return wezterm.font("Sometype Mono", { weight = "Regular", stretch = "Normal", style = "Normal" })
  end,
  -- function()
  --   return wezterm.font("Libertinus Mono", { weight = "Regular", stretch = "Normal", style = "Normal" })
  -- end,
  -- function()
  --   return wezterm.font("Leftist Mono Sans", { weight = "Regular", stretch = "Normal", style = "Normal" })
  -- end,
  function()
    -- ⭐
    return wezterm.font("Verily Serif Mono", { weight = "Regular", stretch = "Normal", style = "Normal" })
  end,
  -- function()
  --   return wezterm.font("DejaVu Sans Mono", { weight = "Bold", stretch = "Normal", style = "Normal" })
  -- end,
  -- function()
  --   return wezterm.font("Consolas", { weight = "Regular", stretch = "Normal", style = "Normal" })
  -- end,
  function()
    -- ⭐
    return wezterm.font("Fira Code", { weight = "Light", stretch = "Normal", style = "Normal" })
  end,
}

local yday = os.date("*t")["yday"]
-- local yday = 0

M.today_font = M.list[(yday % #M.list) + 1]

return M
