[[css]]

```css
@-moz-document domain("hatenablog.com") {
    /* ここにコードを挿入... */
    div[class="entry-content"] {
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
