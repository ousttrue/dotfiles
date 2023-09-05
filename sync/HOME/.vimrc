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

exec 'colorscheme' g:color_scheme

"
" settings
"
filetype plugin indent on
syntax enable

set ts=4 sts=4 sw=4 expandtab
set laststatus=2
set showtabline=2
set guioptions-=e
set belloff=all
set noswapfile noundofile nobackup
set hlsearch
set hidden
set termguicolors
set number
" set clipboard=unnamedplus
set clipboard+=unnamed

" $TERMがxterm以外のときは以下を設定する必要がある。
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " 文字色
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " 背景色

" ex mode を無効に
nnoremap Q <Nop>
nnoremap q :close<CR>
tnoremap <silent> <ESC> <C-\><C-n>
nnoremap <C-l> :nohlsearch<CR><C-l>
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-[>:w<CR>
nnoremap <F7> :make<CR>

au BufNewFile,BufRead *.xsh setf python
au FileType python setlocal formatprg=autopep8\ -

