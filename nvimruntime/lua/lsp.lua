local M = {}

-- https://neovim.io/doc/user/lsp.html
-- https://github.com/mason-org/mason.nvim/blob/7c7318e8bae7e3536ef6b9e86b9e38e74f2e125e/CHANGELOG.md?plain=1#L65
function M.setup()
  vim.lsp.set_log_level "off"
  -- vim.lsp.set_log_level "debug"

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = M.on_attach,
  })

  -- vim.lsp.config("*", {
  --   capabilities = {
  --     textDocument = {
  --       semanticTokens = {
  --         multilineTokenSupport = true,
  --       },
  --     },
  --   },
  --   root_markers = { ".git" },
  -- })

  vim.lsp.enable { "luals", "clangd", "zls", "ts_ls" }

  -- Enable completion and configure keybindings.
  -- vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { noremap = true })
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

  -- vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true })
end

function M.on_attach(event)
  local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
  if client then
    -- Disable semantic highlights
    client.server_capabilities.semanticTokensProvider = nil
    if client.server_capabilities.signatureHelpProvider then
      client.server_capabilities.signatureHelpProvider = nil
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion, event.buf) then
      -- lsp completion
      vim.lsp.completion.enable(true, client.id, event.buf, {
        autotrigger = false,
      })
    end

    -- formatter
    vim.keymap.set("n", "<Space>f", function()
      vim.lsp.buf.format { timeout_ms = 2000 }
    end, { noremap = true })

    if client.name == "clangd" then
      vim.keymap.set("n", "gh", function()
        vim.cmd "LspClangdSwitchSourceHeader"
      end, { noremap = true })
    end

    -- inlay
    -- if client:supports_method "textDocument/inlayHint" then
    --   vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    -- end
  end
end

return M
