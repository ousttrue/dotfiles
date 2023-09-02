# NULL

- [What header defines NULL in C++? - Stack Overflow](https://stackoverflow.com/questions/12023476/what-header-defines-null-in-c)

# __need_NULL

[Developer Community](https://developercommunity.visualstudio.com/t/-null-for-linux-development-not-defined/932792)

- [Why is clang defining NULL as __null ?? - Clang Frontend / Using Clang - LLVM Discussion Forums](https://discourse.llvm.org/t/why-is-clang-defining-null-as-null/53584)

# stddef.h
- [c - Why is stddef.h not in /usr/include? - Stack Overflow](https://stackoverflow.com/questions/37158651/why-is-stddef-h-not-in-usr-include)

```sh
> rg --files /usr | rg stddef.h
/usr/include/linux/stddef.h
/usr/lib/gcc/x86_64-linux-gnu/11/include/stddef.h
/usr/lib/llvm-14/lib/clang/14.0.0/include/stddef.h
/usr/lib/llvm-16/lib/clang/16/include/stddef.h
/usr/lib/llvm-16/include/c++/v1/stddef.h
```

```
> clang++-16 -x c++ -stdlib=libc++ -v -E /dev/null
#include "..." search starts here:
#include <...> search starts here:
 /usr/lib/llvm-16/bin/../include/c++/v1
 /usr/lib/llvm-16/lib/clang/16/include
 /usr/local/include
 /usr/include/x86_64-linux-gnu
 /usr/include
End of search list.
```

