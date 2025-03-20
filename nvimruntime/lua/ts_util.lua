local utf8 = require "neoskk.utf8"
local M = {}

---@param node TSNode
---@param type_name string
---@return TSNode?
function M.find_child_by_type(node, type_name)
  for i = 0, node:named_child_count() - 1 do
    local child = node:named_child(i)
    if child then
      if child:type() == type_name then
        return child
      end
    end
  end
end

---@param src string
---@param node TSNode
---@return string?
function M.html_get_tag_from_element(src, node)
  if node:type() ~= "element" then
    return
  end

  local child = M.find_child_by_type(node, "start_tag")
  if not child then
    return
  end

  return vim.treesitter.get_node_text(child, src)
end

local ENTITY_MAP = {
  amp = "&",
  quot = "'",
  gt = ">",
  lt = "<",
  nbsp = utf8.char(tonumber "160"),    -- no-break space = non-breaking space, U+00A0 ISOnum
  iexcl = utf8.char(tonumber "161"),   -- inverted exclamation mark, U+00A1 ISOnum
  cent = utf8.char(tonumber "162"),    -- cent sign, U+00A2 ISOnum
  pound = utf8.char(tonumber "163"),   -- pound sign, U+00A3 ISOnum
  curren = utf8.char(tonumber "164"),  -- currency sign, U+00A4 ISOnum
  yen = utf8.char(tonumber "165"),     -- yen sign = yuan sign, U+00A5 ISOnum
  brvbar = utf8.char(tonumber "166"),  -- broken bar = broken vertical bar, U+00A6 ISOnum
  sect = utf8.char(tonumber "167"),    -- section sign, U+00A7 ISOnum
  uml = utf8.char(tonumber "168"),     -- diaeresis = spacing diaeresis, U+00A8 ISOdia
  copy = utf8.char(tonumber "169"),    -- copyright sign, U+00A9 ISOnum
  ordf = utf8.char(tonumber "170"),    -- feminine ordinal indicator, U+00AA ISOnum
  laquo = utf8.char(tonumber "171"),   -- left-pointing double angle quotation mark = left pointing guillemet, U+00AB ISOnum
  ["not"] = utf8.char(tonumber "172"), -- not sign, U+00AC ISOnum
  shy = utf8.char(tonumber "173"),     -- soft hyphen = discretionary hyphen, U+00AD ISOnum
  reg = utf8.char(tonumber "174"),     -- registered sign = registered trade mark sign, U+00AE ISOnum
  macr = utf8.char(tonumber "175"),    -- macron = spacing macron = overline = APL overbar, U+00AF ISOdia
  deg = utf8.char(tonumber "176"),     -- degree sign, U+00B0 ISOnum
  plusmn = utf8.char(tonumber "177"),  -- plus-minus sign = plus-or-minus sign, U+00B1 ISOnum
  sup2 = utf8.char(tonumber "178"),    -- superscript two = superscript digit two = squared, U+00B2 ISOnum
  sup3 = utf8.char(tonumber "179"),    -- superscript three = superscript digit three = cubed, U+00B3 ISOnum
  acute = utf8.char(tonumber "180"),   -- acute accent = spacing acute, U+00B4 ISOdia
  micro = utf8.char(tonumber "181"),   -- micro sign, U+00B5 ISOnum
  para = utf8.char(tonumber "182"),    -- pilcrow sign = paragraph sign, U+00B6 ISOnum
  middot = utf8.char(tonumber "183"),  -- middle dot = Georgian comma = Greek middle dot, U+00B7 ISOnum
  cedil = utf8.char(tonumber "184"),   -- cedilla = spacing cedilla, U+00B8 ISOdia
  sup1 = utf8.char(tonumber "185"),    -- superscript one = superscript digit one, U+00B9 ISOnum
  ordm = utf8.char(tonumber "186"),    -- masculine ordinal indicator, U+00BA ISOnum
  raquo = utf8.char(tonumber "187"),   -- right-pointing double angle quotation mark = right pointing guillemet, U+00BB ISOnum
  frac14 = utf8.char(tonumber "188"),  -- vulgar fraction one quarter = fraction one quarter, U+00BC ISOnum
  frac12 = utf8.char(tonumber "189"),  -- vulgar fraction one half = fraction one half, U+00BD ISOnum
  frac34 = utf8.char(tonumber "190"),  -- vulgar fraction three quarters = fraction three quarters, U+00BE ISOnum
  iquest = utf8.char(tonumber "191"),  -- inverted question mark = turned question mark, U+00BF ISOnum
  Agrave = utf8.char(tonumber "192"),  -- latin capital letter A with grave = latin capital letter A grave, U+00C0 ISOlat1
  Aacute = utf8.char(tonumber "193"),  -- latin capital letter A with acute, U+00C1 ISOlat1
  Acirc = utf8.char(tonumber "194"),   -- latin capital letter A with circumflex, U+00C2 ISOlat1
  Atilde = utf8.char(tonumber "195"),  -- latin capital letter A with tilde, U+00C3 ISOlat1
  Auml = utf8.char(tonumber "196"),    -- latin capital letter A with diaeresis, U+00C4 ISOlat1
  Aring = utf8.char(tonumber "197"),   -- latin capital letter A with ring above = latin capital letter A ring, U+00C5 ISOlat1
  AElig = utf8.char(tonumber "198"),   -- latin capital letter AE = latin capital ligature AE, U+00C6 ISOlat1
  Ccedil = utf8.char(tonumber "199"),  -- latin capital letter C with cedilla, U+00C7 ISOlat1
  Egrave = utf8.char(tonumber "200"),  -- latin capital letter E with grave, U+00C8 ISOlat1
  Eacute = utf8.char(tonumber "201"),  -- latin capital letter E with acute, U+00C9 ISOlat1
  Ecirc = utf8.char(tonumber "202"),   -- latin capital letter E with circumflex, U+00CA ISOlat1
  Euml = utf8.char(tonumber "203"),    -- latin capital letter E with diaeresis, U+00CB ISOlat1
  Igrave = utf8.char(tonumber "204"),  -- latin capital letter I with grave, U+00CC ISOlat1
  Iacute = utf8.char(tonumber "205"),  -- latin capital letter I with acute, U+00CD ISOlat1
  Icirc = utf8.char(tonumber "206"),   -- latin capital letter I with circumflex, U+00CE ISOlat1
  Iuml = utf8.char(tonumber "207"),    -- latin capital letter I with diaeresis, U+00CF ISOlat1
  ETH = utf8.char(tonumber "208"),     -- latin capital letter ETH, U+00D0 ISOlat1
  Ntilde = utf8.char(tonumber "209"),  -- latin capital letter N with tilde, U+00D1 ISOlat1
  Ograve = utf8.char(tonumber "210"),  -- latin capital letter O with grave, U+00D2 ISOlat1
  Oacute = utf8.char(tonumber "211"),  -- latin capital letter O with acute, U+00D3 ISOlat1
  Ocirc = utf8.char(tonumber "212"),   -- latin capital letter O with circumflex, U+00D4 ISOlat1
  Otilde = utf8.char(tonumber "213"),  -- latin capital letter O with tilde, U+00D5 ISOlat1
  Ouml = utf8.char(tonumber "214"),    -- latin capital letter O with diaeresis, U+00D6 ISOlat1
  times = utf8.char(tonumber "215"),   -- multiplication sign, U+00D7 ISOnum
  Oslash = utf8.char(tonumber "216"),  -- latin capital letter O with stroke = latin capital letter O slash, U+00D8 ISOlat1
  Ugrave = utf8.char(tonumber "217"),  -- latin capital letter U with grave, U+00D9 ISOlat1
  Uacute = utf8.char(tonumber "218"),  -- latin capital letter U with acute, U+00DA ISOlat1
  Ucirc = utf8.char(tonumber "219"),   -- latin capital letter U with circumflex, U+00DB ISOlat1
  Uuml = utf8.char(tonumber "220"),    -- latin capital letter U with diaeresis, U+00DC ISOlat1
  Yacute = utf8.char(tonumber "221"),  -- latin capital letter Y with acute, U+00DD ISOlat1
  THORN = utf8.char(tonumber "222"),   -- latin capital letter THORN, U+00DE ISOlat1
  szlig = utf8.char(tonumber "223"),   -- latin small letter sharp s = ess-zed, U+00DF ISOlat1
  agrave = utf8.char(tonumber "224"),  -- latin small letter a with grave = latin small letter a grave, U+00E0 ISOlat1
  aacute = utf8.char(tonumber "225"),  -- latin small letter a with acute, U+00E1 ISOlat1
  acirc = utf8.char(tonumber "226"),   -- latin small letter a with circumflex, U+00E2 ISOlat1
  atilde = utf8.char(tonumber "227"),  -- latin small letter a with tilde, U+00E3 ISOlat1
  auml = utf8.char(tonumber "228"),    -- latin small letter a with diaeresis, U+00E4 ISOlat1
  aring = utf8.char(tonumber "229"),   -- latin small letter a with ring above = latin small letter a ring, U+00E5 ISOlat1
  aelig = utf8.char(tonumber "230"),   -- latin small letter ae = latin small ligature ae, U+00E6 ISOlat1
  ccedil = utf8.char(tonumber "231"),  -- latin small letter c with cedilla, U+00E7 ISOlat1
  egrave = utf8.char(tonumber "232"),  -- latin small letter e with grave, U+00E8 ISOlat1
  eacute = utf8.char(tonumber "233"),  -- latin small letter e with acute, U+00E9 ISOlat1
  ecirc = utf8.char(tonumber "234"),   -- latin small letter e with circumflex, U+00EA ISOlat1
  euml = utf8.char(tonumber "235"),    -- latin small letter e with diaeresis, U+00EB ISOlat1
  igrave = utf8.char(tonumber "236"),  -- latin small letter i with grave, U+00EC ISOlat1
  iacute = utf8.char(tonumber "237"),  -- latin small letter i with acute, U+00ED ISOlat1
  icirc = utf8.char(tonumber "238"),   -- latin small letter i with circumflex, U+00EE ISOlat1
  iuml = utf8.char(tonumber "239"),    -- latin small letter i with diaeresis, U+00EF ISOlat1
  eth = utf8.char(tonumber "240"),     -- latin small letter eth, U+00F0 ISOlat1
  ntilde = utf8.char(tonumber "241"),  -- latin small letter n with tilde, U+00F1 ISOlat1
  ograve = utf8.char(tonumber "242"),  -- latin small letter o with grave, U+00F2 ISOlat1
  oacute = utf8.char(tonumber "243"),  -- latin small letter o with acute, U+00F3 ISOlat1
  ocirc = utf8.char(tonumber "244"),   -- latin small letter o with circumflex, U+00F4 ISOlat1
  otilde = utf8.char(tonumber "245"),  -- latin small letter o with tilde, U+00F5 ISOlat1
  ouml = utf8.char(tonumber "246"),    -- latin small letter o with diaeresis, U+00F6 ISOlat1
  divide = utf8.char(tonumber "247"),  -- division sign, U+00F7 ISOnum
  oslash = utf8.char(tonumber "248"),  -- latin small letter o with stroke, = latin small letter o slash, U+00F8 ISOlat1
  ugrave = utf8.char(tonumber "249"),  -- latin small letter u with grave, U+00F9 ISOlat1
  uacute = utf8.char(tonumber "250"),  -- latin small letter u with acute, U+00FA ISOlat1
  ucirc = utf8.char(tonumber "251"),   -- latin small letter u with circumflex, U+00FB ISOlat1
  uuml = utf8.char(tonumber "252"),    -- latin small letter u with diaeresis, U+00FC ISOlat1
  yacute = utf8.char(tonumber "253"),  -- latin small letter y with acute, U+00FD ISOlat1
  thorn = utf8.char(tonumber "254"),   -- latin small letter thorn, U+00FE ISOlat1
  yuml = utf8.char(tonumber "255"),    -- latin small letter y with diaeresis, U+00FF ISOlat1
}

---@param src string
---@return string
function M.decode_entity(src)
  src = src:gsub("(&(#?)(x?)(%w+);)", function(all, n, x, w)
    if n and #n > 0 then
      if x and #x > 0 then
        return utf8.char(tonumber(w, 16))
      else
        -- return utf8.char(tonumber(w))
        return all
      end
    else
      local ch = ENTITY_MAP[w]
      if ch then
        return ch
      else
        return all
      end
    end
  end)
  return src
end

---@param src string
---@param node TSNode
---@return string
function M.get_text(src, node)
  local node_type = node:type()
  local out = ""
  if node_type == "text" or node_type == "entity" then
    local text = vim.treesitter.get_node_text(node, src)
    if #text > 0 then
      text = M.decode_entity(text)
      out = out .. text
    end
  else
    -- print(node_type)
  end

  for i = 0, node:child_count() - 1 do
    local child = node:child(i)
    if child then
      out = out .. M.get_text(src, child)
    end
  end

  return out
end

return M
