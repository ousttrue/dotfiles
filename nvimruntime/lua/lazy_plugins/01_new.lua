return {
  {
    "notomo/lreload.nvim",
    config = function()
      for _, x in ipairs {
        "tools.myplugin",
        "tools.iim",
      } do
        require("lreload").enable(x)
      end
    end,
  },
  { "uga-rosa/utf8.nvim" },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
}
