# orphan
- @2013 [github pages みたいに独立したブランチ(Orphan)を作りたいとき | NizLog](https://blog.44uk.net/2013/06/01/git-create-an-orphan-branch/)

- [gitで空ブランチを生成する方法 · GitHub](https://gist.github.com/mugyu/10717929)
```
git checkout --orphan gh-pages
git clean -fdx

echo hello, world > index.html
git add index.html
git commit -m "first page commit"

git push origin gh-pages
```
