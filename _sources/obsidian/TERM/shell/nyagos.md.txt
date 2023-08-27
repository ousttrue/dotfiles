
[[shell]] [[golang]]
[[nyagos]]

- [nyaos.org](https://nyaos.org/)
- [GitHub - nyaosorg/nyagos: NYAGOS - The hybrid Commandline Shell between UNIX & DOS](https://github.com/nyaosorg/nyagos)
	- [nyagos/readme_ja.md at master · nyaosorg/nyagos · GitHub](https://github.com/nyaosorg/nyagos/blob/master/readme_ja.md)

- @2023 [scoop / nyagos で始めるコマンドライン生活](https://zenn.dev/zetamatta/books/5ac80a9ddb35fef9a146)
`scoop`, `setup`

- @2020 [Windows ユーザは cmd.exe で生きるべきかもしれないが、俺は nyagos でやってきた - 標準愚痴出力](https://zetamatta.hatenablog.com/entry/2020/07/21/003444)

[nyagosでビットマップ表示 - Qiita](https://qiita.com/nocd5/items/1a712bcf1c1a8c1d2e37)

# Version
## master
- @2023 skk

## 4.4.13

## 4.4
- @2019 [NYAGOS 4.4.2_0 を公開してしまいました - 標準愚痴出力](https://zetamatta.hatenablog.com/entry/2019/04/04/001721)

## 4.3
- @2018 [nyagos で lua53.dll のかわりに GopherLua を使おう - Qiita](https://qiita.com/zetamatta/items/112484eb7fdae87830a0)
- @2018 [NYAGOS 4.3 で GopherLua が採用される | text.Baldanders.info](https://text.baldanders.info/release/2018/04/nyagos-4_3/)

## 4.2.5
- @2018 [NYAGOS 4.2.5 のリリースと環境変数の扱い | text.Baldanders.info](https://text.baldanders.info/release/2018/03/nyagos-4_2_5_beta-released/)
- @2018 [NYAGOS 4.2.5βが、いかにしてバッチファイルでの環境変数の変更取り込みを可能としたか - Qiita](https://qiita.com/zetamatta/items/efff93d92ac2150192fb)

## 4.2
- @2017 [NYAGOSの小TIPS集 - Qiita](https://qiita.com/zetamatta/items/699f772691f19dab03b0)

# ~/.nyagos
- [.nyagos · GitHub](https://gist.github.com/hogewest/0ebe5acd5b10cc31c2a6f9195e2290f5)
- https://gist.github.com/rcapraro/1b8003002ee47caa4b12
- https://gist.github.com/tsuyoshicho/1e6288193047d782b576d8cf5bf9bc13

## history
- @2014 [nyagosでヒストリ補完する - Qiita](https://qiita.com/nocd5/items/7cfc2441868442838148)
`bind`

## prompt
- @2018 [【NYAGOS】Nyagos のプロンプトに git の現在の branch 名を表示する - Tumbling Dice](https://outofmem.hatenablog.com/entry/2016/01/27/014352)
- @2017 [Nyagos リポジトリブランチ名表示 プロンプトの一例 - Qiita](https://qiita.com/tsuyoshi_cho/items/d029825b6d8d3688da92)
- @2016 [【NYAGOS】プロンプトで使える特殊文字と ANSI エスケープシーケンスを Lua でラップする - Tumbling Dice](https://outofmem.hatenablog.com/entry/2016/01/27/014920)
- @2015 [nyagosスクリプト解説 - CMD.EXEで化けさせず、nyagosの中だけプロンプトをカラー化 - Qiita](https://qiita.com/zetamatta/items/c08586c85fa73c182a7a)
- [nyagos customize script(gitのステータスと作業ブランチ名、あと直前のコマンドの状態によって顔文字が変化する) · GitHub](https://gist.github.com/Pctg-x8/cc0462beac7dfedd4abb)
- [Nyagos リポジトリブランチ名表示 プロンプトの一例 ref: http://qiita.com/tsuyoshi_cho/items/d029825b6d8d3688da92 · GitHub](https://gist.github.com/tsuyoshicho/1e6288193047d782b576d8cf5bf9bc13)

## escape sequence
- @2016 [【NYAGOS】プロンプトで使える特殊文字と ANSI エスケープシーケンスを Lua でラップする - Tumbling Dice](https://outofmem.hatenablog.com/entry/2016/01/27/014920)

# Completion
- @2019 [Git のセットアップ for Windows & nyagos - 標準愚痴出力](https://zetamatta.hatenablog.com/entry/2019/07/13/113245)

## complete_for
- [NYAGOS開発ノート：新補完API（試作中） - 標準愚痴出力](https://zetamatta.hatenablog.com/entry/2019/01/28/012545)
- [nyagos解析ssh_config – wentao's blog](https://wentao.org/post/2022-05-01-nyagos-with-ssh-config/)

# nyagos.d
lua で書いてあるので読むべし

## box
- [nyagos 4.3でもmigemoでディレクトリ移動したい! - Qiita](https://qiita.com/nocd5/items/1736064cd9ee652d5920)]

## alias
素のテーブルではない。
```lua
  function nyagos.alias.print_args(args)
    print(args)
    print(#args, args[0])
    for i, v in ipairs(args) do
      print(i, v)
    end
    print('unpack', unpack(args.rawargs))
  end

> print_args a b 'c d' "e f" %SHELL%
map[0:print_args 1:a 2:b 3:c d 4:e f 5:/bin/bash rawargs:map[0:print_args 1:a 2:b 3:'c d' 4:"e f" 5:/bin/bash]]
5       print_args
1       a
2       b
3       c d
4       e f
5       /bin/bash
unpack  a       b       'c d'   "e f"   /bin/bash
```
`quote` の扱い。

# peco
- [peco で Docker container ID を選択するやつ。 - Qiita](https://qiita.com/ujiro99@github/items/0f42088559e1085e5c28)

# zoxide
- @2023 [つかさのほえほえ日記: zoxide+nyagosでディレクトリ移動](http://hoehoetukasa.blogspot.com/2023/01/zoxidenyagos.html)

# osx
- [M1 Mac で NYAGOS を使ってみる](https://zenn.dev/tkm/scraps/c23004b62b0d08)

# nyaos3000
- [GitHub - nyaosorg/nyaos3000: Nihongo Yet Another OSes Shell 3000](https://github.com/nyaosorg/nyaos3000)
