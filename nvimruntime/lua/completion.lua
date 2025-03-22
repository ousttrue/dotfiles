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

  --
  -- trigger
  --
  -- https://vim-jp.org/vim-users-jp/2009/05/01/Hack-4.html
  -- <C-n> 次の候補を選択し、カーソル位置に挿入します。
  -- <C-p> 前の候補を選択し、カーソル位置に挿入します。
  -- <C-y> 現在選択している補完候補を挿入し、補完を終了します。
  -- <C-e> 補完をキャンセルします。 また、補完のポップアップメニューが表示されている場合は以下のキー操作が有効になります。
  -- <BS>または<C-h> 一文字削除して、候補を再検索します。
  -- <PageDown> ポップアップメニューを順方向に改ページします。
  -- <PageUp> ポップアップメニューを逆方向に改ページします。
  -- <Down> 次の候補を選択しますが、<C-p>とは違って候補を挿入しません。
  -- <Up> 前の候補を選択しますが、<C-n>とは違って候補を挿入しません。
  -- <C-l> マッチするものから一文字追加し、補完を絞り込みます。
  -- <Space>または<Tab> 候補選択を終了し、タイプした文字を挿入します。
  -- <Enter>だけは少々特殊です。候補を選択している場合はその候補を挿入し、それ以外の場合は改行します。
  local function comp()
    if pumvisible() then
      feedkeys "<C-n>"
    else
      if next(vim.lsp.get_clients { bufnr = 0 }) then
        -- lsp で候補を取得して
        -- vim.fn.complete(start_col, matches)
        -- とする
        vim.lsp.completion.get()
      else
        if #vim.o.completefunc > 0 or #vim.bo.completefunc > 0 then
          feedkeys "<C-x><C-u>"
        elseif #vim.bo.omnifunc > 0 then
          feedkeys "<C-x><C-o>"
        else
          feedkeys "<C-x><C-n>"
        end
      end
    end
  end
  vim.keymap.set("i", "<C-n>", comp, {
    buffer = args.buf,
  })
  vim.keymap.set("i", "<C-x><C-j>", comp, {
    buffer = args.buf,
  })

  ---For replacing certain <C-x>... keymaps.
  -- Use enter to accept completions.
  vim.keymap.set("i", "<cr>", function()
    return pumvisible() and "<C-y>" or "<cr>"
  end, {
    buffer = args.buf,
    expr = true,
  })
  vim.keymap.set("i", "<ESC>", function()
    return pumvisible() and "<C-y>" or "<ESC>"
  end, {
    buffer = args.buf,
    expr = true,
  })
  -- cancel
  vim.keymap.set("i", "<C-c>", function()
    return pumvisible() and "<C-e>" or "<C-c>"
  end, {
    buffer = args.buf,
    expr = true,
  })

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
  -- https://vim-jp.org/vim-users-jp/2009/05/11/Hack-9.html
  -- vim.opt.completeopt = { "menuone", "noinsert", "preview", "noselect" }
  vim.opt.completeopt = { "menuone", "popup", "fuzzy", "preview" }
  vim.api.nvim_create_autocmd("BufEnter", {
    -- group = group,
    callback = on_enter,
  })
end

return M
