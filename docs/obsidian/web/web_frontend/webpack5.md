# version

## 5

- @2023 [Webpack 5ガイド「アセットモジュール」｜stein2nd](https://note.com/stein2nd/n/n7502b20a3f4f)
- @2021 [webpack 5からurl-loader/file-loader/raw-loaderが要らなくなった #JavaScript - Qiita](https://qiita.com/Tsukina_7mochi/items/e031f12a122e05ff8d87)

# docusaurus

- https://dwf.dev/blog/2022/11/12/2022/updating-docusaurus-webpack-config

# generator

- https://stackoverflow.com/questions/71000373/specify-mime-type-for-datauri-when-using-webpacks-asset-inldataine

# sass の中の画像を data にする

- @2021 [webpackでSassファイル内の画像をバンドルする | cly7796.net](https://cly7796.net/blog/javascript/bundle-images-in-sass-with-webpack/)

```sass
html {
  background: url(cat.jpg);

  &:after {
    content: '';
    display: block;
    width: 30px;
    height: 22px;
    background: url(mail.png); /* 👈 */
  }
}
```

```js
module.exports = {
  mode: "production",
  module: {
    rules: [
      {
        test: /\.s[ac]ss$/i,
        use: [
          "style-loader",
          "css-loader",
          "sass-loader"
        ]
      },
      {
        test: /\.(png|jpe?g|gif|svg|eot|ttf|woff|woff2)$/i,
        type: "asset/inline"
      }
    ]
  }
};
```
