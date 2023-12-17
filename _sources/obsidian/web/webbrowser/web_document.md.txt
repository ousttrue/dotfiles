
# event
@2023 [【JS】 DOMContentLoaded と load の違いを新人でもわかるように解説](https://takayamato.com/eventlistener/)

# addEventListener

```js
button.addEventListener("click", () => { console.log("clicked"); });
```

## DOMContentLoaded

```js
document.addEventListener("DOMContentLoaded", (event) => {
  console.log("DOM fully loaded and parsed");
});
```

## loaded

```js
window.addEventListener("load", (event) => {
  console.log("ページが完全に読み込まれました");
});
```

# origin
https://developer.mozilla.org/ja/docs/Web/API/Location/origin

- @2016 [第5回　問題を発生させにくくするURLの扱い方 | gihyo.jp](https://gihyo.jp/dev/serial/01/javascript-security/0005)
