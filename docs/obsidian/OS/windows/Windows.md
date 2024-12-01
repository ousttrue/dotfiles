- [MyWindowsCustomization.md · GitHub](https://gist.github.com/sheepla/e5cf901223554426d420ce42cd34b964)
- [Windowsカスタマイズシリーズ](http://tatsu.life.coocan.jp/MySoft/WinCust/index.html)

- [komorebiを導入してみる](https://zenn.dev/omochice/articles/50f42a3df8f426)

# Version
## 1803
Windows 10 April 2018 Update (1803) 

# Customize
# init
- chrome
	- golang
	- [Ctrl2cap - Sysinternals | Microsoft Learn](https://learn.microsoft.com/ja-jp/sysinternals/downloads/ctrl2cap)
	- 7zip
	- git for windows
	- python 
		- doit
- allow: symbolic link
- context menu
```bat
reg add HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /f /ve
```
- wacom tablet
	- off windows ink
- wezterm
- nyagos
- LUA_PATH
- XDG_CONFIG_HOME
[[xdg]]
- compiler: msvc19

## powertoys

## busybox
[[busybox]]

# env init

```sh
>set
ALLUSERSPROFILE=C:\ProgramData
APPDATA=C:\Users\${USERNAME}\AppData\Roaming
ComSpec=C:\WINDOWS\system32\cmd.exe
DriverData=C:\Windows\System32\Drivers\DriverData
HOMEDRIVE=C:
HOMEPATH=\Users\${USERNAME}
LOCALAPPDATA=C:\Users\${USERNAME}\AppData\Local
OS=Windows_NT
Path=C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Users\${USERNAME}\AppData\Local\Microsoft\WindowsApps
PATHEXT=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC;.CPL
ProgramData=C:\ProgramData
ProgramFiles=C:\Program Files
ProgramFiles(x86)=C:\Program Files (x86)
ProgramW6432=C:\Program Files
PROMPT=$P$G
PSModulePath=C:\Users\${USERNAME}\Documents\WindowsPowerShell\Modules;C:\Program Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules
PUBLIC=C:\Users\Public
SystemDrive=C:
SystemRoot=C:\WINDOWS
TEMP=C:\Users\${USERNAME}\AppData\Local\Temp
TMP=C:\Users\${USERNAME}\AppData\Local\Temp
USERNAME=${USERNAME}
USERPROFILE=C:\Users\${USERNAME}
windir=C:\WINDOWS
```

# right menu

```sh
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
```
