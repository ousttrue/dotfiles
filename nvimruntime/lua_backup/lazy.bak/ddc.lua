return {
  {
    "Shougo/ddc.vim",
    dependencies = {
      "uga-rosa/ddc-source-lsp-setup",
      "Shougo/ddc-ui-native",
      "LumaKernel/ddc-file",
      "Shougo/ddc-source-around",
      "Shougo/ddc-source-lsp",
      "Shougo/ddc-matcher_head",
      "Shougo/ddc-sorter_rank",
      "Shougo/ddc-converter_remove_overlap",
    },
    config = function()
      --
      vim.cmd [[
" call ddc#custom#patch_global('completionMenu', 'pum.vim')
call ddc#custom#patch_global('ui', 'native')
call ddc#custom#patch_global('sources', [
 \ 'around',
 \ 'lsp',
 \ 'file'
 \ ])
call ddc#custom#patch_global('sourceOptions', {
 \ '_': {
 \   'matchers': ['matcher_head'],
 \   'sorters': ['sorter_rank'],
 \   'converters': ['converter_remove_overlap'],
 \ },
 \ 'around': {'mark': 'around'},
 \ 'nvim-lsp': {
 \   'dup': 'keep',
 \   'keywordPattern': '\k+',
 \   'sorters': ['sorter_lsp-kind']
 \ },
 \ 'file': {
 \   'mark': 'file',
 \   'isVolatile': v:true,
 \   'forceCompletionPattern': '\S/\S*'
 \ }})
call ddc#enable()
" inoremap <Tab> <Cmd>call pum#map#insert_relative(+1)<CR>
" inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
      ]]

      require("ddc_source_lsp_setup").setup()
    end,
  },
}

