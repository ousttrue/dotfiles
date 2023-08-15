# csi
> `csi -ss` は `main` 関数を実行します。

```scm
;;; Does a lousy job of error checking!
(define (main args)
  (quickrep (irregex (car args)) (cadr args)))
```

# build
- [chicken を cygwin で mingw 用にコンパイル - 新千葉 ガーベージ・コレクション](https://ryos36.hatenablog.com/entry/2014/12/21/110529)

```
make PLATFORM=mingw-msys PREFIX=D:/msys64/usr/local/ install
```

# chicken-install
[chicken-install not working on windows : r/learnlisp](https://www.reddit.com/r/learnlisp/comments/nqlvqk/chickeninstall_not_working_on_windows/)

```
chicken-install -u
```

[Re: Installing Chicken 5.2.0 on Windows - chicken-install -update-db hanging](https://www.mail-archive.com/chicken-users@nongnu.org/msg20995.html)
