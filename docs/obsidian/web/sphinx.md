[[myst-parser]]

- [Sphinxのtoctreeにおける順序操作](https://zenn.dev/attakei/articles/337db96e3f7d30)
- [Sphinxのドキュメントでは、「glob」フラグオプションによって提供されるtoctreeの順序を元に戻すにはどうすればよいですか？ - VoidCC](http://ja.voidcc.com/question/p-npkoyvmn-dw.html)

[* toctree]
[https://github.com/sphinx-doc/sphinx/issues/8287 Allow to specify toctree pages as direct-children of parent page · Issue #8287 · sphinx-doc/sphinx · GitHub]


[* contrib]
[https://qiita.com/koKekkoh/items/c5ce6bde24417dbca1a7 【Python】PyPI登録のコツ - Qiita]



[https://zenn.dev/attakei/articles/337db96e3f7d30 Sphinxのtoctreeにおける順序操作]
https://www.jetbrains.com/pycharm/guide/tutorials/sphinx_sites/

[* docutils]
https://docutils.sourceforge.io/

[* theme]
https://www.sphinx-doc.org/en/master/usage/theming.html

[* gettext]
https://tk0miya.hatenablog.com/entry/20111204/p1

[** 拡張]
http://sphinx.shibu.jp/ext/tutorial.html
https://www.sphinx-doc.org/ja/master/development/tutorials/index.html
	https://www.sphinx-doc.org/ja/master/development/tutorials/helloworld.html

https://qiita.com/Tachy_Pochy/items/53866eea43d0ad93ea1d

https://qiita.com/simonritchie/items/eef7d50959ad9bdb8440
https://qiita.com/Tachy_Pochy/items/53866eea43d0ad93ea1d

http://www.sphinx-doc.org/en/master/
	http://www.sphinx-doc.org/en/master/usage/quickstart.html

code:launch.json
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

[* conf.py]

[* rst syntax]
	https://docutils.sphinx-users.jp/docutils/docs/ref/rst/restructuredtext.html
	http://docutils.sourceforge.net/rst.html

[* chm]
	http://mtg-guilds.blogspot.com/2012/04/sphinxhtmlhelp.html
	http://lab1092.blog.jp/archives/51692326.html

code:.rst
	Indices and tables
	==================
	
 :ref:`genindex`
 :ref:`modindex`
 :ref:`search`
