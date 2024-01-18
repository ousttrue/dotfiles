[行終端を処理するようGitを設定する - GitHub Docs](https://docs.github.com/ja/get-started/getting-started-with-git/configuring-git-to-handle-line-endings)

[git - What is the purpose of `text=auto` in `.gitattributes` file? - Stack Overflow](https://stackoverflow.com/questions/21472971/what-is-the-purpose-of-text-auto-in-gitattributes-file)
- @2013 [.gitattributesのeol=crlfは改行コードをCRLFに変換してチェックインするものではない - エンジニア的考察ブログ](https://chryfopp.hatenablog.com/entry/2013/04/13/113754)

# .gitattributes

```git
*           text=auto
*.txt       text
*.bat       text eol=crlf
*.php       text eol=crlf
*.js        text eol=lf
*.jpg    binary
*.png    binary
*.gif    binary
*.mp4    binary
```

## CRLF

```
* text=auto eol=lf

```

## renormalize

- @2020 `renormlaize` [git に登録済みのファイルの改行コードを正規化する #Git - Qiita](https://qiita.com/m-tmatma/items/cfff9f2c60a26fde802d)
- @2022 [リポジトリで改行コードを正規化する](https://zenn.dev/murnana/articles/eol-and-gitattributes)

