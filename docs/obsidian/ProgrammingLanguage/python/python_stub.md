[[python]]
`python-3.5`

[typing --- 型ヒントのサポート — Python 3.10.0b2 ドキュメント](https://docs.python.org/ja/3/library/typing.html)

# PEP561

[PEP 561 に準拠した型ヒントを含むパッケージの作り方 – ymyzk’s blog](https://blog.ymyzk.com/2018/09/creating-packages-using-pep-561/)
[**PEP 484**](https://www.python.org/dev/peps/pep-0484), [**PEP 526**](https://www.python.org/dev/peps/pep-0526), [**PEP 544**](https://www.python.org/dev/peps/pep-0544), [**PEP 586**](https://www.python.org/dev/peps/pep-0586), [**PEP 589**](https://www.python.org/dev/peps/pep-0589), [**PEP 591**](https://www.python.org/dev/peps/pep-0591), [**PEP 612**](https://www.python.org/dev/peps/pep-0612) and [**PEP 613**](https://www.python.org/dev/peps/pep-0613)

# Type Checker Module Resolution Order

1. user code
2. stub
3. stub package(`-stub` `*.pyi`)
4. inline package(annotation `py.typed`)
5. typeshed

|                            |     |
| -------------------------- | --- |
| `typings/bpy.pyi`          | x   |
| `typings/bpy/__init__.pyi` | o   |

# 実装

## from python コード

`inspect.signature`

- [Python: inspect.signature() で関数のシグネチャを調べる - CUBE SUGAR CONTAINER](https://blog.amedama.jp/entry/2016/10/31/225219)
  lsp に任せればよい

## native module

- native module を作成する前の情報にアクセスしたい
- GOBJECT GIR

# Implementation

- [mypy - Optional Static Typing for Python](http://www.mypy-lang.org/)
- [GitHub - google/pytype: A static type analyzer for Python code](https://github.com/google/pytype)
- [GitHub - facebook/pyre-check: Performant type-checking for python.](https://github.com/facebook/pyre-check)
- `numpy-stubs`
- [GitHub - pygobject/pygobject-stubs: PEP 561 Typing Stubs for PyGObject](https://github.com/pygobject/pygobject-stubs)

## articles

[型ヒントの5年間を振り返る - Google スライド](https://docs.google.com/presentation/d/1kxX5_bL1Rv-sW7zJDBSve9g69A_AJbAEvMXkhlMrBR4/htmlpresent)
(2021)[Pythonでも型を意識したプログラミングを！ 型アノテーションを使おう | 株式会社龍野情報システム](https://tatsuno-system.co.jp/2021/02/03/blog_python-function-annotations/)
(2015)[[翻訳] PEP 0484 -- 型ヒント (Type Hints) - Qiita](https://qiita.com/t2y/items/f95f6efe163b29be59af)

- docutils: ソースが長大すぎて pyright が動作しない。
- windows-curses: native extension

# blender

- https://github.com/mysticfall/bpystubgen
