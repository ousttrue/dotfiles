`from` [[Next.js]] 9.3

- @2021 [ブログ詳細編(getStaticPropsとgetStaticPathsについて理解する)｜UnBlog](https://unblog.unreact.jp/blog/cdic_vz1_i5)
- @2020 [Next.js 9.3新API getStaticProps と getStaticPaths と getServerSideProps の概要解説 #React - Qiita](https://qiita.com/matamatanot/items/1735984f40540b8bdf91)

# getInitialProps
React component が自前で props を作る感じ。
これを static にしたものが👇

# getStaticProps
`pre-rendering` 時の情報集め

dev => 都度
build => まとめて

```js
export const getStaticPaths: GetStaticPaths = async () => {
  //blogのデータ全部くれ
  const data: Data = await client.get({ endpoint: "blog" });
  //アクセスしうるページのパスの入ったオブジェクトの配列としてまとめておく
  const pathList = data.contents.map((Blog) => {
    return {
      params: {
        id: Blog.id,
      },
    };
  });

  return {
    paths: pathList,
    //アクセスしうるパス以外のパスに対するアクセスの対処
    fallback: false,
  };
};
```

# dynamicRouting
> pagesフォルダ内でファイル名にブラケット[]をつけるとダイナミックルーティングが有効になります。

## getStaticPaths
ビルド時に list を返す


# ContentLayer
- @2023 [Contentlayer で Next.js の SSG 向けデータを管理する体験はなかなかよい - koudenpaのブログ](https://koudenpa.hatenablog.com/entry/2023/09/22/211112)
- @2023 [Contentlayer で記事を markdown 管理する](https://zenn.dev/you_5805/articles/contentlayer)
- @2023 [個人ブログ開発でとても便利な Contentlayer を導入してみた | stin's Blog](https://blog.stin.ink/articles/introduce-contentlayer#contentlayer-%E3%81%A8%E3%81%AF)

ContentLayer => GetStaticPaths
- @2022 [contentlayer でらくらく Markdown ブログサイト構築 | なつねこメモ](https://www.natsuneko.blog/entry/2022/02/20/create-markdown-blog-site-with-contentlayer)
