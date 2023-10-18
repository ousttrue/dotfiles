> HTMLの仕様で公式にサポートされている要素と干渉しないように、名前にダッシュを使用する必要があります

```js
class HelloWorld extends HTMLElement {
  // connect component
  connectedCallback() {
    this.textContent = 'Hello World!';
  }
}
customElements.define( 'hello-world', HelloWorld );
```

```html
<script type="module" src="./helloworld.js"></script>
```

# polyfill
- @2023 [【2023 年版】Web Components詳細入門ガイド](https://kinsta.com/jp/blog/web-components/)
- @2019 [Custom Elements Polyfills. Web Components is a great way to create… | by Anand Gupta | Medium](https://medium.com/@anandgupta.08/custom-elements-polyfills-831e7a40d952)
- @2014 [Web Components を支えるPolyfillライブラリ ::ハブろぐ](https://havelog.aho.mu/develop/others/e599-webcomponents_pollyfills.html)
- @2014 [Custom Elements - Web Components を構成する技術](https://blog.agektmr.com/2014/11/custom-elements-web-components.html)
