- @2021 [Pythonの型を完全に理解するためのtypingモジュール全解説(3.10対応) #Python - Qiita](https://qiita.com/nicco_mirai/items/5591c1c48b1422c324c9)
- @2022 [Abstract Base Classes and Protocols: What Are They? When To Use Them?? Lets Find Out! - Justin A. Ellis](https://jellis18.github.io/post/2022-01-11-abc-vs-protocol/)
- @2021 [PythonのProtocolによるstructural subtypingでインタフェースを記述する - sambaiz-net](https://www.sambaiz.net/article/325/)

# typing.Protocol

- @2019 [PythonでProtocolを使って静的ダック・タイピング - Qiita](https://qiita.com/spicy_laichi/items/29ef79eac29d61fcb503)

# function value

```py
Callable[[PARAMS], RET]
```

# def yield

```py
Iterator[YIELD_TYPE]
```

# Tuple

```py
Tuple[int, str]

# import 不要
tuple[int, str]
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

# Self

## 3.11

- [Python 3.11の新機能(その6) 型ヒントの新機能 - PEP-673 Self型: Python3.11の新機能 - python.jp](https://www.python.jp/news/wnpython311/typing2.html)

# 型引数

## Type, TypeVar

- [クラス自体に対しての型ヒントに使える python の typing.Type #Python - Qiita](https://qiita.com/Showy1/items/b5fe2a39ecae83ab738f)

## 3.12

- [Python3.12からPEP695-Type Parameter Syntax(型引数構文)が導入され、型変数を使ったクラスや関数の定義が大きく変わる #Python - Qiita](https://qiita.com/junkmd/items/1aa7be17401cfebab92d)
