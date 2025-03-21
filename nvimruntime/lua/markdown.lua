return {
  setup = function()
    --
    -- for docusaurus sidebar.ts
    --
    vim.api.nvim_create_user_command("GfPrefix", function(params)
      vim.keymap.set("n", "gf", function()
        local dir = vim.fn.expand "%:p:h"
        local file = vim.fn.expand "<cfile>"
        if file:find "/$" then
          file = file:sub(1, #file - 1)
        end
        print(dir, file)
        local path = ("%s/docs/%s.md"):format(dir, file)
        local path_vitepress = ("%s/../docs/%s.md"):format(dir, file)
        if vim.uv.fs_stat(path) then
          vim.cmd("e " .. path)
        elseif vim.uv.fs_stat(path_vitepress) then
          vim.cmd("e " .. path_vitepress)
        else
          vim.cmd "normal! gF"
        end
      end, {
        noremap = true,
        buffer = true,
      })
    end, {})
  end,
}
