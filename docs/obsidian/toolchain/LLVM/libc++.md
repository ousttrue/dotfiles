https://libcxx.llvm.org/

# abi version

https://libcxx.llvm.org/DesignDocs/ABIVersioning.html

## 2

`cmake -DLIBCXX_ABI_UNSTABLE=1`

`emscripten`

`/upstream/include/c++/v1/__config_site`

```c++
#define _LIBCPP_ABI_VERSION 2
#define _LIBCPP_ABI_NAMESPACE __2
```

## 1

`zig`

# version

## 20

# config

https://libcxx.llvm.org/DesignDocs/CapturingConfigInfo.html

- https://libcxx.llvm.org/DesignDocs/CapturingConfigInfo.html

# build

https://github.com/ossia/sdk/blob/fddd40e4b2ce93e9ce441679313e77b6924adfd5/WASM/llvm.sh#L14
