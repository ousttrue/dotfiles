[[vnc]]

- [TigerVNC](https://tigervnc.org/)
	- [GitHub - TigerVNC/tigervnc: High performance, multi-platform VNC client and server](https://github.com/TigerVNC/tigervnc)
- [TigerVNC - Gentoo Wiki](https://wiki.gentoo.org/wiki/TigerVNC)
- [TigerVNC - ArchWiki](https://wiki.archlinux.jp/index.php/TigerVNC)

# vncserver
- [TigerVNC のインストール](https://www.rouge.gr.jp/~fuku/tips/tigervnc-1-10/usr_share_doc_tigervnc_HOWTO_md.html)
- [TigerVNC-1.11.0にてvncserver/vncsessionまわりのエラーを調査した話 - Qiita](https://qiita.com/furandon_pig/items/3b04daeb8704f3c27fd2)

```
vncserver: Couldn't find suitable Xsession.
```

# x0vncserver

- ~/.vnc/passwd
- ~/.vnc/xstartup

```
$ x0vncserver -PasswordFile=.vnc/passwd

Fri Dec  2 00:50:09 2022
 XDesktop:    Enabling 8 buttons of X pointer device
 XDesktop:    Allocated shared memory image
 VNCSConnST:  Server default pixel format depth 24 (32bpp) little-endian rgb888
X Error of failed request:  BadMatch (invalid parameter attributes)
  Major opcode of failed request:  139 (RANDR)
  Minor opcode of failed request:  7 (RRSetScreenSize)
  Serial number of failed request:  108
  Current serial number in output stream:  109
```

# x11vnc
- [開発メモ その141 x11vncを使う for Ubuntu and Fedora · A certain engineer "COMPLEX"](https://taktak.jp/2018/10/28/3579/)
