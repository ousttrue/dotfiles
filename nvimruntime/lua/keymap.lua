local M = {
  setup = function()
    -- Remap leader and local leader to <Space>
    vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
    if vim.fn.has "win32" == 1 then
      vim.keymap.set("n", "<C-z>", "<Nop>")
    end

    vim.keymap.set("n", "<C-d>", ":qa<CR>", { noremap = true })
    vim.keymap.set("n", "<M-h>", "<C-w>h", { noremap = true })
    vim.keymap.set("n", "<M-j>", "<C-w>j", { noremap = true })
    vim.keymap.set("n", "<M-k>", "<C-w>k", { noremap = true })
    vim.keymap.set("n", "<M-l>", "<C-w>l", { noremap = true })
    vim.keymap.set("n", "<C-l>", ":nohlsearch<CR><C-l>", {})

    vim.keymap.set({ "i", "c" }, "<S-Insert>", "<C-R>+", { noremap = true })
    vim.keymap.set({ "n" }, "<S-Insert>", "p", { noremap = true })
    vim.keymap.set({ "i", "c" }, "<C-e>", "<END>")
    vim.keymap.set({ "i", "c" }, "<C-a>", "<HOME>")

    local function write_buffer()
      if vim.startswith(vim.fn.mode(), "i") then
        vim.cmd "stopinsert"
      end
      -- vim.lsp.buf.format { async = false }
      vim.api.nvim_command "write"
    end
    vim.keymap.set("n", "<C-s>", write_buffer, { noremap = true })
    vim.keymap.set("i", "<C-s>", write_buffer, { noremap = true })

    -- local function ff()
    --   local formatter = DOT.formatters[vim.bo.filetype]
    --   if formatter then
    --     formatter()
    --   else
    --     vim.lsp.buf.format { timeout_ms = 2000 }
    --   end
    -- end
    -- vim.keymap.set("n", "ff", ff, { noremap = true })
    vim.keymap.set("n", "ff", function()
      vim.lsp.buf.format { timeout_ms = 2000 }
    end, { noremap = true })

    local close_buf_filetype = { "fugitive", "help" }

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
        vim.cmd "BufferNext" -- barbar
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
    vim.keymap.set("n", "<C-q>", close_buffer_or_window, { noremap = true })
    vim.keymap.set("n", "Q", close_buffer_or_window, { noremap = true })
  end,
}
return M
