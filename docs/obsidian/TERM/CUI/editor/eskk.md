eskk
https://github.com/tyru/eskk.vim

	[https://zenn.dev/kouta/articles/87947515bff4da eskk.vimで 日本語をバリバリ打とう。]
	[https://kato-k.github.io/posts/vim/eskk-installing/ Vimにeskkをインストールする - 忘れないように…]

[** dict]
	https://skk-dev.github.io/dict/

code:.vim
 if !filereadable(expand('~/.config/eskk/jisyo'))
     call system('mkdir -p ~/.config/eskk')
     call system('cd ~/.config/eskk/ && wget http://openlab.jp/skk/dic/SKK-JISYO.L.gz && gzip -d SKK-JISYO.L.gz && nkf -Ew SKK-JISYO.L > jisyo && rm -f SKK-JISYO.L')
 endif
 let g:eskk#directory = "~/.config/eskk"
 let g:eskk#dictionary = { 'path': "~/.config/eskk/my_jisyo", 'sorted': 1, 'encoding': 'utf-8',}
 let g:eskk#large_dictionary = {'path': "~/.config/eskk/jisyo", 'sorted': 1, 'encoding': 'utf-8',}

https://github.com/tyru/eskk.vim
- @2021 https://hakasenote.hnishi.com/2021/20210105-vim-eskk/

```vim
let g:eskk#directory = "~/.eskk"
let g:eskk#dictionary = { 'path': "~/.skk-jisyo", 'sorted': 0, 'encoding': 'utf-8', }
let g:eskk#large_dictionary = { 'path': "~/.eskk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp', }
```