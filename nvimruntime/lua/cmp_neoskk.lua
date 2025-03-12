local neoskk = require "neoskk"

---@class NeoskkSource
local source = {}
source.__index = source

---@return NeoskkSource
source.new = function()
  local self = setmetatable({}, source)
  return self
end

---Return whether this source is available in the current context or not (optional).
---@return boolean
function source:is_available()
  return true
end

---Return the debug name of this source (optional).
---@return string
function source:get_debug_name()
  return "neoskk"
end

-- function source:get_trigger_characters()
--   return { "▽" }
-- end

---Return the keyword pattern for triggering completion (optional).
---If this is omitted, nvim-cmp will use a default keyword pattern. See |cmp-config.completion.keyword_pattern|.
---@return string
function source:get_keyword_pattern()
  -- ▽
  return [=[▽.\+]=]
end

---Invoke completion (required).
---@param params cmp.SourceCompletionApiParams
---@param callback fun(response: lsp.CompletionResponse|nil)
function source:complete(params, callback)
  -- callback {
  --   { label = "あ" },
  --   { label = "January" },
  --   { label = "February" },
  --   { label = "March" },
  --   { label = "April" },
  --   { label = "May" },
  --   { label = "June" },
  --   { label = "July" },
  --   { label = "August" },
  --   { label = "September" },
  --   { label = "October" },
  --   { label = "November" },
  --   { label = "December" },
  -- }

  local items = {}
  local dict = neoskk.instance.dict
  if dict then
    -- local key = params.context.cursor_line
    local key = params.context.cursor_line:match [=[▽(.+)]=]
    if key and #key > 0 then
      print("key", key, #key)
      local words = dict:filter_jisyo(key, nil)
      for i, word in ipairs(words) do
        --   word = ":66661:",
        --   label = "噐 :66661:",
        --   insertText = "噐",
        --   filterText = ":66661:",
        table.insert(items, {
          word = word.word,
          label = word.abbr,
          -- insertText = word.word,
          filterText = "▽" .. key,
          documentation = word.info,
        })
      end
    else
      print("not", params.context.cursor_line)
    end
  end
  -- print(params.context.cursor_line, vim.inspect(items))
  callback(items)
end

-- ---Resolve completion item (optional). This is called right before the completion is about to be displayed.
-- ---Useful for setting the text shown in the documentation window (`completion_item.documentation`).
-- ---@param completion_item lsp.CompletionItem
-- ---@param callback fun(completion_item: lsp.CompletionItem|nil)
-- function source:resolve(completion_item, callback)
--   callback(completion_item)
-- end

-- ---Executed after the item was selected.
-- ---@param completion_item lsp.CompletionItem
-- ---@param callback fun(completion_item: lsp.CompletionItem|nil)
-- function source:execute(completion_item, callback)
--   callback(completion_item)
-- end

return source
