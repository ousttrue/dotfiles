[[wslg]]
[[Linux]]

# 管理

```
wsl --list --verbose
  NAME               STATE           VERSION
* Arch               Stopped         2
  Ubuntu-CommPrev    Stopped         2
```

## 削除

```
wsl --unregister
```

# install

```
wsl --list --online
インストールできる有効なディストリビューションの一覧を次に示します。
'wsl --install -d <Distro>' を使用してインストールします。

NAME            FRIENDLY NAME
Ubuntu          Ubuntu
Debian          Debian GNU/Linux
kali-linux      Kali Linux Rolling
openSUSE-42     openSUSE Leap 42
SLES-12         SUSE Linux Enterprise Server v12
Ubuntu-16.04    Ubuntu 16.04 LTS
Ubuntu-18.04    Ubuntu 18.04 LTS
Ubuntu-20.04    Ubuntu 20.04 LTS
```

https://docs.microsoft.com/en-us/windows/wsl/install-win10
			https://aka.ms/wslstore
	https://news.mynavi.jp/series/bashonwindows

	#Ubuntu
	#openSUSE
	SLES
	Kali Linux
	Debian GNU/Linux

	[fcitxで作るWSL日本語開発環境 https://qiita.com/dozo/items/97ac6c80f4cd13b84558]
	[Windows Subsystem for Linux + X Windowを1.024倍くらい使いこなすための方法 https://qiita.com/nishemon/items/bb3aca972404f68bfcd6]

[* articles]
	[WSL vs VM for 開発作業 https://qiita.com/satoru_takeuchi/items/a54812806bba0eb48f02]

[* wslconfig]
	https://linuxfan.info/wslconfig
	[マルチWSLディストリビューションを制御するコマンド"wslconfig.exe"を試す https://news.mynavi.jp/article/bashonwindows-59/]

code:cli.bat
 > wslconfig /l
 Windows Subsystem for Linux ディストリビューション:
 openSUSE-42 (既定)



[* WSL-Distribution-Switcher]
	https://news.mynavi.jp/article/bashonwindows-41/

[* API]
	https://qiita.com/noumia/items/0d1d5742ec2104431e92
	https://github.com/noumia/wsl-toyc

WslRegisterDistribution


## ubuntu-21.04
- [How to install Ubuntu 21.10 on WSL for Windows 10 and 11 | Windows Central](https://www.windowscentral.com/how-install-ubuntu-2110-wsl-windows-10-and-11)
