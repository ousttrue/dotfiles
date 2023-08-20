local M = {}

local function get_system()
  if vim.fn.has "wsl" ~= 0 then
    return "wsl"
  elseif vim.fn.has "win64" ~= 0 then
    if vim.env.MSYSTEM then
      vim.opt.shellcmdflag = "-c"
      return string.lower(vim.env.MSYSTEM)
    else
      return "windows"
    end
  elseif vim.fn.has "mac" ~= 0 then
    return "mac"
  elseif vim.fn.has "linux" ~= 0 then
    return "linux"
  end
end

local sys = get_system()
function M.get_system()
  return sys
end

M.is_wsl = M.get_system() == "wsl"

function M.get_home()
  if vim.fn.has "win32" == 1 then
    return vim.env.USERPROFILE
  else
    return vim.env.HOME
  end
end

function M.get_config_home()
  if vim.env.XDG_CONFIG_HOME then
    return vim.env.XDG_CONFIG_HOME
  elseif vim.env.HOME then
    return vim.env.HOME .. "/.config"
  else
    return vim.env.APPDATA .. "/.config"
  end
end

function M.get_suffix()
  if vim.fn.has "win32" == 1 then
    return ".exe"
  else
    return ""
  end
end

M._border = {
  { "┏", "FloatBorder" }, -- upper left
  { "━", "FloatBorder" }, -- upper
  { "┓", "FloatBorder" }, -- upper right
  { "┃", "FloatBorder" }, -- right
  { "┛", "FloatBorder" }, -- lower right
  { "━", "FloatBorder" }, -- lower
  { "┗", "FloatBorder" }, -- lower left
  { "┃", "FloatBorder" }, -- left
}

M.border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

---@param str string
---@param pattern string
---@return fun(): integer, integer
function M.gfind(str, pattern)
  local from_idx = nil
  local to_idx = 0
  return function()
    from_idx, to_idx = string.find(str, pattern, to_idx + 1)
    return from_idx, to_idx
  end
end

---@param str string
---@param pattern string
---@return string[]
function M.split(str, pattern)
  local p = 1
  local result = {}

  for f, t in M.gfind(str, pattern) do
    table.insert(result, string.sub(str, p, f - 1))
    p = t + 1
  end
  table.insert(result, string.sub(str, p, -1))
  return result
end

function M.which(exe)
  vim.fn.system(string.format("which %s > /dev/null", exe))
  return vim.v.shell_error == 0
end

function M.exists(path)
  if vim.loop.fs_stat(path) then
    return true
  end
end

local langs = {
  "c",
  "cpp",
  "lua",
  "c_sharp",
  "python",
  "go",
}
local hl = {
  -- keyword
  Statement = {
    "storageclass",
    "builtin",
  },
  -- type
  Constant = {
    "type.builtin",
    "type",
    "namespace",
    "type.qualifier",
    "lsp.type.class",
  },
  -- var
  Identifier = {
    "function",
    "function.builtin",
    "function.call",
    "constructor",
  },
  -- literal
  String = {
    "constant.builtin",
    "constant",
  },
  -- field
  Special = {
    "field",
    "property",
    "lsp.type.property",
    "lsp.type.method",
  },
  _ = {
    "lsp.type.variable",
    "lsp.type.property",
    "spell",
    "lsp.type.method",
    "lsp.type.function",
  },
}

function M.extend_hl_ts()
  for i, lang in ipairs(langs) do
    for k, v in pairs(hl) do
      for j, cap in ipairs(v) do
        if k == "_" then
          -- clear
          vim.api.nvim_set_hl(0, string.format("@%s.%s", cap, lang), {})
        else
          vim.api.nvim_set_hl(0, string.format("@%s.%s", cap, lang), { link = k })
        end
      end
    end
  end
  vim.api.nvim_set_hl(0, "@type.qualifier.c_sharp", { link = "Statement" })
end

