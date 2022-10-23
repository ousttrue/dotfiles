[Vim と asyncomplete を使って IME を作った。 https://zenn.dev/mattn/articles/5a84f6a09f907c374577]

https://hakasenote.hnishi.com/2021/20210105-vim-eskk/

https://arimasou16.com/blog/2021/05/02/00389/

	https://vim-jp.org/vim-users-jp/2010/02/09/Hack-123.html
	http://kstn.fc2web.com/seikana_zisyo.html
	http://quasiquote.org/log2/uim/Programming/Scheme/2010/12/23/skkserv

[* vim]
[[eskk]]
	https://github.com/tyru/eskk.vim

code:.vim
 let g:eskk#directory = "~/.eskk"
 let g:eskk#dictionary = { 'path': "~/.skk-jisyo", 'sorted': 0, 'encoding': 'utf-8', }
 let g:eskk#large_dictionary = { 'path': "~/.eskk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp', }



	https://gist.github.com/mattn/1504949

[* skk]
	http://openlab.ring.gr.jp/skk/wiki/wiki.cgi?page=%A5%EA%A5%F3%A5%AF%BD%B8

[* skkserver]
	http://openlab.ring.gr.jp/skk/skkserv-ja.html

	https://rubyist.g.hatena.ne.jp/edvakf/20100422/1271956652

	https://github.com/wachikun/yaskkserv
		http://umiushi.org/~wac/yaskkserv/
		https://lurdan.hatenablog.com/entry/20101215/1292426956

	https://github.com/nathancorvussolis/pcrvskkserv


- [新しいVim用日本語入力プラグインを作った](https://zenn.dev/kuu/articles/vac2021-skkeleton)

# [[vim]]
- [[eskk]]
- [GitHub - ueno/libskk: Japanese SKK input method library](https://github.com/ueno/libskk)
