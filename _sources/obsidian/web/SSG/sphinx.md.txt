[[markdown]] [[myst-parser]]

- [read sphinx ドキュメント](https://ousttrue.github.io/read_sphinx/)

# Version
- [Changelog — Sphinx documentation](https://www.sphinx-doc.org/en/master/changes.html)
## 7.3
## 6.0

# toctree
- @2021 [Sphinxのtoctreeにおける順序操作](https://zenn.dev/attakei/articles/337db96e3f7d30)
- @2020 [Allow to specify toctree pages as direct-children of parent page · Issue #8287 · sphinx-doc/sphinx · GitHub](https://github.com/sphinx-doc/sphinx/issues/8287)
- @2011 [Sphinxのドキュメントでは、「glob」フラグオプションによって提供されるtoctreeの順序を元に戻すにはどうすればよいですか？ - VoidCC](http://ja.voidcc.com/question/p-npkoyvmn-dw.html)

# myst-parser
- @2021 [Static Sites With Sphinx and Markdown - PyCharm Guide](https://www.jetbrains.com/pycharm/guide/tutorials/sphinx_sites/)
- @2021 [Sphinx で使える Markdown 方言 'MyST' - Qiita](https://qiita.com/Tachy_Pochy/items/53866eea43d0ad93ea1d)

# sphinxcontrib
- @2021 [【Python】PyPI登録のコツ - Qiita](https://qiita.com/koKekkoh/items/c5ce6bde24417dbca1a7)

# docutils
- https://docutils.sourceforge.io/
## rst syntax
- https://docutils.sphinx-users.jp/docutils/docs/ref/rst/restructuredtext.html
- http://docutils.sourceforge.net/rst.html

# theme
[[sphinx_theme]]

# gettext
- @2011 [(4日目) Sphinx の文書を翻訳してみよう (sphinx-gettext-helper) - Hack like a rolling stone](https://tk0miya.hatenablog.com/entry/20111204/p1)

# 拡張
- [チュートリアル: シンプルな拡張を作成 — Sphinx v1.0 (hg) documentation](http://sphinx.shibu.jp/ext/tutorial.html)
- [拡張機能のチュートリアル — Sphinx documentation](https://www.sphinx-doc.org/ja/master/development/tutorials/index.html)
	- ["Hello world" 拡張機能の開発 — Sphinx documentation](https://www.sphinx-doc.org/ja/master/development/tutorials/helloworld.html)


@2021 [SphinxでPythonライブラリのドキュメント周りを整備する - Qiita](https://qiita.com/simonritchie/items/eef7d50959ad9bdb8440)

# debug
`launch.json`
```json
 {
     // Use IntelliSense to learn about possible attributes.
     // Hover to view descriptions of existing attributes.
     // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
     "version": "0.2.0",
     "configurations": [
         {
             "name": "sphinx build",
             "type": "python",
             "request": "launch",
             "cwd": "${workspaceFolder}/docs",
             "module": "sphinx.cmd.build",
             "args": [
                 ".",
                 "../public"
             ]
         }
     ]
 }
 ```

# chm
- http://mtg-guilds.blogspot.com/2012/04/sphinxhtmlhelp.html
- http://lab1092.blog.jp/archives/51692326.html
