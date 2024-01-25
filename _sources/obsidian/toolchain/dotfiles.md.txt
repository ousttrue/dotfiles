- [Comparison table - chezmoi](https://www.chezmoi.io/comparison-table/)

|env    |pwsh|bash|lua|luajit|nvim|
|-------|----|----|---|------|----|
|windows| O  |    | O | O    | O  |
|msys2  |    | O  | O |      | O  |
|wsl    | O  | O  | O | O    | O  |
|Linux  | O  | O  | O | O    | O  |
|OSX    | O  | O  | O | O    | O  |

# dotfiles 展開する前の最低限環境

- inputrc(c-n, c-p)
```
"\C-n": history-search-forward
"\C-p": history-search-backward
```

- EDITOR=vim visudo
```
USER    ALL=(ALL:ALL) NOPASSWD: ALL
```

- sudo vim /etc/wsl.conf
```
[interop]
appendWindowsPath = false
```

`/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/snap/bin`

```sh title="~/.bashrc"
PS1='\w\$ '
_termtitle="[WSL]"
PS1="\[\e]0;${_termtitle}\007\]${PS1}"
```

# pwsh

```sh
sudo apt install dotnet7
dotnet tool install --global PowerShell
```
