[[mruby]]

- [オブジェクト指向スクリプト言語 Ruby](https://www.ruby-lang.org/ja/)

@2018 [Ruby のサンドボックスを作って、eval する Bot を作った - kinoppyd dev](https://kinoppyd.dev/blog/ruby-sandbox-eval-bot/)

# version

- [Ruby のリリース一覧](https://www.ruby-lang.org/ja/downloads/releases/)

- @2023 [「アイデアだけでは意味がない、実装されて初めて意味がある」　世界最古のプログラミング言語から学ぶ教訓 - ログミーTech](https://logmi.jp/tech/articles/329930)
- @2023 [単純すぎて流行らなかった「FORTH」、複雑すぎてうまくいかなかった「PL/I」　まつもとゆきひろ氏が過去から学んだ、プログラミング言語のあるべき姿 - ログミーTech](https://logmi.jp/tech/articles/329932)
- @2023 [まつもとゆきひろ氏が“幻のPerl6”から学んだ教訓　「OSSの最大の敵」と「セカンドシステムの危険性」 - ログミーTech](https://logmi.jp/tech/articles/329933)
- @2023 [「Rubyは落ちるか、伸びるかの岐路に立っている」　まつもとゆきひろ氏が語る、30年後に向けた生存戦略 - ログミーTech](https://logmi.jp/tech/articles/329934)

## 3.3

- @2024 [Ruby 3.3正式リリース。YJITコンパイラの大幅な性能向上、RubyのスレッドスケジューラとしてM:Nスレッドスケジューラ導入など新機能 － Publickey](https://www.publickey1.jp/blog/24/ruby_33yjitrubymn.html)
- @2023 [サンプルコードでわかる！Ruby 3.3の主な新機能と変更点 #Ruby - Qiita](https://qiita.com/jnchito/items/67969420ba0050a7e846)
- `bison` 👉 [[lrama]]
- @2023 [Ruby 3.3でYJITを今すぐ有効にすべき理由 - k0kubun&#39;s blog](https://k0kubun.hatenablog.com/entry/ruby-3-3-yjit)

## 3.2

- @2022 [Ruby を手軽にブラウザ上で動かすことが可能に　 WebAssembly を使って解消する、Ruby の動作環境問題 - ログミー Tech](https://logmi.jp/tech/articles/327678)

## 3.1

- @2021 [サンプルコードでわかる！Ruby 3.1 の主な新機能と変更点 - Qiita](https://qiita.com/jnchito/items/bcd9b7f59bf4b30ea5b3)

### YJIT

`LBBV`

- @2022 [Alan Wu 氏「YJIT は Ruby プロセス実行から終了まで全体のパフォーマンス向上を目指す」 ～ RubyKaigi 2022 3 日目キーノート | gihyo.jp](https://gihyo.jp/article/2022/10/rubykaigi2022-3)
- @2022 [Ruby が YJIT でなんで速くなるのか？ Lazy Basic Block Versioning をサクッと理解してみた - estie inside blog](https://www.estie.jp/blog/entry/2022/08/15/153357)
- [「Ruby 3.1.0」がリリース ～プロセス内 JIT コンパイラー「YJIT」をマージ【2022 年 1 月 5 日追記】 - 窓の杜](https://forest.watch.impress.co.jp/docs/news/1377364.html)

## 3.0

- @2021 [2020 年リリース「Ruby 3.0.0」の変更点・新機能を解説 ｜パーソルテクノロジースタッフのエンジニア派遣](https://persol-tech-s.co.jp/hatalabo/it_engineer/540.html)

# vscode

- [Solargraph: A Ruby Language Server](https://solargraph.org/)
- [【2022 年決定版】VSCode を Ruby 超特化型にする 最高の拡張機能 10 選まとめ。 【VisualStudio Code】【プラグイン】 | ゆるプロ](https://yurupro.cloud/2643/)

# rbenv

## ruby-build

- [ruby-build | rbenv 日本語リファレンス | Ruby STUDIO](https://ruby.studio-kingdom.com/rbenv/ruby_build/)

# Sorbet

- [Ruby の型チェッカーの Sorbet を導入しました - freee Developers Hub](https://developers.freee.co.jp/entry/introduce-sorbet-type-checker-for-ruby)

# build windows

`win32/README.win`

```
win32/configure.bat --target=x64-mswin64 --prefix=PREFIX
nmake install

installing binary commands:         c:/gnome/bin
installing base libraries:          c:/gnome/lib
installing arch files:              c:/gnome/lib/ruby/3.1.0/x64-mswin64_140
installing extension objects:       c:/gnome/lib/ruby/3.1.0/x64-mswin64_140
installing extension objects:       c:/gnome/lib/ruby/site_ruby/3.1.0/x64-vcruntime140
installing extension objects:       c:/gnome/lib/ruby/vendor_ruby/3.1.0/x64-vcruntime140
installing extension headers:       c:/gnome/include/ruby-3.1.0/x64-mswin64_140
installing extension scripts:       c:/gnome/lib/ruby/3.1.0
installing extension scripts:       c:/gnome/lib/ruby/site_ruby/3.1.0
installing extension scripts:       c:/gnome/lib/ruby/vendor_ruby/3.1.0
installing extension headers:       c:/gnome/include/ruby-3.1.0/ruby
installing rdoc:                    c:/gnome/share/ri/3.1.0/system
installing html-docs:               c:/gnome/share/doc/ruby
installing capi-docs:               c:/gnome/share/doc/ruby
installing command scripts:         c:/gnome/bin
installing library scripts:         c:/gnome/lib/ruby/3.1.0
installing common headers:          c:/gnome/include/ruby-3.1.0
installing manpages:                c:/gnome/share/man/man1
installing default gems from lib:   c:/gnome/lib/ruby/gems/3.1.0
                                    abbrev 0.1.0
                                    base64 0.1.1
                                    benchmark 0.2.0
                                    bundler 2.3.26
                                    cgi 0.3.5
                                    csv 3.2.5
                                    delegate 0.2.0
                                    did_you_mean 1.6.1
                                    drb 2.1.0
                                    english 0.7.1
                                    erb 2.2.3
                                    error_highlight 0.3.0
                                    fileutils 1.6.0
                                    find 0.1.1
                                    forwardable 1.3.2
                                    getoptlong 0.1.1
                                    ipaddr 1.2.4
                                    irb 1.4.1
                                    logger 1.5.0
                                    mutex_m 0.1.1
                                    net-http 0.3.0
                                    net-protocol 0.1.2
                                    observer 0.1.1
                                    open-uri 0.2.0
                                    open3 0.1.1
                                    optparse 0.2.0
                                    ostruct 0.5.2
                                    pp 0.3.0
                                    prettyprint 0.1.1
                                    pstore 0.1.1
                                    racc 1.6.0
                                    rdoc 6.4.0
                                    readline 0.0.3
                                    reline 0.3.1
                                    resolv 0.2.1
                                    resolv-replace 0.1.0
                                    rinda 0.1.1
                                    ruby2_keywords 0.0.5
                                    securerandom 0.2.0
                                    set 1.0.2
                                    shellwords 0.1.0
                                    singleton 0.1.1
                                    tempfile 0.1.2
                                    time 0.2.0
                                    timeout 0.2.0
                                    tmpdir 0.1.2
                                    tsort 0.1.0
                                    un 0.2.0
                                    uri 0.11.0
                                    weakref 0.1.1
                                    yaml 0.2.0
installing default gems from ext:   c:/gnome/lib/ruby/gems/3.1.0
                                    bigdecimal 3.1.1
                                    date 3.2.2
                                    digest 3.1.0
                                    etc 1.3.0
                                    fcntl 1.0.1
                                    fiddle 1.1.0
                                    io-console 0.5.11
                                    io-nonblock 0.1.0
                                    io-wait 0.2.1
                                    json 2.6.1
                                    nkf 0.1.1
                                    openssl 3.0.1
                                    pathname 0.2.0
                                    psych 4.0.4
                                    readline-ext 0.1.4
                                    stringio 3.0.1
                                    strscan 3.0.1
                                    win32ole 1.8.8
                                    zlib 2.1.1
installing bundled gems:            c:/gnome/lib/ruby/gems/3.1.0
                                    minitest 5.15.0
                                    power_assert 2.0.1
                                    rake 13.0.6
                                    test-unit 3.5.3
                                    rexml 3.2.5
                                    rss 0.2.9
                                    net-ftp 0.1.3
                                    net-imap 0.2.3
                                    net-pop 0.1.1
                                    net-smtp 0.3.1
                                    matrix 0.4.2
                                    prime 0.1.2
                                    rbs 2.7.0
Building native extensions. This could take a while...
                                    typeprof 0.21.3
                                    debug 1.6.3
Building native extensions. This could take a while...
installing bundled gem cache:       c:/gnome/lib/ruby/gems/3.1.0/cache
```
