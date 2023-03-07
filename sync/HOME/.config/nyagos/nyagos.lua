---@meta

---@param values table
function set(values) end

---@class nyagos
nyagos = {
  alias = {},
  completion_hidden = false,
  env = {},
  complete_for = {},
  key = {},
}

---@function split text by space
---@param text string
function nyagos.fields(text) end

---execute command
---@param cmds string|table
function nyagos.exec(cmds) end

---@param cmds table
function nyagos.rawexec(cmds) end

---execute command and return stdout as string
---@param cmds string
---@return string
function nyagos.eval(cmds) end

---@param cmds table
---@return string
---@return string
function nyagos.raweval(cmds) end

---@return string
function nyagos.getwd() end

---@param src string
function nyagos.chdir(src) end

---@param src string utf-8 string to stdout
function nyagos.write(src) end

---@param src string utf-8 string to stderr
function nyagos.writerr(src) end

---@param src string utf-8 string to current codepage multibyte string
---@return string
function nyagos.utoa(src) end

---@param src string current codepage multi byte string to utf-8 string
---@return string
function nyagos.atou(src) end

---@param src string patterns
---@return table
function nyagos.glob(src, ...) end

---@param path string
---@param to string
---@return string
function nyagos.pathjoin(path, to, ...) end

---@param env_name string env name
function nyagos.envadd(env_name, values, ...) end

---@param env_name  string env name
---@param pattern string
function nyagos.envdel(env_name, pattern) end

---@param key_name string
---@param func_name string | fun(nyagos)
function nyagos.bindkey(key_name, func_name) end

---@param cmdline string
function nyagos.filter(cmdline) end

function nyagos.argsfilter(args) end

---@param template string
function nyagos.prompt(template) end

function nyagos.default_prompt(template, title) end

---@param N integer
function nyagos.gethistory(N) end

---@param env_name string
---@return string
function nyagos.getenv(env_name) end

---@return integer
function nyagos.getviewwidth() end

---@return boolean
function nyagos.elevated() end

---@param path string
function nyagos.access(path) end
