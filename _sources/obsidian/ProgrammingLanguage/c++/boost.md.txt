- [Boost C++ Libraries](https://www.boost.org/)

# Version
## 1.82

# Env
`mesonbuild/dependencies/boost.py`

# meson: BOOST_ROOT
BOOST_INCLUDE を使おう!

# build
```sh
$ b2.exe install --prefix=lib64 address-model=64 --with-thread --with-date_time --with-timer --with-log
```

```
    - atomic                   : not building
    - chrono                   : not building
    - container                : not building
    - context                  : not building
    - contract                 : not building
    - coroutine                : not building
    - date_time                : building
    - exception                : not building
    - fiber                    : not building
    - filesystem               : building
    - graph                    : not building
    - graph_parallel           : not building
    - headers                  : not building
    - iostreams                : not building
    - json                     : not building
    - locale                   : not building
    - log                      : building
    - math                     : not building
    - mpi                      : not building
    - nowide                   : not building
    - program_options          : not building
    - python                   : not building
    - random                   : not building
    - regex                    : not building
    - serialization            : not building
    - stacktrace               : not building
    - system                   : not building
    - test                     : not building
    - thread                   : building
    - timer                    : building
    - type_erasure             : not building
    - url                      : not building
    - wave                     : not building
```
## WINVER
[WINVER および \_WIN32\_WINNT の更新 | Microsoft Learn](https://learn.microsoft.com/ja-jp/cpp/porting/modifying-winver-and-win32-winnt?view=msvc-170)

|nt|BOOST_USE_WINAPI_VERSION|
|-|-|
|nt5|0x0501
|nt6|0x0600|
|nt62|0x0602|

b2 の後ろにこれ
`define=BOOST_USE_WINAPI_VERSION=0x0602`

のようにした場合 `-D_WIN32_WINNT=0x0501` となるようで `nt5` というシンボルになるようだ。
`b2` と `project` で `_WIN32_WINNT` が一致していないと `undefined reference` になる。

[WINVER, \_WIN32\_WINNT の設定値 - Qiita](https://qiita.com/hkuno/items/7b8daa37d9b68e390d7e)

[Boost 1.78.0リリースノート - boostjp](https://boostjp.github.io/document/version/1_78_0.html#log)

```cpp
# 0x0602
#               if BOOST_USE_WINAPI_VERSION >= BOOST_WINAPI_VERSION_WIN8
#                   define BOOST_LOG_VERSION_NAMESPACE v2s_mt_nt62
#
```
`boost::log::v2s_mt_nt62`

## meson: BOOST_INCLUDEDIR
`prefix/include/BOOST_VERSION`
一個深い！
## meson: BOOST_LIBRARYDIR
`prefix/lib`
