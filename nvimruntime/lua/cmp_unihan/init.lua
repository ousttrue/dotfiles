local source = {}
local utf8 = require "utf8"

local uv = vim.loop

local ITEMS = {
  -- {
  --   -- U+5650	kFourCornerCode	6666.1
  --   word = ":66661:",
  --   label = "噐 :66661:",
  --   insertText = "噐",
  --   filterText = ":66661:",
  -- },
}
local path = vim.fn.expand "~/.skk/Unihan_DictionaryLikeData.txt"
local stat = uv.fs_stat(path)
if stat then
  local fd = uv.fs_open(path, "r", 0)
  if fd then
    local src = uv.fs_read(fd, stat.size, nil)
    if src then
      for unicode, goma in string.gmatch(src, "U%+([A-F0-9]+)\tkFourCornerCode\t([%d%.]+)") do
        print(unicode, goma)
        local codepoint = tonumber(unicode, 16)
        local ch = utf8.char(codepoint)
        table.insert(ITEMS, {
          word = ":" .. goma .. ":",
          label = ch .. " :" .. goma .. ":",
          insertText = ch,
          filterText = ":" .. goma .. ":",
        })
        -- break
      end
    end
  end
end

source.new = function()
  local self = setmetatable({}, { __index = source })
  self.commit_items = nil
  self.insert_items = nil
  return self
end

source.get_trigger_characters = function()
  return { ":" }
end

source.get_keyword_pattern = function()
  return [=[\%([[:space:]"'`]\|^\)\zs:[[:digit:]_\-\+]*:\?]=]
end

source.complete = function(self, params, callback)
  -- Avoid unexpected completion.
  if not vim.regex(self.get_keyword_pattern() .. "$"):match_str(params.context.cursor_before_line) then
    return callback()
  end

  if self:option(params).insert then
    if not self.insert_items then
      self.insert_items = vim.tbl_map(function(item)
        item.word = nil
        return item
      end, ITEMS)
    end
    callback(self.insert_items)
  else
    if not self.commit_items then
      self.commit_items = ITEMS
    end
    callback(self.commit_items)
  end
end

source.option = function(_, params)
  return vim.tbl_extend("force", {
    insert = false,
  }, params.option)
end

return source
