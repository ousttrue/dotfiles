lua require('plugins')
lua require('setup')
augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end


set ts=4 sts=4 sw=4 expandtab
set laststatus=2
set belloff=all
set noswapfile noundofile nobackup
set hlsearch
set hidden


" ex mode を無効に
nnoremap Q <Nop>
nnoremap q :close<CR>
tnoremap <silent> <ESC> <C-\><C-n>
nnoremap <C-l> :nohlsearch<CR><C-l>

