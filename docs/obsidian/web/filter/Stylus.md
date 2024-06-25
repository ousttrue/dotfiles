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
div[aria-label="トレンド"]{
    display: none;
}
header[role="banner"] {
    display: none;
}
div[aria-label="ホームタイムライン"]{
    width: 100vw;
    background: white;
}
```
