- [Zsh](https://www.zsh.org/)
- [Zsh - ArchWiki](https://wiki.archlinux.jp/index.php/Zsh)

- @2014 [zshの設定ファイルの読み込み順序と使い方Tipsまとめ - Qiita](https://qiita.com/muran001/items/7b104d33f5ea3f75353f)
- [macOS の zsh ではこれだけはやっておこう](https://zenn.dev/sprout2000/articles/bd1fac2f3f83bc)

# Version
## 5.9

# scripting
.zshrc
.zprofile
.zshenv
`man zshmisc`

## prompt
- @2023 [高機能なZshプロンプトを自作する ーモダンなシェルプロンプトを構成する工夫ー - エムスリーテックブログ](https://www.m3tech.blog/entry/modern-zsh-prompt)
- @2022 [zshプロンプトをカスタマイズする](https://ryota2357.com/blog/2022/zsh-prompt-custom/)
- @2021 [zshプロンプトをカスタマイズ、色と改行とgit対応で見やすくする【Mac】 | プロガジ.DEV](https://dev.macha795.com/zsh-prompt-customize/)
- [自作Zshプロンプトを非同期対応した - 茅の下](https://ryooooooga.hateblo.jp/entry/async-prompt)
### git
- [git statusを利用したリポジトリ情報のプロンプト表示 - GeekFactory](https://int128.hatenablog.com/entry/2015/07/15/003851)

## 関数
## variable
- [zsh 設定 - プロンプト -](https://tegetegekibaru.blogspot.com/2012/08/zsh_2.html)

```sh
local x=""
${x}
```
## color
- [zshでプロンプトをカラー表示する - Qiita](https://qiita.com/mollifier/items/40d57e1da1b325903659#%E6%96%B9%E6%B3%951%E3%81%A8%E6%96%B9%E6%B3%952%E3%81%AE%E9%81%95%E3%81%84)
`%F{color}~~~%f`
```sh
%F{magenta}${MSYSTEM}%f
```
## escape
`%{~~~%}`
```sh
local title_s=$'\e]0;'
local title_e=$'\a'
%{${title_s}%}TITLE%{${title_e}%}
```

# package
- [GitHub - agkozak/zsh-z: Jump quickly to directories that you have visited "frecently." A native Zsh port of z.sh with added features.](https://github.com/agkozak/zsh-z)

## zplug
- [GitHub - zplug/zplug: :hibiscus: A next-generation plugin manager for zsh](https://github.com/zplug/zplug)
- @2021 [[☆4840] 快適、zplugでzshプラグイン管理](https://zenn.dev/kenghaya/articles/29c0c6d5902e1a)
- [Web系だけど.zshrc晒す - Qiita](https://qiita.com/Hibikine_Kage/items/61711d5e3d3d5f572f9f)

# zpty
