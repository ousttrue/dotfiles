local close_buf_filetype = { "fugitive", "help", "qf" }

local function should_close(bufnr)
  local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
  for _, t in ipairs(close_buf_filetype) do
    if filetype == t then
      return true
    end
  end
  if vim.api.nvim_win_get_config(0).zindex then
    return true
  end
  if vim.fn.buflisted(bufnr) then
    return false
  end
  return true
end

local function close_buffer_or_window()
  local currentBufNum = vim.fn.bufnr "%"
  if should_close(currentBufNum) then
    vim.cmd "close"
  else
    -- buffer 切り替え｀
    -- vim.cmd "BufferLineCycleNext"
    vim.cmd ":bn" -- barbar
    local newBufNum = vim.fn.bufnr "%"
    if newBufNum == currentBufNum then
      vim.cmd "enew"
    end
    -- 非表示になった buffer を削除
    vim.cmd("silent bwipeout " .. currentBufNum)
    --   bwipeoutに失敗した場合はウインドウ上のバッファを復元
    if vim.fn.bufloaded(currentBufNum) ~= 0 then
      vim.cmd("buffer " .. currentBufNum)
    end
  end
end

local function is_floating_win(winid)
  local config = vim.api.nvim_win_get_config(winid)
  return config.relative ~= ""
end
local function close_floating_window()
  if is_floating_win(0) then
    vim.cmd "close"
  end
end

local function setup()
  vim.keymap.set("n", "<C-/>", "gcc", { remap = true })
  vim.keymap.set("x", "<C-/>", "gc", { remap = true })
  vim.keymap.set("n", "<C-_>", "gcc", { remap = true })
  vim.keymap.set("x", "<C-_>", "gc", { remap = true })

  vim.keymap.set("n", "<C-d>", ":qa<CR>", { noremap = true })
  vim.keymap.set("n", "<M-h>", "<C-w>h", { noremap = true })
  vim.keymap.set("n", "<M-j>", "<C-w>j", { noremap = true })
  vim.keymap.set("n", "<M-k>", "<C-w>k", { noremap = true })
  vim.keymap.set("n", "<M-l>", "<C-w>l", { noremap = true })
  -- vim.keymap.set("n", "<C-l>", ":nohlsearch<CR><C-l>", { noremap = true })

  -- vim.keymap.set("n", "t", "zt", { noremap = true, silent = true })
  vim.keymap.set({ "i", "c" }, "<C-e>", "<END>")
  vim.keymap.set({ "i", "c" }, "<C-a>", "<HOME>")

  local function write_buffer()
    if vim.startswith(vim.fn.mode(), "i") then
      vim.cmd "stopinsert"
    end
    -- vim.lsp.buf.format { async = false }
    vim.api.nvim_command "write"
  end
  vim.keymap.set({ "n", "i" }, "<C-s>", write_buffer, { noremap = true })

  vim.keymap.set({ "n" }, "<F7>", ":make<CR>")
  vim.keymap.set({ "i" }, "<F7>", "<c-o>:make<CR><ESC>")
  -- vim.keymap.set("n", "<C-n>", ":cnext<CR>", { noremap = true, silent = true })
  -- vim.keymap.set("n", "<C-p>", ":cprev<CR>", { noremap = true, silent = true })
  -- vim.keymap.set("n", "]q", ":cnewer<CR>", { noremap = true, silent = true })
  -- vim.keymap.set("n", "[q", ":colder<CR>", { noremap = true, silent = true })
  vim.keymap.set("n", "]]", "<Cmd>cnext<CR>")
  vim.keymap.set("n", "[[", "<Cmd>cprev<CR>")

  vim.keymap.set("n", "<C-q>", close_buffer_or_window, { noremap = true })
  vim.keymap.set("n", "Q", close_buffer_or_window, { noremap = true })
  vim.keymap.set("n", "q", close_floating_window, { noremap = true })

  vim.keymap.set("n", "gf", "gF", { noremap = true })
  vim.keymap.set("n", "gi", function()
    vim.o.ic = not vim.o.ic
  end, { noremap = true })

  -- vim.keymap.set({ "n", "v", "c", "i" }, "<M-;>", function()
  --   print(string.format("IM is %s", require("cmp_im").toggle() and "enabled" or "disabled"))
  -- end)

  vim.keymap.set("n", "g/", [=[<Cmd>s/\\/\//g<CR>]=], { noremap = true })
  vim.keymap.set("x", "g/", [=[<Esc>:'<,'>s/\\/\//g<CR>]=], { noremap = true })

  vim.keymap.set("n", "g'", [=[<Cmd>s/'/"/g<CR>]=], { noremap = true })
  vim.keymap.set("x", "g'", [=[<Esc>:'<,'>s/'/"/g<CR>]=], { noremap = true })
end

local M = {
  setup = setup,
}
return M
