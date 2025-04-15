[[css]]

# UserCSS
- [GitHub - openstyles/stylus: Stylus - Userstyles Manager](https://github.com/openstyles/stylus)
- [UserCSS · openstyles/stylus Wiki · GitHub](https://github.com/openstyles/stylus/wiki/Usercss)
- [Editor · openstyles/stylus Wiki · GitHub](https://github.com/openstyles/stylus/wiki/Editor#usercss-mode)

```css
[class*="sleeping-ad"] {
    display: none;
    width: 0;
    height: 0;
    overflow: hidden;
}
```

```css
@-moz-document domain("hatenablog.com") {
    /* ここにコードを挿入... */
    /*div[class="entry-content"] {*/
    div.entry-content {
        display: none;
    }
    article[class*="sleeping-ads"] div[class="entry-inner"] {
        display: none;
    }
    div > iframe {
        display: none;
    }
}
```

```css
x {
	float: left;
	width: 0;
	height: 0;
	padding-top: 1000em;
	margin-top: 1000em;
}
```

# X

```css
div[aria-label="トレンド"] {
    display: none;
}
header[role="banner"] {
    display: none;
}
div[aria-label="ホームタイムライン"] {
    width: 100vw;
    max-width: 700px;
    margin-left: calc(100vw * 1 / 2 - 700px * 1 / 2);
    margin-right: calc(100vw * 1 / 2 - 700px * 1 / 2);
    background: black;
}
```

# GoogleAI

```css
div :has(> div> div > div > div > div > div > strong) {
/*     AI による概要 */
    display: none;
}
div :has(> srpx-bugfix) {
/*     関連する質問 */
    display: none;

}
```

# iframe

```css
div:has(> div > iframe) {
    display: none;
}
```
