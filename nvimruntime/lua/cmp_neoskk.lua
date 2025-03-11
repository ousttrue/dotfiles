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

---Return the keyword pattern for triggering completion (optional).
---If this is omitted, nvim-cmp will use a default keyword pattern. See |cmp-config.completion.keyword_pattern|.
---@return string
function source:get_keyword_pattern()
  -- U+3041-U+3094 & U+30A1-U+30F4 & U+FF66-U+FF9F
  -- ひらがな & 全角カタカナ & 半角カタカナ
  return [=[\V\[ぁ-ゔァ-ヴｦ-ﾟ]]=]
end

---Invoke completion (required).
---@param params cmp.SourceCompletionApiParams
---@param callback fun(response: lsp.CompletionResponse|nil)
function source:complete(params, callback)
  callback {
    { label = "January" },
    { label = "February" },
    { label = "March" },
    { label = "April" },
    { label = "May" },
    { label = "June" },
    { label = "July" },
    { label = "August" },
    { label = "September" },
    { label = "October" },
    { label = "November" },
    { label = "December" },
  }
end

---Resolve completion item (optional). This is called right before the completion is about to be displayed.
---Useful for setting the text shown in the documentation window (`completion_item.documentation`).
---@param completion_item lsp.CompletionItem
---@param callback fun(completion_item: lsp.CompletionItem|nil)
function source:resolve(completion_item, callback)
  callback(completion_item)
end

---Executed after the item was selected.
---@param completion_item lsp.CompletionItem
---@param callback fun(completion_item: lsp.CompletionItem|nil)
function source:execute(completion_item, callback)
  callback(completion_item)
end

return source
