
開発環境案
```
[Docker]language server
👆
[Docker]editor toolchain Shell
👆
[Dokcer/git maintenance]ProjectFolder MultiPlexer Shell
👆
[Local]term
👆             👇
[Local]keyboard visualize
```

# plan
- git
- wezterm
- golang
	- build nyagos
	- symbolic link
- aqua
	- fzf, ghq...
- python3
	- pip install zig ninja cmake
	- build luajit gettext iconv
	- build neovim 
	- luarocks
	- [Using Neovim as Lua interpreter with Luarocks](https://zignar.net/2023/01/21/using-luarocks-as-lua-interpreter-with-luarocks/)

# windows

- llvm-mingw
- golang
- python
	- cmake
	- ninja
- aqua
	- stylua
       - neovim

`%USERPROFILE%/build/llvm-mingw`
に構築
- luajit
- gettext
- iconv
- neovim
- lua language server

- gtk
	- gst

# docker

formatter と language server ? 
