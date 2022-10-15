
if exists('g:vscode')
    " VSCode extension
else
    " ordinary neovim
    lua require('plugins')
    lua require('setup')
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
    " python
    nnoremap <F5> :sp <CR> :term doit<CR>
endif

if has('win32')
else
    let g:python3_host_prog = "/usr/local/bin/python"
endif

set ts=4 sts=4 sw=4 expandtab
set list
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set laststatus=3
set winbar=%f
set belloff=all
set noswapfile noundofile nobackup
set hlsearch
set hidden
set termguicolors
set number
set signcolumn=yes
set modeline

" Emoji shortcuts
ab :white_check_mark: ✅
ab :warning: ⚠
ab :bulb: 💡
ab :pushpin: 📌
ab :bomb: 💣
ab :pill: 💊
ab :construction: 🚧
ab :pencil: 📝
ab :point_right: 👉
ab :book: 📖
ab :link: 🔗
ab :wrench: 🔧
ab :info: 🛈
ab :telephone: 📞
ab :email: 📧
ab :computer: 💻

" ex mode を無効に
nnoremap q :close<CR>
nnoremap Q <Nop>
tnoremap <silent> <ESC> <C-\><C-n>
nnoremap <C-l> :nohlsearch<CR><C-l>

command Bd bp | sp | bn | bd

autocmd QuickFixCmdPost *grep* cwindow

