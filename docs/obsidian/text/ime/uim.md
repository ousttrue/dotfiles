`Utena`
[[ime]]
[[immodule]]

- [GitHub - uim/uim: A multilingual input method framework](https://github.com/uim/uim)
- [Uim を使って日本語を入力 - ArchWiki](https://wiki.archlinux.jp/index.php/Uim_%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%82%92%E5%85%A5%E5%8A%9B)
- @2009 [第99回　uimを使用する | gihyo.jp](https://gihyo.jp/admin/serial/01/ubuntu-recipe/0099)

# Version
## 1.8.9
@2022

# build
```sh
# make work copy
./make-wc.sh $"--prefix=($env.HOME)/usr/local"
```

## sigschme
[[scheme]]

# customize
- @2014 [uimの設定ってSchemeで書けるのね。あるいはuim-skkでz＋スペースで全角スペースを入力する方法 - セカイ内存在証明](https://makenowjust.hatenablog.com/entry/2014/08/10/233424)

# ime
## skk
[[skk]]

- [uim-skk - アールメカブ](http://rmecab.jp/wiki/index.php?uim-skk)
- [私は Ubuntu 22.04 で tcsh で uim-skk な環境を使いたいの！](https://zenn.dev/kusaremkn/articles/1be27b768db4f5)
- [Google Code Archive - Long-term storage for Google Code Project Hosting.](https://code.google.com/archive/p/uim-doc-ja/wikis/UimSkk.wiki)

| 動作 | キー | 
|:---|:---| 
| 直接/全角英数字入力モードからひらがな入力モードへ移行 | 全角/半角、Shift+Space、Ctrl+j |
| ひらがな/カタカナ/半角カタカナ入力モードから直接入力モードへ移行 | 全角/半角、Shift+Space、l |
| ひらがな/カタカナ入力モードを反転移行 | q |
| ひらがな/カタカナ入力モードから半角カタカナ入力モードへ移行 | Ctrl+q |
| 半角カタカナ入力モードからひらがな入力モードへ移行 | q |
| ひらがな/カタカナ/半角カタカナ入力モードから全角英数字入力モードへ移行 | L | | ひらがな/カタカナ/半角カタカナ入力モードから漢字入力モードへ移行 | Q |
| 漢字コード入力 | \ |
| カーソルを右へ移動 | →、Ctrl+f |
| カーソルを左へ移動 | ←、Ctrl+b |
| カーソルの左の一字を削除 | BS、Ctrl+h |
| 変換開始 | Space |
| 次の候補へ移動 | Space、↓、Ctrl+n |
| 前の候補へ移動 | ↑、Ctrl+p、x |
| 次の変換候補ページへ移動 | Space、↓、Ctrl+n、PgDn |
| 前の変換候補ページへ移動 | ↑、Ctrl+p、x、PgUp |
| 変換確定 | Ctrl+m、Ctrl+j |
| 変換確定+改行 | Return |
| 候補ウィンドウから変換候補を選択し確定 | a、s、d、f、g、h、j、k、l |
| キャンセル | Esc、Ctrl+`[`、Ctrl+g |
| ひらがな/カタカナを反転変換し確定 | q |
| ひらがな/カタカナを半角カタカナとして確定 | Ctrl+q |
| ひらがな/カタカナ/半角カタカナ入力モードでアルファベット変換開始 | / |
| アルファベット変換中に全角英数字として確定 | Ctrl+q |
| アルファベット変換中に大文字/小文字を反転変換し確定 | Ctrl+u |
| 編集領域を補完 | Tab、Ctrl+i、Alt+Tab、Ctrl+Alt+i |
| 次の補完候補へ移動 | .、Tab、Ctrl+i、Alt+Tab、Ctrl+Alt+i |
| 前の補完候補へ移動 | , |
| 補完候補から新規に補完 | Alt+Tab、Ctrl+Alt+i |
| 接頭辞/接尾辞入力 | >、<、? |
| 個人辞書中の単語を削除 | X |

- AZIK拡張ローマ字入力方式
- ACT拡張ローマ字入力方式
- KZIK拡張ローマ字入力方式

## anthy
- [mousehouse - Weblog: mlterm + vim + uimでうれしいvim環境](http://jody.sci.hokudai.ac.jp/~ike/blog/2007/05/mlterm_vim_uimvim.html)
- [uim-fep - Qiita](https://qiita.com/tukiyo3/items/376e3a2895a71ff9bfc7)

# forntend
## X11
[[OS/X11/X11|X11]]

```sh
# UIM~GTK
# UIM~QT
export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'

# X11~UIM
uim-xim &
export XMODIFIERS='@im=uim'
```


## uim-fep
- [uim/fep/README.ja at master · uim/uim · GitHub](https://github.com/uim/uim/blob/master/fep/README.ja)

- @2022 [fbtermの日本語表示．uim-fepとuim-anthyで日本語入力も．ついでに，vimの256色化も - Qiita](https://qiita.com/Pseudonym/items/12e447557a5234bb265b)
- @2017 [uim-fepとuim-anthyの使い方と設定方法 - Qiita](https://qiita.com/Pseudonym/items/9ff0e9028dfd6bad5958)

> uim自体はいれなくていいので．
```
sudo apt install uim-fep
sudo apt install uim-anthy
```

### keybinding
- @2013 [uim-fepのキーバインドを変更 : mswinvksの忘備録](http://blog.livedoor.jp/mswinvks/archives/8188782.html)
