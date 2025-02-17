[unified](https://unifiedjs.com/)

- [x] [Intro to unified - unified](https://unifiedjs.com/learn/guide/introduction-to-unified/)
- [x] [Use unified - unified](https://unifiedjs.com/learn/guide/using-unified/)
- [x] [Syntax trees in TypeScript - unified](https://unifiedjs.com/learn/guide/syntax-trees-typescript/)

# awit in visit

- [MarkdownをHTMLに変換するunifiedインターフェースについての解説 #JavaScript - Qiita](https://qiita.com/masato_makino/items/ef35e6687a71ded7b35a#)

# article

- @2021 [unified を使う前準備](https://zenn.dev/januswel/articles/e4f979b875298e372070)

## markdown拡張

- [x] @2023 [remark のプラグインを作ってMarkdownの文法を勝手に拡張しよう](https://zenn.dev/yosipy/articles/a7b6ab950bed49)
- @2021 [unified を使って Markdown を拡張する](https://zenn.dev/januswel/articles/745787422d425b01e0c1)

# api

[unified - unified](https://unifiedjs.com/explore/package/unified/)

- process

- parse
- run
- stringify

# plugin

[Create a plugin - unified](https://unifiedjs.com/learn/guide/create-a-plugin/#plugin)

# ts

[remark - markdown processor powered by plugins](https://remark.js.org/)

- [[vibliostyle]] [Remark で広げる Markdown の世界](https://vivliostyle.github.io/vivliostyle_doc/ja/vivliostyle-user-group-vol2/spring-raining/index.html)
- @2022 [jsでmarkdownを扱うパッケージがややこしいのでまとめておく](https://zenn.dev/rizzzse/scraps/34004c97ca61a3)

```text
| ........................ process ........................... |
| .......... parse ... | ... run ... | ... stringify ..........|

          +--------+                     +----------+
Input ->- | Parser | ->- Syntax Tree ->- | Compiler | ->- Output
          +--------+          |          +----------+
                              X
                              |
                      +--------------+
                      | Transformers |
                      +--------------+
```

# mdast

# remark-parse

# stringify

# remark-rehype

`mdast => hast`

# toc

# ReactMarkdown

- `toc` @2023 [Next.jsでブログを作ってみました](https://zenn.dev/redpanda/articles/ab0832ce800bf3#remark-toc%E3%82%92%E5%88%A9%E7%94%A8)

- [unifiedとrehypeによるHTMLの加工 | 前編 unifiedとはどういうものなのか](https://www.codegrid.net/articles/2022-rehype-1/)

- @2023 [Next.jsでブログをつくった](https://www.haxibami.net/blog/posts/blog-renewal)
- [ ] @2022 [MarkdownをHTMLに変換するunifiedインターフェースについての解説 #JavaScript - Qiita](https://qiita.com/masato_makino/items/ef35e6687a71ded7b35a#unified%E3%82%A4%E3%83%B3%E3%82%BF%E3%83%BC%E3%83%95%E3%82%A7%E3%82%A4%E3%82%B9%E3%81%A8%E3%81%AF)

# toc

`remark-toc` はうまくいかなかった。

- [ ] @2023 [Contentlayer で目次を生成する　ほか #Next.js - Qiita](https://qiita.com/kedama-t/items/091ea23b8ae7f73595da)

[GitHub - JS-DevTools/rehype-toc: A rehype plugin that adds a table of contents (TOC) to the page](https://github.com/JS-DevTools/rehype-toc)

- @2020 [Remark・Rehype プラグインで文書の見出しに自動で ID を振り目次リストを自動生成する - Neo's World](https://neos21.net/blog/2020/11/13-01.html)

# syntax highlight

## shiki

- @2023 [Rehype Pretty Code を使って、美しきシンタックスハイライトを手に入れる | osgsm's personal website](https://osgsm.io/posts/introducing-rehype-pretty-code)

- [react-markdownでコードをシンタックスハイライトさせる | Goodlife.tech](https://goodlife.tech/posts/react-markdown-code-highlight.html)

- [nilci - ブログのコードブロックをいい感じにする（前編）](https://tori29.jp/blog/20230903_react_code_block)

# image

- @2022 [Next.js+Markdownでの画像を@next/imageを使って表示する | TOMILOG](https://blog.ryou103.com/post/next-js-markdown-image/)
