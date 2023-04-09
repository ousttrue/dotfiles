
- @2019 [C++テンプレートを再考する - Retrieva TECH BLOG](https://tech.retrieva.jp/entry/2019/05/15/132008)
- [【C＋＋】C＋＋で静的ポリモーフィズムを確認してみる – 株式会社ロジカルビート](https://logicalbeat.jp/blog/11031/)

# template concept
`template<typename T>` => `template<concept T>` できる。

```c++
// concept Drawable
template <class T>
concept Drawable = requires (T& x) {
  x.draw(); // 型Tに要求する操作をセミコロン区切りで列挙する。
            // ここでは、メンバ関数draw()を呼び出せることを要求している。
};

// テンプレートパラメータTをコンセプトDrawableで制約する。
// Drawableの要件を満たさない型が渡された場合は制約エラーとなる
template <Drawable T>
void f(T& x) {
  x.draw();
}

// bool型の定数式でコンセプトを定義できるため、
// 型特性としてすでに用意されている定数式をラップしてコンセプトを定義できる
template <class T>
concept Integral = std::is_integral_v<T>;
```

# size

```c++
template<typename T> 
concept Size4 = sizeof(T) == 4;
```
