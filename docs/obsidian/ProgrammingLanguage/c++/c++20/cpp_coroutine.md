[[c++20]]

- [コルーチン - cpprefjp C++日本語リファレンス](https://cpprefjp.github.io/lang/cpp20/coroutines.html)

- @2021 [20分くらいでわかった気分になれるC++20コルーチン | ドクセル](https://www.docswell.com/s/yohhoy/L57EJK-cpp20coro#p29)
- @2020 [【C＋＋】C＋＋のコルーチンを気軽に試してみる – 株式会社ロジカルビート](https://logicalbeat.jp/blog/5014/)
- @2018 [C++コルーチン拡張メモ - Qiita](https://qiita.com/yohhoy/items/aeb3c01d02d0f640c067)

[co_await_asio.cpp · GitHub](https://gist.github.com/jbandela/95d54560abe37775d957f65881170641)

# promise_type
```c++
R some_routine()
{
}
```
とあるときに
`R::promise_type` が `Promise型`
関数 body で `co_await`, `co_return`, `co_yield` を使うことができる。




- @2021 [C++ でコルーチン (async/await 準備編) - Qiita](https://qiita.com/tan-y/items/ae54153ec3eb42f80638)

# generator
[[c++23]]
[[cpp_generator]]

`yield_value`
- @2021 [My tutorial and take on C++20 coroutines](https://www.scs.stanford.edu/~dm/blog/c++-coroutines.html)

# task
`return_value` or `return_void`

- [https://downloads.ctfassets.net/oxjq45e8ilak/4kVoTkxYBiVM9lPBZiG2HO/a5e36dc80fd898885269bd6320c96196/Pavel_Novikov_Uchimsya_gotovit_C_korutiny_na_praktike_2020_06_28_18_49_49.pdf](https://downloads.ctfassets.net/oxjq45e8ilak/4kVoTkxYBiVM9lPBZiG2HO/a5e36dc80fd898885269bd6320c96196/Pavel_Novikov_Uchimsya_gotovit_C_korutiny_na_praktike_2020_06_28_18_49_49.pdf)
- @2021 [C++20 Coroutines — Complete* Guide | by Šimon Tóth | ITNEXT](https://itnext.io/c-20-coroutines-complete-guide-7c3fc08db89d)
- @2021 [C++20 Coroutines: sketching a minimal async framework – Jeremy's Blog](https://www.jeremyong.com/cpp/2021/01/04/cpp20-coroutines-a-minimal-async-framework/)
- @2020 [C++20コルーチンで遊ぶ with OpenSiv3D - Qiita](https://qiita.com/tyanmahou/items/1799d80c9e260b2267d5)
