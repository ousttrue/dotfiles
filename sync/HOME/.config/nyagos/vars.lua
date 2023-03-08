local M = {}

M.prompt = {
  eq = "$q", -- equal '='
  dollar = "$$", -- dollar '$'
  time = "$t", -- current time
  date = "$d", -- current date
  path = "$p", -- current path (with drive letter)
  ver = "$v", -- windows version
  drive = "$n", -- current drive letter
  gt = "$g", -- greater than '>'
  lt = "$l", -- less than '<'
  pipe = "$b", -- pipe '|'
  crlf = "$_", -- line break
  esc = "$e", -- escape
  bs = "$h", -- backspace
  amp = "$a", -- ampersand '&'
  l_par = "$c", -- left parenthesis '('
  r_par = "$f", -- right parenthesis ')'
  space = "$s", -- space
}

-- attribute
M.attr = {
  off = "0",
  bold = "1",
  bold_off = "21",
  underline = "4",
  underline_off = "24",
  blink = "5",
  blink_off = "25",
}

-- foreground
M.fg = {
  black = "30",
  red = "31",
  green = "32",
  yellow = "33",
  blue = "34",
  magenta = "35",
  cyan = "36",
  white = "37",
  default = "39",
  -- prefix 'l' is 'Light'
  gray = "90", -- bright black
  l_red = "91",
  l_green = "92",
  l_yellow = "93",
  l_blue = "94",
  l_magenta = "95",
  l_cyan = "96",
  l_white = "97",
}

-- background
M.bg = {
  black = "40",
  red = "41",
  green = "42",
  yellow = "43",
  blue = "44",
  magenta = "45",
  cyan = "46",
  white = "47",
  default = "49",
  -- prefix 'l' is 'Light'
  gray = "100", -- bright black
  l_red = "101",
  l_green = "102",
  l_yellow = "103",
  l_blue = "104",
  l_magenta = "105",
  l_cyan = "106",
  l_white = "107",
}

function M.black(fg_bg)
  return fg_bg and M.fg.black or M.bg.black
end
function M.red(fg_bg)
  return fg_bg and M.fg.red or M.bg.red
end
function M.green(fg_bg)
  return fg_bg and M.fg.green or M.bg.green
end
function M.blue(fg_bg)
  return fg_bg and M.fg.blue or M.bg.blue
end
function M.yellow(fg_bg)
  return fg_bg and M.fg.yellow or M.bg.yellow
end
function M.magenta(fg_bg)
  return fg_bg and M.fg.magenta or M.bg.magenta
end
function M.cyan(fg_bg)
  return fg_bg and M.fg.cyan or M.bg.cyan
end
function M.white(fg_bg)
  return fg_bg and M.fg.white or M.bg.white
end
function M.default(fg_bg)
  return fg_bg and M.fg.default or M.bg.default
end
function M.gray(fg_bg)
  return fg_bg and M.fg.gray or M.bg.gray
end
function M.l_red(fg_bg)
  return fg_bg and M.fg.l_red or M.bg.l_red
end
function M.l_green(fg_bg)
  return fg_bg and M.fg.l_green or M.bg.l_green
end
function M.l_blue(fg_bg)
  return fg_bg and M.fg.l_blue or M.bg.l_blue
end
function M.l_yellow(fg_bg)
  return fg_bg and M.fg.l_yellow or M.bg.l_yellow
end
function M.l_magenta(fg_bg)
  return fg_bg and M.fg.l_magenta or M.bg.l_magenta
end
function M.l_cyan(fg_bg)
  return fg_bg and M.fg.l_cyan or M.bg.l_cyan
end
function M.l_white(fg_bg)
  return fg_bg and M.fg.l_white or M.bg.l_white
end

return M
