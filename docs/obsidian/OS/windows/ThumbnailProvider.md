https://learn.microsoft.com/en-us/windows/win32/shell/thumbnail-providers

> Live Icons

## RecipeThumbnailProvider

- https://github.com/microsoft/Windows-classic-samples/tree/main/Samples/Win7Samples/winui/shell/appshellintegration/RecipeThumbnailProvider
- [Windows　Shellex 独自サムネイルの実装(覚書) &laquo; 山科駐在員のブログ](https://blog.anshu.biz/?p=6098)

```meson.build
project('RecipeThumbnailProvider', 'cpp')

shared_library(
    'RecipeThumbnailProvider',
    [
        'Dll.cpp',
        'RecipeThumbnailProvider.cpp',
    ],
    vs_module_defs: 'RecipeThumbnailProvider.def',
    install: true,
)
```