function M.extend_hl()
  vim.api.nvim_set_hl(0, "Delimiter", { link = "Statement" })

  -- String: literal: true, false, nil, 0, ""
  vim.api.nvim_set_hl(0, "Number", { link = "String" })
  vim.api.nvim_set_hl(0, "Boolean", { link = "String" })

  -- Identifier: user name: variable
  -- vim.api.nvim_set_hl(0, "Constant", { link = "Identifier" })
  vim.api.nvim_set_hl(0, "Type", { link = "Constant" })
  vim.api.nvim_set_hl(0, "Preproc", { link = "Statement" })

  vim.api.nvim_set_hl(0, "MatchParen", { fg = "#2da3b8" })

  -- HlArgs
  vim.api.nvim_set_hl(0, "HlArgs", { fg = "#a0407f" })

  vim.api.nvim_set_hl(0, "VertSplit", { link = "Normal" })
  vim.api.nvim_set_hl(0, "Pmenu", { link = "Normal" })
  vim.api.nvim_set_hl(0, "LuaParentError", {})
  vim.api.nvim_set_hl(0, "markdownError", {})
  -- vim.api.nvim_set_hl(0, "ColorColumn", { link = "StatusLine" })

  -- cs schemastore => polyglot
  -- vim.api.nvim_set_hl(0, "csModifier", { link = "Statement" })
  -- vim.api.nvim_set_hl(0, "csStorage", { link = "Statement" })
  -- vim.api.nvim_set_hl(0, "csClass", { link = "Statement" })
  -- vim.api.nvim_set_hl(0, "csNull", { link = "String" })
end

function M.reload_hl()
  package.loaded.dot = nil

  -- require("dot").extend_hl_ts()
  local cs = vim.g.colors_name
  vim.cmd("colorscheme " .. cs)
  -- require("dot").extend_hl()
end

