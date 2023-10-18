パス構成


> アプリでSDカードや内蔵ストレージにアクセスするには、特殊な権限が必要

# $EXTERNAL_STORAGE=/sdcard

## quest
[[quest]]

`/sdcard/Download` など

だが, local html が読めない
`ERR_ACCESS_DENIED`
https://android.stackexchange.com/questions/57839/error-code-err-access-denied-local-html-file-on-sd-card-with-chrome

- @2021 [Quest２でファイルが参照できない問題の解決法 #Unity - Qiita](https://qiita.com/colllet/items/5ab293c52f4bd4e2ecbb)

このフォルダだけが Open できる。Bookmark はできない。
`file:///sdcard/Android/data/com.oculus.browser/files/Download/home.html`

# App領域?

`/sdcard/Android/data/org.lovr.app/files`
