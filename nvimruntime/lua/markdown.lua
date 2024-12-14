return {
  setup = function()
    --
    vim.api.nvim_create_user_command("GfPrefix", function(params)
      vim.keymap.set("n", "gf", function()
        local dir = vim.fn.expand "%:p:h"
        local file = vim.fn.expand "<cfile>"
        local path = ("%s/docs/%s.md"):format(dir, file)
        print(path)
        if vim.loop.fs_stat(path) then
          vim.cmd("e " .. path)
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
