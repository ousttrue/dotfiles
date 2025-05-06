https://hono.dev/

- https://github.com/yusukebe/honox-examples

# version

## 4

- @202402 https://zenn.dev/yusukebe/articles/b20025ebda310a

- @202402 [Reactをまともに使ったことないエンジニアがBun+HonoでSSGを試してみた #JSX - Qiita](https://qiita.com/mbotsu/items/8d3613e34f013f8e3da4)

# bun

```sh
> bunx create-hono my-app
```

# ssg

- https://hono.dev/docs/helpers/ssg

```ts title=build.ts
import app from "./index";
import { toSSG } from "hono/ssg";
import fs from "fs/promises";

toSSG(app, fs);
```

- `ssgParams` [Reactをまともに使ったことないエンジニアがBun+HonoでSSGを試してみた #JSX - Qiita](https://qiita.com/mbotsu/items/8d3613e34f013f8e3da4)
- `markdown` https://siwl.dev/blog/articles/hono-ssg/

## @hono/vite-ssg

- https://blog.berlysia.net/entry/2024-02-29-honox-og-image

- [個人ブログをHugoからHonoに移行しました - ぷらすのブログ](https://blog.p1ass.com/posts/migrate-to-hono/)
- [Hono+SSGなWebサイトをCloudflare Pagesでデプロイするまでのメモ](https://zenn.dev/reikishirasawa/articles/2024-05-26-hono-ssg-tutorial)
- `markdown` [ブログをAstroからHonoのSSGに移行しました- tkan☕️](https://tkancf.com/blog/blog-migration-astro-to-hono)
- @202402 [このサイトをHonoXに書き換えた | blog.berlysia.net](https://blog.berlysia.net/entry/2024-02-14-honox)
- `mdx` https://blog.mooriii.com/entry/honox-ssg-blog

```ts title=vite.config.ts
import { defineConfig } from "vite";
import ssg from "@hono/vite-ssg"; // 追加
import devServer from "@hono/vite-dev-server";

const entry = "src/index.tsx";

export default defineConfig(() => {
  return {
    plugins: [devServer({ entry }), ssg({ entry })], // ssg({entry})を追加
  };
});
```

### user

- https://github.com/typst-jp/typst-jp.github.io
- https://github.com/kamo-shika/blog
- https://github.com/sori883/contentfulBlog
- https://github.com/tkancf/tkancf.com


## blog

- https://suna.dev/articles/honox-blog
- @202402 [Reactをまともに使ったことないエンジニアがBun+HonoでSSGを試してみた #JSX - Qiita](https://qiita.com/mbotsu/items/8d3613e34f013f8e3da4)
- @202402 [個人ブログをNext.jsのSSGからHonoのSSGに移行した](https://zenn.dev/razokulover/articles/9818ef632f677f)

## site
