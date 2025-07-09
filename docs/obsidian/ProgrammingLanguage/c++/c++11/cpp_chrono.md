[[cpp]]
`std::chrono`

- [chrono - cpprefjp C++日本語リファレンス](https://cpprefjp.github.io/reference/chrono.html)

- @2020 [[c++11]本日の経過ミリ秒を取得する – 算譜とドリア](https://programdoria.com/programming/cpp/milliseconds_today/)
- @2015 [本の虫: C++11の時間ライブラリ: chrono](https://cpplover.blogspot.com/2015/01/c11-chrono.html)
- @2012 [本の虫: C++11の時間ライブラリは美しさを追求したあまり、かえって使いにくくなっているのではないか](https://cpplover.blogspot.com/2012/05/c11_24.html)

# float, double

- [duration_castと浮動小数点数型 - Faith and Brave - C++で遊ぼう](https://faithandbrave.hateblo.jp/entry/2014/02/03/151841)
- [std::chronoで小数点のdurationを使う - Qiita](https://qiita.com/nichida-dn/items/39c6f5d654992f2e9e40)

```cpp
using ms_f = std::chrono::duration<float, std::raito<1, 1000>>;
```

# std::chrono::nanoseconds nano

## from int64_t(nano)

```cpp
auto nano = std::chrono::nanoseconds(acquired.presentTimeNano);
```

## to sec(double)

```cpp

auto sec = std::chrono::duration_cast<std::chrono::duration<double>>(nano);
```
