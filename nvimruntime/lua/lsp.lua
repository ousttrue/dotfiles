local function setup_completion(event)
  local id = vim.tbl_get(event, "data", "client_id")
  local client = id and vim.lsp.get_client_by_id(id)
  if client == nil then
    return
  end
  if not client.supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
    return
  end

  ---Utility for keymap creation.
  ---@param lhs string
  ---@param rhs string|function
  ---@param opts string|table
  ---@param mode? string|string[]
  local function keymap(lhs, rhs, opts, mode)
    opts = type(opts) == "string" and { desc = opts }
      or vim.tbl_extend("error", opts --[[@as table]], { buffer = event.buf })
    mode = mode or "n"
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  ---For replacing certain <C-x>... keymaps.
  ---@param keys string
  local function feedkeys(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
  end

  ---Is the completion menu open?
  local function pumvisible()
    return tonumber(vim.fn.pumvisible()) ~= 0
  end

  vim.lsp.completion.enable(true, client.id, event.buf, {
    autotrigger = false,
  })

  -- Use enter to accept completions.
  keymap("<cr>", function()
    return pumvisible() and "<C-y>" or "<cr>"
  end, { expr = true }, "i")

  -- Use slash to dismiss the completion menu.
  keymap("/", function()
    return pumvisible() and "<C-e>" or "/"
  end, { expr = true }, "i")

  -- Use <C-n> to navigate to the next completion or:
  -- - Trigger LSP completion.
  -- - If there's no one, fallback to vanilla omnifunc.
  keymap("<C-n>", function()
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
  end, "Trigger/select next completion", "i")

  -- Buffer completions.
  keymap("<C-u>", "<C-x><C-n>", { desc = "Buffer completions" }, "i")

  -- Use <Tab> to accept a Copilot suggestion, navigate between snippet tabstops,
  -- or select the next completion.
  -- Do something similar with <S-Tab>.
  keymap("<Tab>", function()
    local copilot = require "copilot.suggestion"

    if copilot.is_visible() then
      copilot.accept()
    elseif pumvisible() then
      feedkeys "<C-n>"
    elseif vim.snippet.active { direction = 1 } then
      vim.snippet.jump(1)
    else
      feedkeys "<Tab>"
    end
  end, {}, { "i", "s" })
  keymap("<S-Tab>", function()
    if pumvisible() then
      feedkeys "<C-p>"
    elseif vim.snippet.active { direction = -1 } then
      vim.snippet.jump(-1)
    else
      feedkeys "<S-Tab>"
    end
  end, {}, { "i", "s" })

  -- Inside a snippet, use backspace to remove the placeholder.
  keymap("<BS>", "<C-o>s", {}, "s")
end

local function on_attach(event)
  local id = vim.tbl_get(event, "data", "client_id")
  local client = id and vim.lsp.get_client_by_id(id)
  if client == nil then
    return
  end

  -- Disable semantic highlights
  client.server_capabilities.semanticTokensProvider = nil

  -- Enable completion and configure keybindings.
  -- setup_completion(event)

  vim.keymap.set("n", "<Space><Space>", function()
    vim.lsp.buf.format { timeout_ms = 2000 }
  end, { noremap = true })
end

local function setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = on_attach,
  })

  -- You will likely want to reduce updatetime which affects CursorHold
  -- note: this setting is global and should be set only once
  vim.o.updatetime = 250
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = args.buf,
        callback = function()
          local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
          }
          vim.diagnostic.open_float(nil, opts)
        end,
      })
    end,
  })

  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { noremap = true })
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true })
  -- vim.keymap.set("n", "<f12>", vim.lsp.buf.references, { noremap = true })
  -- -- vim.keymap.set("n", "<C-m>", vim.lsp.buf.definition, { noremap = true })
  -- -- conflict quickfix
  -- -- vim.keymap.set("n", "<C-m>", "<C-]>", { noremap = true })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true })
  -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true })
  -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true })
  -- vim.keymap.set("n", "gn", vim.lsp.buf.rename, { noremap = true })
  -- vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { noremap = true })
  -- vim.keymap.set("n", "<f2>", vim.lsp.buf.rename, { noremap = true })
  -- -- vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { noremap = true })
  -- vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, { noremap = true })
  -- vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { noremap = true })
  -- vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, { noremap = true })
  -- vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, { noremap = true })
  -- vim.keymap.set("n", "<Leader>wl", function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end)
end

return {
  setup = setup,
}
