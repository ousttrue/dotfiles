- mypy
- pylance
- pyright

型ヒントの sytanx
@2014 `3.5` [PEP 484 – Type Hints | peps.python.org](https://peps.python.org/pep-0484/)

stubファイル配布について
@2017 `3.7` [PEP 561 – Distributing and Packaging Type Information | peps.python.org](https://peps.python.org/pep-0561/)

- @2020 [mypyで静的型チェックを導入する - け日記](https://ohke.hateblo.jp/entry/2020/10/03/230000)
- @2019 [Pythonでゆるく始める静的型検査 - Qiita](https://qiita.com/ocknamo/items/6341d0a7757c668782c8)
- @2015 [Pythonではじまる、型のある世界 - Qiita](https://qiita.com/icoxfog417/items/c17eb042f4735b7924a3)

# ProjectLocal

`${workspaceFolder}/typings`

# Stub Files

- @2020 [Pythonのスタブファイルにdocstringを付与してくれるライブラリを突貫で作った - Qiita](https://qiita.com/simonritchie/items/d6657f240b77fbfed103)
- @2018 [PEP 561 に準拠した型ヒントを含むパッケージの作り方 – ymyzk’s blog](https://blog.ymyzk.com/2018/09/creating-packages-using-pep-561/)

- pyi
- `@overload`
- search path ?
  - same directory
  - PYTHONPATH
  - shared/typehints/pythonX.Y

# typeshed

- [GitHub - python/typeshed: Collection of library stubs for Python, with static types](https://github.com/python/typeshed)
- @2021 [Pythonの型を完全に理解するためのtypingモジュール全解説(3.10対応) #Python - Qiita](https://qiita.com/nicco_mirai/items/5591c1c48b1422c324c9)
- @2022 [Abstract Base Classes and Protocols: What Are They? When To Use Them?? Lets Find Out! - Justin A. Ellis](https://jellis18.github.io/post/2022-01-11-abc-vs-protocol/)
- @2021 [PythonのProtocolによるstructural subtypingでインタフェースを記述する - sambaiz-net](https://www.sambaiz.net/article/325/)

# typing.Protocol

- @2019 [PythonでProtocolを使って静的ダック・タイピング - Qiita](https://qiita.com/spicy_laichi/items/29ef79eac29d61fcb503)

# List

```py
List[str]
# import 不要
list[str]
```

# Tuple

```py
Tuple[int, str]
# import 不要
tuple[int, str]
```

# Dict

```py
Dict[str, str]
# import 不要
dict[str, str]
```

# Union

```py
Union[int, str]

# 3.10
int | str
```

# Intersection

- @2023 [Advanced Python (Typing: Union and Intersection in Type Hints) | by Andrew Wreford Eshakz | Medium](https://medium.com/@wrefordmessi/advanced-python-typing-union-and-intersection-in-type-hints-45e7090e2a76)
- @2019 [type hinting で複数の Protocol を実装したクラスの型を表現する #Python - Qiita](https://qiita.com/halhorn/items/5ac350627dd4b47264c9)

# function value

```py
Callable[[PARAMS], RET]
```

# def yield

```py
Iterator[YIELD_TYPE]
```

# Self

## 3.11

- [Python 3.11の新機能(その6) 型ヒントの新機能 - PEP-673 Self型: Python3.11の新機能 - python.jp](https://www.python.jp/news/wnpython311/typing2.html)

# 型引数

## Type, TypeVar

- [クラス自体に対しての型ヒントに使える python の typing.Type #Python - Qiita](https://qiita.com/Showy1/items/b5fe2a39ecae83ab738f)

## 3.12

- [Python3.12からPEP695-Type Parameter Syntax(型引数構文)が導入され、型変数を使ったクラスや関数の定義が大きく変わる #Python - Qiita](https://qiita.com/junkmd/items/1aa7be17401cfebab92d)
