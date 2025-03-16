---@class lls.LanguageServerLogger
---@field logger table
local LanguageServerLogger = {}
LanguageServerLogger.__index = LanguageServerLogger
LanguageServerLogger.name = "lls_logger"

--- Retrieves the path of the logfile
---@return string path path of the logfile
function LanguageServerLogger.get_log_path()
  return vim.fs.joinpath(vim.fn.stdpath "cache" --[[@as string]], LanguageServerLogger.name .. ".log")
end

---@return lls.LanguageServerLogger
function LanguageServerLogger.new()
  local self = setmetatable({
    logger = require("plenary.log").new {
      plugin = LanguageServerLogger.name,
      level = "trace",
      -- use_console = false,
      use_console = "async",
      info_level = 4,
      use_file = true,
      outfile = LanguageServerLogger.get_log_path(),
    },
  }, LanguageServerLogger)
  self:trace("starting " .. LanguageServerLogger.name)
  return self
end

--- Adds a log entry using Plenary.log
---@param msg any
---@param level string [same as vim.log.log_levels]
function LanguageServerLogger:add_entry(msg, level)
  local fmt_msg = self.logger[level]
  ---@cast fmt_msg fun(msg: string)
  fmt_msg(msg)
end

---Add a log entry at TRACE level
---@param msg any
function LanguageServerLogger:trace(msg)
  self:add_entry(msg, "trace")
end

---Add a log entry at DEBUG level
---@param msg any
function LanguageServerLogger:debug(msg)
  self:add_entry(msg, "debug")
end

---Add a log entry at INFO level
---@param msg any
function LanguageServerLogger:info(msg)
  self:add_entry(msg, "info")
end

---Add a log entry at WARN level
---@param msg any
function LanguageServerLogger:warn(msg)
  self:add_entry(msg, "warn")
  vim.schedule(function()
    vim.notify(msg, vim.log.levels.WARN)
  end)
end

---Add a log entry at ERROR level
---@param msg any
function LanguageServerLogger:error(msg)
  self:add_entry(msg, "error")
  vim.schedule(function()
    vim.notify(msg, vim.log.levels.ERROR)
  end)
end

return LanguageServerLogger
