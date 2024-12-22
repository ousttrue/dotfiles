local M = {}

local function on_enter(args)
  ---Is the completion menu open?
  local function pumvisible()
    return tonumber(vim.fn.pumvisible()) ~= 0
  end

  ---@param keys string
  local function feedkeys(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
  end

  -- Use <C-n> to navigate to the next completion or:
  -- - Trigger LSP completion.
  -- - If there's no one, fallback to vanilla omnifunc.
  vim.keymap.set("i", "<C-n>", function()
    if pumvisible() then
      feedkeys "<C-n>"
    else
      if next(vim.lsp.get_clients { bufnr = 0 }) then
        vim.lsp.completion.trigger()
      else
        if vim.bo.omnifunc == "" then
          feedkeys "<C-x><C-n>"
        else
          feedkeys "<C-x><C-o>"
        end
      end
    end
  end, {
    buffer = args.buf,
  })

  -- ---For replacing certain <C-x>... keymaps.
  -- -- Use enter to accept completions.
  -- vim.keymap.set("i", "<cr>", function()
  --   return pumvisible() and "<C-y>" or "<cr>"
  -- end, {
  --   buffer = args.buf,
  --   expr = true,
  -- })

  -- -- Use slash to dismiss the completion menu.
  -- vim.keymap.set("i", "/", function()
  --   return pumvisible() and "<C-e>" or "/"
  -- end, {
  --   buffer = args.buf,
  --   expr = true,
  -- })

  -- -- Use <Tab> to accept a Copilot suggestion, navigate between snippet tabstops,
  -- -- or select the next completion.
  -- -- Do something similar with <S-Tab>.
  -- vim.keymap.set({ "i", "s" }, "<Tab>", function()
  --   if pumvisible() then
  --     feedkeys "<C-n>"
  --   -- elseif vim.snippet.active { direction = 1 } then
  --   --   vim.snippet.jump(1)
  --   else
  --     feedkeys "<Tab>"
  --   end
  -- end, {
  --   buffer = args.buf,
  -- })

  -- vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  --   if pumvisible() then
  --     feedkeys "<C-p>"
  --   -- elseif vim.snippet.active { direction = -1 } then
  --   --   vim.snippet.jump(-1)
  --   else
  --     feedkeys "<S-Tab>"
  --   end
  -- end, {
  --   buffer = args.buf,
  -- })

  -- -- Inside a snippet, use backspace to remove the placeholder.
  -- vim.keymap.set("s", "<BS>", "<C-o>s", {
  --   buffer = args.buf,
  -- })
end

function M.setup()
  -- vim.opt.completeopt = { "menuone", "noinsert", "preview", "noselect" }
  vim.opt.completeopt = { "menuone", "preview", "fuzzy" }
  vim.api.nvim_create_autocmd("BufEnter", {
    -- group = group,
    callback = on_enter,
  })
end

return M
