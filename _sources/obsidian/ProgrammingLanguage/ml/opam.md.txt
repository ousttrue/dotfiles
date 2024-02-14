[[OCaml]]

- [opam - opam](https://opam.ocaml.org/)
- [opam - ocaml.5.0.0](https://opam.ocaml.org/packages/ocaml/ocaml.5.0.0/)

- @2019 [OPAM、OCaml をアップデートする - ryskosn log](https://ryskosn.hatenadiary.com/entry/2019/03/21/181524)

# Version
## 2.2.0 alpha
- @2023 [opam - Platform Blog](https://opam.ocaml.org/blog/opam-2-2-0-alpha2/)

## 2.1.5

# Windows

`%LOCALAPPDATA%\Local\opam`

```pwsh
opam switch list-available
opam init
(& opam env) -split '\r?\n' | ForEach-Object { Invoke-Expression $_ }
```

# build
- [Releases · ocaml/opam](https://github.com/ocaml/opam/releases)

- msys-make 使う
```
cp -i windres.exe x86_64-w64-mingw32-windres.exe
configure CC64=x86_64-w64-mingw32-gcc
make cold CONFIGURE_ARGS="--prefix ~/local" # => bootstrap/ocaml/bin

env 
	MAKE=$(MAKE) 
	BOOTSTRAP_EXTRA_OPTS= 
	BOOTSTRAP_TARGETS=world.opt 
	BOOTSTRAP_ROOT=.. 
	BOOTSTRAP_DIR=bootstrap 
	./shell/bootstrap-ocaml.sh auto


make cold-install => install
```

## ocaml exists

```
# dune回避？
./configure --without-dune --with-vendored-deps
```

### required
- pacman -S flexdll
- copy flexdll.h from soruce
- libtool
	- [autogen.shなどでautoconfがundefined macroなエラーを出した時の対処法](https://rcmdnk.com/blog/2017/04/03/computer-linux/)

- OCAMLLIB
- dllunix.dll

# mingw
- [OCaml for Windows - OCaml for Windows](https://fdopen.github.io/opam-repository-mingw/)
>  The repository will be discontinued as of August 2021

# windows
`%LOCALAPPDATA%/Programs/DISKUV~1`
- [OCaml on Windows · OCaml Tutorials](https://ocaml.org/docs/ocaml-on-windows)
- @2018 [OcamlをWindowsにインストールする - Qiita](https://qiita.com/angeart/items/ba9721245558781e30d4)
- @2017 [OCamlをWindowsにインストールする方法 - Haskell勉強会](https://haskell.hatenablog.com/entry/How-to-install-OCaml-on-Windows)
[Releases · diskuv/dkml-installer-ocaml](https://github.com/diskuv/dkml-installer-ocaml/releases)
- [Release v1.1.0_r2 · diskuv/dkml-installer-ocaml · GitHub](https://github.com/diskuv/dkml-installer-ocaml/releases/tag/v1.1.0_r2)
- [Getting Started with Diskuv OCaml — Diskuv OCaml 1.1.0 documentation](https://diskuv-ocaml.gitlab.io/distributions/dkml/)
- [GitHub - diskuv/dkml-installer-ocaml: The Windows-friendly distribution of OCaml](https://github.com/diskuv/dkml-installer-ocaml#readme)

# ocaml

```
> opam switch list-available
```

# language-server
[GitHub - ocaml/ocaml-lsp: OCaml Language Server Protocol implementation](https://github.com/ocaml/ocaml-lsp)

```
> opam install ocaml-lsp-server
```

# msys
`prebuilt 2.0.10`
- [GitHub - fdopen/opam-repository-mingw: windows package repository for OPAM (mingw and msvc)](https://github.com/fdopen/opam-repository-mingw)
- [OCaml on MSYS2 · GitHub](https://gist.github.com/mnxn/93009346c1bd56f387daf28413152179)

