local function on_attach(event)
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client then
    -- Disable semantic highlights
    client.server_capabilities.semanticTokensProvider = nil

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion, event.buf) then
      -- lsp completion
      vim.lsp.completion.enable(true, client.id, event.buf, {
        autotrigger = false,
      })
    end

    -- formatter
    vim.keymap.set("n", "<Space><Space>", function()
      vim.lsp.buf.format { timeout_ms = 2000 }
    end, { noremap = true })

    -- inlay
    if client:supports_method "textDocument/inlayHint" then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end
  end
end

local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = on_attach,
  })

  -- Enable completion and configure keybindings.
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

return M
