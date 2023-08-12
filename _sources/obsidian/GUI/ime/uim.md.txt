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
`make-wc.h`
## sigschme
[[scheme]]

# X11
[[XWindow|X11]]

```sh
# UIM~GTK
# UIM~QT
export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'

# X11~UIM
uim-xim &
export XMODIFIERS='@im=uim'
```

# uim-fep
- [uim/fep/README.ja at master · uim/uim · GitHub](https://github.com/uim/uim/blob/master/fep/README.ja)

- @2022 [fbtermの日本語表示．uim-fepとuim-anthyで日本語入力も．ついでに，vimの256色化も - Qiita](https://qiita.com/Pseudonym/items/12e447557a5234bb265b)
- @2017 [uim-fepとuim-anthyの使い方と設定方法 - Qiita](https://qiita.com/Pseudonym/items/9ff0e9028dfd6bad5958)
- @2013 [uim-fepのキーバインドを変更 : mswinvksの忘備録](http://blog.livedoor.jp/mswinvks/archives/8188782.html)

> uim自体はいれなくていいので．
```
sudo apt install uim-fep
sudo apt install uim-anthy
```

# customize
- @2014 [uimの設定ってSchemeで書けるのね。あるいはuim-skkでz＋スペースで全角スペースを入力する方法 - セカイ内存在証明](https://makenowjust.hatenablog.com/entry/2014/08/10/233424)
