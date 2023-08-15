# Version 
## 5
- @2019 [bash 5.0がリリースされた話 - Qiita](https://qiita.com/ryuichi1208/items/9f0b42517a51ccd34243)
- @2019 [「GNU Bash 5.0」リリース、10年ぶりのメジャーバージョンアップ － Publickey](https://www.publickey1.jp/blog/19/gnu_bash_5010.html)

## 4.4
## 4.2


# prompt
[[NerdFont]]
- @2020 [bashプロンプトの表示をNerdfontsで格好良くする - Qiita](https://qiita.com/GunseiKPaseri/items/e594c8e261905e3d0281)
- [Bash Prompt HOWTO](https://linuxjf.osdn.jp/JFdocs/Bash-Prompt-HOWTO.html#toc2)

Ubuntus-20.04 LTS
title + prompt
```sh
\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$
```

- @2021 [bashのプロンプト表示形式を設定する方法](https://zenn.dev/memo/articles/20211004_ps1)

## PS1

## PROMPT_COMMAND

# git-prompt

```sh
if [ -e /etc/bash_completion.d/git-prompt ]; then
    source /etc/bash_completion.d/git-prompt
	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_SHOWSTASHSTATE=true
	GIT_PS1_SHOWUNTRACKEDFILES=true
	GIT_PS1_SHOWUPSTREAM="auto"
	GIT_PS1_SHOWCOLORHINTS=true
fi
```

# completion
- [bashコマンド補完を自作する bash-completion,complete,compgen - やってみる](https://ytyaru.hatenablog.com/entry/2023/01/09/000000)
- [重大な脆弱性(CVE-2017-5932)で少し話題になったbash4.4の補完機能の便利な点 - Qiita](https://qiita.com/tajima_taso/items/a85dbe8ec9a2825973e2)

# language-server
- [GitHub - bash-lsp/bash-language-server: A language server for Bash](https://github.com/bash-lsp/bash-language-server)

# formatter
- shfmt
- [Shell のコーディングに便利な shellcheck/shfmt の紹介｜NAVITIME_Tech](https://note.com/navitime_tech/n/n0675e103bafa)

# script
## comparison

