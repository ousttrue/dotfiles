`from` [[Next.js]] 9.3
[[ContentLayer]]

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


# impl
- @2022 [自作フレームワークに静的サイトジェネレータを組み込んだ](https://zenn.dev/yukikurage/articles/367d844d79de20)

## minista
[[minista]]