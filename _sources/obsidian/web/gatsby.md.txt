[[SSG]]

- [The Fastest Frontend for the Headless Web | Gatsby](https://www.gatsbyjs.com/)

- [https://cam-inc.co.jp/p/techblog/634327895480730665](https://cam-inc.co.jp/p/techblog/634327895480730665)
- [静的サイトジェネレーター Gatsby - Qiita](https://qiita.com/umamichi/items/9bd08a21fddc71588efc)

# starter
- blog starter
- mdx

# articles
- [DIRECTORY: ソフトウェア/Gatsby | Ataru Kodaka Site](https://atarukodaka.github.io/software/gatsby)
- @2021 [GatsbyでMDXを使う | Knowledge Swimmer メモ](https://knowledge-swimmer.com/gatsby-mdx)
- @2023 [【GatsbyJS製ブログ】MDXを使えるようにする！あと書き方とか！ | Bear-Fruit](https://bear-fruit.online/how-to-use-mdx/)

# Version
- [Release Notes | Gatsby](https://www.gatsbyjs.com/docs/reference/release-notes/)

## 5
@2022
`Node v18`
- @2022 [v5 Release Notes | Gatsby](https://www.gatsbyjs.com/docs/reference/release-notes/v5.0/)
	- [Migrating from v4 to v5 | Gatsby](https://www.gatsbyjs.com/docs/reference/release-notes/migrating-from-v4-to-v5/)

- @2023 [Gatsby v5 は Cloudflare Pages ではまだ動かない | 高木のブログ](https://takagi.blog/gatsby-v5-does-not-yet-workking-with-cloudflare-pages/)
- @2023 [Gatsby をアップグレード（v4→v5）して Netlify にデプロイ](https://ginneko-atelier.com/blogs/entry519/)
- @2022 [そうだ、ライブラリをアップデートしよう。~ Gatsby v2からv5に上げてみた - Qiita](https://qiita.com/Adacchi3/items/d24380991735f34da92b)
- @2022 [Gatsbyのバージョンをv2からv5にアップデートしました | kyabe.net](https://kyabe.net/blog/update-gatsby-from-v2-to-v5/)
- @2022 [個人ブログで使っているGatsbyのバージョンを4系から5系にあげた | okaryo.log](https://blog.okaryo.io/20221121-raise-version-of-gatsby-in-personal-blog-from-4-to-5)

## 4
- [Migrating from v3 to v4 | Gatsby](https://www.gatsbyjs.com/docs/reference/release-notes/migrating-from-v3-to-v4/)

- @2021 [Gatsby4 - 静的コンテンツジェネレーターを超える](https://www.infoq.com/jp/news/2021/10/gatsby-4/)
`DSG: Deferred Static Generation` 
`SSR: ServerSideRendering`
- @2021 [Gatsby 4 の SSRを触ってみる #craftcms | mersy note](https://note.mersy418.com/article/gatsby4-ssr-craftcms)
- @2021 [Gatsbyをv3からv4へアップデートする](https://zenn.dev/rabbit/articles/403ab8005a8261)
- @2021 [Gatsby アップグレード時にハマりました](https://ginneko-atelier.com/blogs/entry477/)

## 3
- [Gatsby v2からGatsby v3への移行 - makoのノート](https://mako-note.com/ja/migrating-gatsby-from-v2-to-v3/)

# plugins
## gatsby-plugin-mdx
[gatsby-plugin-mdx | Gatsby](https://www.gatsbyjs.com/plugins/gatsby-plugin-mdx/)

## gatsby-source-filesystem
[gatsby-source-filesystem | Gatsby](https://www.gatsbyjs.com/plugins/gatsby-source-filesystem/?=filesystem)

## gatsby-transformer-remark
[gatsby-transformer-remark | Gatsby](https://www.gatsbyjs.com/plugins/gatsby-transformer-remark/)

# gh-pages
- [How Gatsby Works with GitHub Pages | Gatsby](https://www.gatsbyjs.com/docs/how-to/previews-deploys-hosting/how-gatsby-works-with-github-pages/)

# document
- [Quick Start | Gatsby](https://www.gatsbyjs.com/docs/quick-start/)

```
$ npm init gatsby -y
$ cd my-gatsby-site
$ npm run develop
```

```
package.json
gatsby-config.js
README.md
package-lock.json
src/images/icon.png
src/pages/index.js
src/pages/404.js
```

- [Tutorial | Gatsby](https://www.gatsbyjs.com/docs/tutorial/?utm_source=starter&utm_medium=start-page&utm_campaign=minimal-starter)

# gatsby-cli
```shell
npm install -g gatsby-cli
```

## minimum
```sh
cd sampleapp
npm i --save react react-dom gatsby
gatsby develop
```

## starter
[gatsby-starter-blog | Gatsby](https://www.gatsbyjs.com/starters/gatsbyjs/gatsby-starter-blog)

```
npx gatsby new gatsby-starter-blog https://github.com/gatsbyjs/gatsby-starter-blog
```

```
+ package.json
gatsby-node.js
+ gatsby-config.js
static/favicon.ico
static/robots.txt
+ README.md
gatsby-ssr.js
content/blog/my-second-post/index.md
src/images/profile-pic.png
+ src/images/gatsby-icon.png
src/pages/using-typescript.tsx
+ src/pages/index.js
s+ rc/pages/404.js
src/normalize.css
src/templates/blog-post.js
src/style.css
src/components/bio.js
src/components/seo.js
src/components/layout.js
content/blog/hello-world/index.md
content/blog/hello-world/salty_egg.jpg
gatsby-browser.js
LICENSE
+ package-lock.json
content/blog/new-beginnings/index.md
```

## gh-pages
- [GatsbyとGitHub Pagesで作るMarkdownブログ | Blog](https://kanamesasaki.github.io/blog/20220124-gatsby-blog/)

# impl
- [Neovimのstatuslineとtablineを自作した](https://ryota2357.com/blog/2023/nvim-custom-statusline-tabline/)
- [freks blog](https://blog.freks.jp/)
- [Neovim の設定を lspconfig + treesitter ベースにした | blog.ojisan.io](https://blog.ojisan.io/neovim-config/)

