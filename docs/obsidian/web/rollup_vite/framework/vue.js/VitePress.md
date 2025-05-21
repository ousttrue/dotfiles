https://vitepress.dev/

- https://github.com/logicspark/awesome-vitepress-v1
- @2024 [Vitepressでの簡単なブログ作成 | 株式会社ゼロイチ](https://www.wantedly.com/companies/zeroichi/post_articles/899265)
- @2023 [VuePress2 vs VitePress | N氏の記録](https://ryuden.org/vuepress2-vs-vitepress/)
- @2022 [Viteを使ってSSGを試した話 #AWS - Qiita](https://qiita.com/Kodak_tmo/items/23c0c334c6f08a4a036a)

- @2023 https://ryuden.org/vuepress2-vs-vitepress/
- VuePress(Vue v2)
  - VuePress2(webpack5)
  - VitePress(Vue v3) 👈

# Version

https://github.com/vuejs/vitepress/blob/main/CHANGELOG.md

## @202407 1.3

## 1.2

## 1.0

- @2024 [VitePress v1.0 公式リリースにつき簡単にまとめた](https://zenn.dev/rlab/articles/77a702dd61a08a)

# Build-Time Data Loading

https://vitepress.dev/guide/data-loading

# page order

- https://vitepress.dev/reference/default-theme-sidebar
- https://github.com/condorheroblog/vitepress-export-pdf/issues/12

# theme

`logic` も含まれる？

- https://vitepress.dev/guide/custom-theme

- https://vitepress.dev/guide/extending-default-theme

# default home

```yaml
---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "hello_vulkan"
  text: "vulan on windows and android"
  tagline: My great project tagline
  actions:
    - theme: brand
      text: Markdown Examples
      link: /markdown-examples
    - theme: alt
      text: API Examples
      link: /api-examples

features:
  - title: Feature A
    details: Lorem ipsum dolor sit amet, consectetur adipiscing elit
  - title: Feature B
    details: Lorem ipsum dolor sit amet, consectetur adipiscing elit
  - title: Feature C
    details: Lorem ipsum dolor sit amet, consectetur adipiscing elit
---
```
