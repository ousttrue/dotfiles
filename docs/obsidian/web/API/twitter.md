# 検索除外
## user
`検索したいワード OR 存在しないユーザー名`

`雪 OR @00aazz11bbyy22`

## replay
`-filter:replies`


# stylus

```css
@-moz-document url-prefix("https://twitter.com/") {
    /* ここにコードを挿入... */
    div[aria-label="タイムライン: トレンド"] { 
        display:none; 
    }

    div[data-testid="placementTracking"] {
        display:none;    
    }
    
    div[aria-label*="いいね"] {
        display:none;    
    }
    
}
```

```css
@-moz-document domain("twitter.com") {
    /* ここにコードを挿入... */
    div[aria-label="Timeline: Trending now"]{
        display: none;
    }
}
```
