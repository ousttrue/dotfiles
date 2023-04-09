# EXPORT dll

```c++
#ifdef A_EXPORTS
#define DECLSPEC __declspec(dllexport)
#else
#define DECLSPEC __declspec(dllimport)
#endif
```

# extern c++

```c++
#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/* Cのコードがたくさん */

#ifdef __cplusplus
}
#endif /* __cplusplus */
```