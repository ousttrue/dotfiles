local function complete_work_days(lines, base)
  -- lines is a list of lines in the current buffer. You
  -- don't have to use it.
  return {
    { word = "Monday",    kind = "Days" },
    { word = "Tuesday",   kind = "Days" },
    { word = "Wednesday", kind = "Days" },
    { word = "Thursday",  kind = "Days" },
    { word = "Friday",    kind = "Days" },
  }
end

return {
  {
    "Furkanzmc/sekme.nvim",
    config = function()
      require("sekme").setup {
        completion_key = "<c-n>",
        completion_rkey = "<c-p>",
        custom_sources = {
          {
            complete = complete_work_days,
            filetypes = { "markdown" },
          },
        },
      }
    end,
  },
}
