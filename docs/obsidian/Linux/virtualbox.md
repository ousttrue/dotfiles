virtualbox
	 https://www.virtualbox.org/

#gentoo

[* VboxVMService]
	http://vboxvmservice.sourceforge.net/
	[VirtualBoxをWindows上のサービスとして設定していろいろ調整 https://www.civic-apps.com/2013/03/18/virtualbox-service/]

code:VBoxVmService.ini
	[Vm0]
	VmName=Gentoo
	ShutdownMethod=savestate
	AutoStart=yes 

としてサービスのユーザーを設定する。

[** Host]
[* Windows]
 https://tamosblog.wordpress.com/2016/03/11/windows_10_dev/
`Failed to open/create the internal network 'HostInterfaceNetworking-VirtualBox Host-Only Ethernet Adapter' (VERR_INTNET_FLT_IF_NOT_FOUND).  Failed to attach the network LUN (VERR_INTNET_FLT_IF_NOT_FOUND).  Result Code: E_FAIL (0x80004005)`

	https://www.virtualbox.org/ticket/14832

[** Guest]
[* Gentoo]
 https://wiki.gentoo.org/wiki/VirtualBox#Gentoo_guests

[* BIOS]
 F12



[** network]
- https://www.virtualbox.org/manual/ch06.html

[* nat]
guestから外にアクセスできる。
portforwardを設定することでguestにアクセスできる。

[* NAT Network]
複数のguest同士でアクセスできる

[* Bridged networking]
hostのNICを通してサーバーを建てられる(IPは？)

[* Host-only networking]
Host内に仮想ネットワークを作成する(設定がある)。
中で固定IPを振る運用ができる。
アダプター1を"NAT"、アダプター2を"ホストオンリーアダプター"に設定する。

[** raw disk]
 https://www.virtualbox.org/manual/ch09.html#rawdisk

[** articles]
 http://hrn25.sakura.ne.jp/win/virtualbox-rawdisk/virtualbox-rawdisk.html
 [Windons7のVirtualBoxでデュアルブート用のraw partitionにあるLinuxを起動させる http://blog.daionet.gr.jp/knok/2012/08/26/windons7%E3%81%AEvirtualbox%E3%81%A7%E3%83%87%E3%83%A5%E3%82%A2%E3%83%AB%E3%83%96%E3%83%BC%E3%83%88%E7%94%A8%E3%81%AEraw-partition%E3%81%AB%E3%81%82%E3%82%8Blinux%E3%82%92%E8%B5%B7%E5%8B%95%E3%81%95/]

[** Guest Additions]

[* シームレスモード]
 http://d.hatena.ne.jp/yohei-a/20131005/1380991246
