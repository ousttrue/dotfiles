## asset/inline

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
        use: ["style-loader", "css-loader", "sass-loader"],
      },
      {
        test: /\.(png|jpe?g|gif|svg|eot|ttf|woff|woff2)$/i,
        type: "asset/inline",
      },
    ],
  },
};
```

### generator

- https://stackoverflow.com/questions/71000373/specify-mime-type-for-datauri-when-using-webpacks-asset-inldataine

## asset/resource

svg の中の画像ファイル参照を dataUrl 化する列。シンプル構成なら動いたが、docusaurus では・・・

```js
      {
        test: /\.svg$/,
        type: 'asset/resource',
        use: [
          {
            loader: path.resolve('loader.js'),
            options: {
              /* ... */
            },
          },
        ],
      },
```

```js title="loader.js"
import fs from 'node:fs';
import path from 'node:path';

export default function loader(source) {
  source = source.replace(/"([^"]+?\.(png|jpg))"/, (all, unquoted, ext) => {
    const img_path = path.join(this.context, unquoted);
    const img_content = fs.readFileSync(img_path);
    return `"data:image/png;base64,${img_content.toString('base64')}"`;
  });
  return source;
}
```

