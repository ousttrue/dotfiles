- [GitHub - alebcay/awesome-shell: A curated list of awesome command-line frameworks, toolkits, guides and gizmos. Inspired by awesome-php.](https://github.com/alebcay/awesome-shell)

- [シェルの歴史 総まとめ（種類と系統図）と POSIX の役割 〜 シェルスクリプトの現在・過去・未来【POSIX改訂間近】 - Qiita](https://qiita.com/ko1nksm/items/e7f43428352c0b4c78f9)

| |__multi__|Windows|git bash|msys|wsl|Linux|
|-|-|-|-|-|-|-|
|term|WezTerm|WezTerm|mintty|mintty|WezTerm|WezTerm|
|CHOST|__CROSS__||x86_64-pc-msys|||
|fep|nyagos-skk ?|||uim-fep|uim-fep|
|muxer|WezTerm|WezTerm||tmux|tmux|tmux|
|shell|nyagos|nyagos|bash|zsh|zsh|zsh|
|cp,mv,rm... |binutils / buybox|busybox64|binutils|binutils|binutils|binutils|
|editor|nvim|vim|nvim(msys)|nvim|nvim|

# 環境
- nyagos を中心に [[smfmt]] を補助(task runner)で使う方向 


 muxer / shell / editor

- naygos
	- binutils(Linux)
	- busybox32
- [GitHub - mvdan/sh: A shell parser, formatter, and interpreter with bash support; includes shfmt](https://github.com/mvdan/sh)	 

 
# 必須
- z
- gg
- ls
- nvim

# 自作
- @2022 [「Shell作れます」と言うために - エムスリーテックブログ](https://www.m3tech.blog/entry/making-nosh)
- @2021 [Rustで始める自作シェル その1 - ぶていのログでぶログ](https://tech.buty4649.net/entry/2021/12/19/235124)
- @2021 [独自シェルを作ってみよう！](http://kozos.jp/nlsh/)
- @2021 [自作シェル「sijimi」を作ってみた](https://zenn.dev/higuruchi/articles/142b613eb1e650)
	- [GitHub - higuruchi/sijimi](https://github.com/higuruchi/sijimi)
- @2019 [自作シェルでヒストリを扱えるようにする - Kludge Factory](https://tyfkda.github.io/blog/2019/07/24/history-in-shell.html)
- @2018 [Simple-Cpp-Shell/Simple C++ Shell at master · bcanozter/Simple-Cpp-Shell · GitHub](https://github.com/bcanozter/Simple-Cpp-Shell/tree/master/Simple%20C%2B%2B%20Shell)
- @2015 [Tutorial - Write a Shell in C • Stephen Brennan](https://brennan.io/2015/01/16/write-a-shell-in-c/)
- [「コマンドラインシェル？？？　誰でも作れますよ」](https://zenn.dev/zetamatta/articles/d7b76ff6535d7d)

## input
- repl
	- rawinput
	- readline edit
	- history
- output prompt

## posix
- [Tutorial - Write a Shell in C • Stephen Brennan](https://brennan.io/2015/01/16/write-a-shell-in-c/)
- @2021 [Rustで始める自作シェル その1 - ぶていのログでぶログ](https://tech.buty4649.net/entry/2021/12/19/235124)
- [GitHub - buty4649/rbsh: Ruby-powerd shell.](https://github.com/buty4649/rbsh)

# Windows
- [[msys2]]
- [[clink]]
- [Elvish Shell](https://elv.sh/)

# Unix
- [[bash]]
- [[fish]]

# Both
- [[nushell]]
- [[powershell]]
- [[xonsh]]
- [[nyagos]]

# features
## mkdir, cd, pushd, popd, z

## cp, mv, rm, ln
- [[coreutils]]
- [[busybox]]

## env, execute, shbang

## history, completion

## output, kitty

## copy, paste
