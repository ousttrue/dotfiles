set encoding=utf8
let s:nvim_init = expand('~/.config/nvim/init.vim')
if filereadable(s:nvim_init)
    execute 'source ' . s:nvim_init
endif

