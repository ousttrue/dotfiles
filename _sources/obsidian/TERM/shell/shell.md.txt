- [GitHub - alebcay/awesome-shell: A curated list of awesome command-line frameworks, toolkits, guides and gizmos. Inspired by awesome-php.](https://github.com/alebcay/awesome-shell)

- [シェルの歴史 総まとめ（種類と系統図）と POSIX の役割 〜 シェルスクリプトの現在・過去・未来【POSIX改訂間近】 - Qiita](https://qiita.com/ko1nksm/items/e7f43428352c0b4c78f9)

| |Windows|git bash|msys|wsl|Linux|
|-|-|-|-|-|-|
|term|WezTerm|mintty|mintty|WezTerm|WezTerm|
|CHOST|||x86_64-pc-msys|||
|fep||||uim-fep|uim-fep|
|muxer|WezTerm||tmux|tmux|tmux|
|shell|nyagos|bash|zsh|zsh|zsh|
|cp,mv,rm... |builtin => busybox64|binutils|binutils|binutils|binutils|
|editor|nvim|vim|nvim(msys)|nvim|nvim|


 muxer / shell / editor

- naygos
	- binutils(Linux)
	- busybox32
- [GitHub - mvdan/sh: A shell parser, formatter, and interpreter with bash support; includes shfmt](https://github.com/mvdan/sh)	 
- [GitHub - go-task/task: A task runner / simpler Make alternative written in Go](https://github.com/go-task/task)
	- [📘Windowsにも優しいタスクランナーTaskを試してみた - Minerva](https://minerva.mamansoft.net/%F0%9F%93%98Articles/%F0%9F%93%98Windows%E3%81%AB%E3%82%82%E5%84%AA%E3%81%97%E3%81%84%E3%82%BF%E3%82%B9%E3%82%AF%E3%83%A9%E3%83%B3%E3%83%8A%E3%83%BCTask%E3%82%92%E8%A9%A6%E3%81%97%E3%81%A6%E3%81%BF%E3%81%9F)
- [Task (go-task) メモ-05 (実行方法) - いろいろ備忘録日記](https://devlights.hatenablog.com/entry/2022/12/21/073000)
- [Make の代わりに Task を使ってみる](https://zenn.dev/spiegel/articles/20210418-task)
- [go-taskでストレスフリーな開発体験 - Retty Tech Blog](https://engineer.retty.me/entry/2021/12/15/161644)
 
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
