local M = {}

function M.setup()
  vim.api.nvim_exec(
    [[
      hi SkkeletonIndicatorEiji guifg=#5560d0 guibg=#2e3440 gui=bold
      hi SkkeletonIndicatorHira guifg=#2e3440 guibg=#a3be8c gui=bold
      hi SkkeletonIndicatorKata guifg=#2e3440 guibg=#ebcb8b gui=bold
      hi SkkeletonIndicatorHankata guifg=#2e3440 guibg=#b48ead gui=bold
      hi SkkeletonIndicatorZenkaku guifg=#2e3440 guibg=#88c0d0 gui=bold
    ]],
    false
  )
  require("skkeleton_indicator").setup {}
end

return M
