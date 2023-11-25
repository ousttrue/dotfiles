http://www17.plala.or.jp/KodamaDeveloped/LetsProgramming/details_icu_build_procedure.html

[ICU Documentation | ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications. The ICU User Guide provides documentation on how to use ICU.](https://unicode-org.github.io/icu/)

# build
icudata は最初 stub で進めて後で本物で置き換える？

# ucnv_open("Shift_JIS") => null

```cpp
UErrorCode err = UErrorCode::U_ZERO_ERROR;
auto pConverter = ucnv_open(charaCode.c_str(), &err);


UErrorCode::U_FILE_ACCESS_ERROR
```

- @2014 [C/C++ におけるプラットフォームごとの文字変換処理 #Windows - Qiita](https://qiita.com/shimacpyon/items/17274fbfb711965f2d1a)
- @2012 [ICU のライブラリサイズを削減する方法 #C++ - Qiita](https://qiita.com/shimacpyon/items/652281d6b28572fd434d)