function M.header()
  if sys == "linux" then
    return [[
                 ___         
              ,-'   '-.      
             /  _   _  \     
             | (o)_(o) |     
             \ .-""-.  /     
             //`._.-'`\\     
            //   :    ; \    
           //. - '' -.|  |   
          /:    :     |  |   
         | |   :     ,/  /,  
       _;'`-, '     |`.-' `\ 
       )     `\.___./;     .'
       '.__    )----'\__.-  '
           `""`              
    ]]
  elseif sys == "wsl" then
    return [[
             .'\   /`.
           .'.-.`-'.-.`.
      ..._:   .-. .-.   :_...
    .'    '-.(o ) (o ).-'    `.
   :  _    _ _`~(_)~`_ _    _  :
  :  /:   ' .-=_   _=-. `   ;\  :
  :   :|-.._  '     `  _..-|:   :
   :   `:| |`:-:-.-:-:'| |:'   :
    `.   `.| | | | | | |.'   .'
      `.   `-:_| | |_:-'   .'
        `-._   ````    _.-'
            ``-------''
    ]]
  elseif sys == "msys" then
    return [[
███╗   ███╗███████╗██╗   ██╗███████╗      ██████╗ 
████╗ ████║██╔════╝╚██╗ ██╔╝██╔════╝      ╚════██╗
██╔████╔██║███████╗ ╚████╔╝ ███████╗█████╗ █████╔╝
██║╚██╔╝██║╚════██║  ╚██╔╝  ╚════██║╚════╝██╔═══╝ 
██║ ╚═╝ ██║███████║   ██║   ███████║      ███████╗
╚═╝     ╚═╝╚══════╝   ╚═╝   ╚══════╝      ╚══════╝
    ]]
    -- return [[
    --     ████▌█████▌█ ████████▐▀██▀    
    --   ▄█████ █████▌ █ ▀██████▌█▄▄▀▄   
    --   ▌███▌█ ▐███▌▌  ▄▄ ▌█▌███▐███ ▀  
    --  ▐ ▐██  ▄▄▐▀█   ▐▄█▀▌█▐███▐█      
    --    ███ ▌▄█▌  ▀  ▀██  ▀██████▌     
    --     ▀█▌▀██▀ ▄         ███▐███     
    --      ██▌             ▐███████▌    
    --      ███     ▀█▀     ▐██▐███▀▌    
    --      ▌█▌█▄         ▄▄████▀ ▀      
    --        █▀██▄▄▄ ▄▄▀▀▒█▀█           
    -- ]]
  elseif sys == "mingw64" then
    return [[
    ⡆⣐⢕⢕⢕⢕⢕⢕⢕⢕⠅⢗⢕⢕⢕⢕⢕⢕⢕⠕⠕⢕⢕⢕⢕⢕⢕⢕⢕⢕
    ⢐⢕⢕⢕⢕⢕⣕⢕⢕⠕⠁⢕⢕⢕⢕⢕⢕⢕⢕⠅⡄⢕⢕⢕⢕⢕⢕⢕⢕⢕
    ⢕⢕⢕⢕⢕⠅⢗⢕⠕⣠⠄⣗⢕⢕⠕⢕⢕⢕⠕⢠⣿⠐⢕⢕⢕⠑⢕⢕⠵⢕
    ⢕⢕⢕⢕⠁⢜⠕⢁⣴⣿⡇⢓⢕⢵⢐⢕⢕⠕⢁⣾⢿⣧⠑⢕⢕⠄⢑⢕⠅⢕
    ⢕⢕⠵⢁⠔⢁⣤⣤⣶⣶⣶⡐⣕⢽⠐⢕⠕⣡⣾⣶⣶⣶⣤⡁⢓⢕⠄⢑⢅⢑
    ⠍⣧⠄⣶⣾⣿⣿⣿⣿⣿⣿⣷⣔⢕⢄⢡⣾⣿⣿⣿⣿⣿⣿⣿⣦⡑⢕⢤⠱⢐
    ⢠⢕⠅⣾⣿⠋⢿⣿⣿⣿⠉⣿⣿⣷⣦⣶⣽⣿⣿⠈⣿⣿⣿⣿⠏⢹⣷⣷⡅⢐
    ⣔⢕⢥⢻⣿⡀⠈⠛⠛⠁⢠⣿⣿⣿⣿⣿⣿⣿⣿⡀⠈⠛⠛⠁⠄⣼⣿⣿⡇⢔
    ⢕⢕⢽⢸⢟⢟⢖⢖⢤⣶⡟⢻⣿⡿⠻⣿⣿⡟⢀⣿⣦⢤⢤⢔⢞⢿⢿⣿⠁⢕
    ⢕⢕⠅⣐⢕⢕⢕⢕⢕⣿⣿⡄⠛⢀⣦⠈⠛⢁⣼⣿⢗⢕⢕⢕⢕⢕⢕⡏⣘⢕
    ⢕⢕⠅⢓⣕⣕⣕⣕⣵⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣷⣕⢕⢕⢕⢕⡵⢀⢕⢕
    ⢑⢕⠃⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⢕⢕⢕
    ⣆⢕⠄⢱⣄⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢁⢕⢕⠕⢁
    ⣿⣦⡀⣿⣿⣷⣶⣬⣍⣛⣛⣛⡛⠿⠿⠿⠛⠛⢛⣛⣉⣭⣤⣂⢜⠕⢑⣡⣴⣿
    ]]
  else
    return [[
         ,_---~~~~~----._         
  _,,_,*^____      _____``*g*\"*, 
 / __/ /'     ^.  /      \ ^@q   f 
[  @f | @))    |  | @))   l  0 _/  
 \`/   \~____ / __ \_____/    \   
  |           _l__l_           I   
  }          [______]           I  
  ]            | | |            |  
  ]             ~ ~             |  
  |                            |   
   |                           |   
]]
  end
end
--   return [[
--         ▀████▀▄▄              ▄█
--           █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█
--   ▄        █          ▀▀▀▀▄  ▄▀
--  ▄▀ ▀▄      ▀▄              ▀▄▀
-- ▄▀    █     █▀   ▄█▀▄      ▄█
-- ▀▄     ▀▄  █     ▀██▀     ██▄█
--  ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █
--   █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀
--  █   █  █      ▄▄           ▄▀   ]]

function M.footer()
  return string.format("%s %s", sys, vim.inspect(vim.version()))
end

M.colorscheme = {
  -- wsl = { "solarized", "light" },
  -- linux = { "miasma", "dark" },
}

function M.get_colorscheme()
  local found = M.colorscheme[sys]
  if found then
    -- print(vim.inspect(found))
    -- local name, bg = found
    return found[1], found[2]
  end
  return "habamax", "dark"
end

return M
