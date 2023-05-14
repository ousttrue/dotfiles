local base16_kawarimidoll = require('mini.base16').mini_palette(
  '#1f1d24', -- background
  '#8fecd9', -- foreground
  75         -- accent chroma
)

require('mini.base16').setup({
  palette = base16_kawarimidoll,
  use_cterm = true,
})
