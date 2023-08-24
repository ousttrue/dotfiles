[[mesa]]
[[crystal]] `14`
[[zig]] `15`
[[clang]]

[Getting Started with the LLVM System — LLVM 17.0.0git documentation](https://llvm.org/docs/GettingStarted.html)

# Version
- [Clang - C++ Programming Language Status](https://clang.llvm.org/cxx_status.html)
## 18
- [Clang 18.0.0git (In-Progress) Release Notes — Clang 18.0.0git documentation](https://clang.llvm.org/docs/ReleaseNotes.html)
## 17
## 16
- [Clang 16.0.0 Release Notes — Clang 16.0.0 documentation](https://releases.llvm.org/16.0.0/tools/clang/docs/ReleaseNotes.html)
## 15

## 14
- @2022 [LLVM/Clang 14をビルドする - Qiita](https://qiita.com/k0kubun/items/4c29cf9cc423448ea59a)

## 12
- @2021 [Rust + LLVMでプログラミング言語を自作してセルフホスティングした話](https://zenn.dev/yubrot/articles/eaaeeab742b4a1)

## 8
- @2019 [こわくないLLVM入門！ - Qiita](https://qiita.com/Anko_9801/items/df4475fecbddd0d91ccc)
- @2017 [LLVMを始めよう！ 〜 LLVM IRの基礎はclangが教えてくれた・Brainf**kコンパイラを作ってみよう 〜 - プログラムモグモグ](https://itchyny.hatenablog.com/entry/2017/02/27/100000)

## 7
- @2018 [LLVM builld - simotin13's message](http://mcommit.hatenadiary.com/entry/2018/01/05/025802)

## 3
- @2016 [OCamlのSedlex+Menhir+LLVMでLispコンパイラを作ろうとしたが行き詰まった件 - Qiita](https://qiita.com/Tamamu/items/e647c18403681df15c42)
- @2015 [LLVM + pythonでC++のAST生成メモ(Windows編).md · GitHub](https://gist.github.com/yoggy/34d5bc8a7993ba1242d0)

# Build
8core memory16GB SSDで90分くらい

```
cmake -S . -B build -DLLVM_TARGETS_TO_BUILD=host -DLLVM_ENABLE_DOXYGEN=off -DLLVM_ENABLE_SPHINX=off -DCMAKE_BUILD_TYPE=Rlease -DCMAKE_INSTALL_PREFIX=D:/llvm -G Ninja

-- The C compiler identification is MSVC 19.37.32822.0
-- The CXX compiler identification is MSVC 19.37.32822.0
-- The ASM compiler identification is MSVC
-- LLVM host triple: x86_64-pc-windows-msvc
-- LLVM default target triple: x86_64-pc-windows-msvc

-DLLVM_TARGETS_TO_BUILD=host
-DLLVM_ENABLE_DOXYGEN=off
-DLLVM_ENABLE_SPHINX=off
-DLLVM_ENABLE_PROJECTS=lld,clang

cmake --build build
[0/3946]... 40min? 1400
``` 

## ccls
```
cmake -S . -B build -DClang_DIR=D:/llvm/lib/cmake/clang
```

## zig
`zig-11` でビルドするには？

# Tutorial
- [LLVM Tutorial: Table of Contents — LLVM 16.0.0git documentation](https://llvm.org/docs/tutorial/)
