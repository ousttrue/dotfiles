---@param repos string
---@varagss opt {name: string, bg: string, sys: string?}
local function make_colorscheme(repos, ...)
  local plugin = {
    repos,
  }
  for _, opt in ipairs { ... } do
    if opt.sys then
      plugin.config = function()
        -- vim.cmd(string.format("colorscheme %s", name))
        require("dot").colorscheme[opt.sys] = { opt.name, opt.bg }
        -- print(vim.inspect(require("dot").colorscheme))
      end
    end
  end
  return plugin
end

return {
  { "rktjmp/lush.nvim" },

  -- dark
  make_colorscheme("marcopaganini/termschool-vim-theme", { name = "termschool", bg = "dark" }),
  make_colorscheme("haxibami/urara.vim", { name = "urara", bg = "dark", sys = "mac" }),
  make_colorscheme("folke/tokyonight.nvim", { name = "tokyonight", bg = "dark" }),
  make_colorscheme(
    "EdenEast/nightfox.nvim",
    { name = "nightfox", bg = "dark" },
    { name = "carbonfox", bg = "dark", sys = "windows" }
  ),
  make_colorscheme("jnurmine/Zenburn", { name = "zenburn", bg = "dark", sys = "msys" }),
  make_colorscheme("shaunsingh/moonlight.nvim", { name = "moonlight", bg = "dark", sys = "mingw64" }),
  make_colorscheme("savq/melange-nvim", { name = "melange", bg = "dark" }),
  -- too short
  -- make_colorscheme("fenetikm/falcon", "falcon", "dark"),
  -- make_colorscheme("shaunsingh/nord.nvim", "nord", "dark"),
  -- make_colorscheme("nordtheme/vim", "nord"),
  -- make_colorscheme("cocopon/iceberg.vim", "iceberg", "dark"),
  -- make_colorscheme("AlessandroYorba/Sierra", "sierra", "dark"),

  make_colorscheme("mcchrish/zenbones.nvim", { name = "zenbones", bg = "light" }),
  make_colorscheme("xero/miasma.nvim", { name = "miasma", bg = "dark", sys = "linux" }),
  -- make_colorscheme("FrenzyExists/aquarium-vim", "aquarium"),
  make_colorscheme("junegunn/seoul256.vim", { name = "seoul256", bg = "light", sys = "wsl" }),
  -- make_colorscheme("ldelossa/vimdark", "vimdark"),
  -- make_colorscheme("Mitgorakh/snow", "snow", "light", "mac"),
  make_colorscheme("NLKNguyen/papercolor-theme", { name = "PaperColor", bg = "light" }),
  -- make_colorscheme("yasukotelin/shirotelin", "shirotelin", "light", "mac"),
  --

  "ellisonleao/gruvbox.nvim",
  "nyoom-engineering/oxocarbon.nvim",
  "rafamadriz/neon",
  "ishan9299/nvim-solarized-lua",
  "nelstrom/vim-mac-classic-theme",
  "thenewvu/vim-colors-sketching",
  "vim-scripts/tango-morning.vim",
  "yasukotelin/shirotelin",
  "NLKNguyen/papercolor-theme",
  "aonemd/quietlight.vim",
  "rmehri01/onenord.nvim",
  "sainnhe/edge",
}
