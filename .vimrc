"
" dein
"
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let g:rc_dir    = expand('~/.config/vim')
    let s:toml      = g:rc_dir . '/dein.toml'
    call dein#load_toml(s:toml,      {'lazy': 0})
    " let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
    " call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

"
" settings
"
filetype plugin indent on
syntax enable

set ts=4 sts=4 sw=4 expandtab
set laststatus=2
set belloff=all
set noswapfile noundofile nobackup
set hlsearch


" ex mode を無効に
nnoremap Q <Nop>
nnoremap q :close<CR>
tnoremap <silent> <ESC> <C-\><C-n>
nnoremap <C-l> :nohlsearch<CR><C-l>


" python
nnoremap <F5> :T python3 %<CR>

