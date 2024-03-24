# sort の比較関数

## qsort

https://learn.microsoft.com/ja-jp/cpp/c-runtime-library/reference/qsort?view=msvc-170

```c
void qsort(
   void *base,
   size_t number,
   size_t width,
   int (__cdecl *compare )(const void *, const void *)
);
```

## 負(左辺が先)

## 正(右辺が先)

## 0(同じ)

