#
# sync/HOME/.local/share/powershell/Modules
#
$ErrorActionPreference = "Stop"
#
# clear alias
#
Remove-Item alias:* -force
Set-Alias cd Set-Location
Set-Alias pwd Get-Location
Set-Alias echo Write-Output
Set-Alias % ForEach-Object
Set-Alias ? Where-Object

Set-alias vswhere "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe"

$NVIM_PREFIX = Join-Path $HOME "neovim"
Set-Alias v (Join-Path $NVIM_PREFIX "\bin\nvim")

$env:_CL_ = "/utf-8"
$env:XDG_CONFIG_HOME = "$HOME/.config"
if($IsWindows)
{
  $env:PSModulePath = "$HOME\.local\share\powershell\Modules;${env:PSModulePath}" 
  Set-Alias winget (Join-Path $env:LOCALAPPDATA "Microsoft\WindowsApps\winget.exe")
  Set-Alias nu (Join-Path $env:LOCALAPPDATA "Programs\nu\bin\nu.exe")
}

# dirs
if ($IsWindows)
{
  $shada_dir = (Join-Path ${env:LOCALAPPDATA} "\nvim-data\shada") 
} else
{
  $shada_dir = (Join-Path ${env:HOME} ".local/state/nvim/shada") 
}
$dot_dir = Join-Path $HOME "dotfiles"
$dot_sync_dir = Join-Path $dot_dir "sync/HOME"
$dot_sync_app_dir = Join-Path $dot_dir "sync/APPDATA"
$module_dir = Join-Path $dot_dir "psmodule\mymodule" 
$unity_gitignore_url = "https://raw.githubusercontent.com/github/gitignore/refs/heads/main/Unity.gitignore"

$dll_path = Join-Path $module_dir "bin\Debug\net8.0\mymodule.dll"
if (!(Test-Path $dll_path))
{
  Push-Location $module_dir
  dotnet build
  Pop-Location
}
Add-Type -Path $dll_path
# Get-TYpes mymodule.Dependency

#
# platform
#
if ($IsWindows)
{
  chcp 65001
  $env:HOME = $env:USERPROFILE

  $EXE = ".exe"
  $defs = @(
    [mymodule.Dependency]::new(
      "nvim", 
      "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.zip",
      "nvim-win64/bin/nvim.exe")
  )
} else
{
  $EXE = ""
}

$SEP = [System.IO.Path]::DirectorySeparatorChar
$env:FZF_DEFAULT_OPTS = "--layout=reverse --preview-window down:70%"
$env:LUA_PATH = "${HOME}${SEP}lua${SEP}?.lua;${HOME}${SEP}lua${SEP}?${SEP}init.lua"

function has($cmdname)
{
  try
  {
    # CmdletInfo | ApplicationInfo | AliasInfo | FunctionInfo
    switch (Get-Command $cmdname -ErrorAction Stop)
    {
      { $_ -is [System.Management.Automation.AliasInfo] }
      {
        $_.Definition
      }
      { $_ -is [System.Management.Automation.ApplicationInfo] }
      {
        $_.Definition
      }
      { $_ -is [System.Management.Automation.CmdletInfo] }
      {
        $_
      }
      { $_ -is [System.Management.Automation.FunctionInfo] }
      {
        $_
      }
      default
      {
        $_.GetType()
      }
    }
  } catch
  {
    return $false;
  }
}
if (!(has 'which'))
{
  Set-Alias which has
}
if (has ghq)
{
  $GHQ_ROOT = (Get-Item (ghq root))
}
if(has ov)
{
  $env:PAGER="ov"
}

#
# path
#
function insertPath($path)
{
  if (-not $env:PATH.Contains($path))
  {
    $env:PATH = $path + [System.IO.Path]::PathSeparator + $env:PATH
    $path
  } else
  {
    $null
  }
}
#
function addPath($path)
{
  if (-not $env:PATH.Contains($path))
  {
    $env:PATH = $env:PATH + [System.IO.Path]::PathSeparator + $path
    $path
  } else
  {
    $null
  }
}

function Get-Python
{
  $pyenv_py = Join-Path $HOME ".pyenv/shims/python"
  if(Test-Path $pyenv_py)
  {
    Join-Path $HOME ".pyenv/shims"
  } elseif($IsWindows)
  {
    py -c "import sys; print(sys.base_prefix)"
  } elseif(has python)
  {
    python -c "import sys; print(sys.base_prefix)"
  } elseif(has python3)
  {
    python3 -c "import sys; print(sys.base_prefix)"
  }
}

addPath(Join-Path $HOME "\ghq\github.com\junegunn\fzf\bin")
addPath(Join-Path $HOME "\.fzf\bin")
addPath(Join-Path $HOME "\.deno\bin")
addPath(Join-Path $HOME "\.cargo\bin")
addPath(Join-Path $HOME "\go\bin")
addPath(Join-Path $HOME "\gtk\bin")
addPath(Join-Path $HOME "\.local\bin")
addPath(Join-Path $HOME "\zig")
insertPath(Join-Path $HOME "\local\bin")
if ($IsWindows)
{
  addPath("C:\Program Files\qemu")
  addPath('C:\Program Files\Erlang OTP\bin')
} else
{
  addPath("/usr/local/go/bin")
}
if ($IsMacOS)
{
  addPath("/opt/homebrew/bin")
}
addPath(join-Path $HOME '/Downloads/Visual Studio Code.app/Contents/Resources/app/bin')

# if (has py)
# {
$PY_PREFIX = Get-Python
insertPath($PY_PREFIX)
insertPath(Join-Path $PY_PREFIX "Scripts")
# }

if ($IsMacOS)
{
  $env:N_PREFIX = (Join-Path $env:HOME "/.n")
  addPath(Join-Path $env:N_PREFIX "/bin")
}

if($null -eq $env:JAVA_HOME)
{
  $jbr_dir = "C:\java\jbr_jcef-17.0.10-windows-x64-b1207.14"
  if(Test-Path $jbr_dir)
  {
    $env:JAVA_HOME = $jbr_dir
    addPath (Join-Path $jbr_dir "bin")
  }
}

# For zoxide v0.8.0+
if (has zoxide)
{
  Invoke-Expression (& {
      $hook = if ($PSVersionTable.PSVersion.Major -lt 6)
      {
        'prompt' 
      } else
      {
        'pwd' 
      }
    (zoxide init --hook $hook powershell | Out-String)
    })
}

# cd ghq
function gg
{
  $dst = $(ghq list -p | fzf --reverse +m --preview "bat --color=always --style=header,grid --line-range :100 {}/README.md")
  if ($dst)
  {
    Set-Location "$dst"
  }
}
function grm
{
  $dst = $(ghq list -p | fzf --reverse +m --preview "bat --color=always --style=header,grid {}/README.md")
  if ($dst)
  {
    $parent = (Split-Path -Parent $dst)
    "remove : ${dst}" | Out-Host 
    Remove-Item -Recurse -Force $dst
    if (!(Get-ChildItem $parent))
    {
      # empty
      "remove parent: ${parent}" | Out-Host 
      Remove-Item -Recurse -Force $parent
    }
  }
}
function vv
{
  $dst = $(ghq list -p | fzf --reverse +m)
  if ($dst)
  {
    Set-Location "$dst"
    git pull
    nvim
  }
}

# git switch
function gs
{
  $dst = $(git branch | fzf)
  if ($dst)
  {
    git switch $args $dst.Trim()
  }
}
# git switch remote
function gsr
{
  $dst = $(git branch -r | fzf)
  if ($dst)
  {
    git switch -c $dst.Trim() $dst.Trim()
  }
}

function git_rm_merged
{
  git branch --merged
  | Select-String -NotMatch -Pattern "(\*|develop|master)" 
  | ForEach-Object { git branch -d $_.ToString().Trim() }
}

# meson wrap
function mewrap
{
  $dst = $(meson wrap list | fzf --preview "meson wrap info {}")
  if ($dst)
  {
    meson wrap install $dst.Trim()
  }
}

# git cd root
function root()
{
  Set-Location $(git rev-parse --show-toplevel)
}
# git status
function gt()
{
  git status -sb
}
function glg()
{
  git lga
}
# pip
function pipup()
{
  py -m pip install pip --upgrade
}

function mkcd
{
  if (!(Test-Path $args))
  {
    New-Item -ItemType Directory $args
  }
  Set-Location $args[0]
}

function rmhere
{
  $tmp = (Get-Location)
  Set-Location ..
  Remove-Item $tmp
}

function Get-Assembiles
{
  [System.AppDomain]::CurrentDomain.GetAssemblies()
}

function Get-Types($Pattern = ".")
{
  Get-Assembiles | ForEach-Object { 
    $_.GetExportedTypes() 
  } | Where-Object {
    $_ -match $Pattern
  }
}

#
# dotfiles
#
function LinkDotFile
{
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline = $true)] [System.IO.FileInfo[]] $src
  )
  process
  {
    if ($src.FullName.StartsWith($dot_sync_dir))
    {
      $dst = Join-Path $HOME ($src.FullName.Substring($dot_sync_dir.Length + 1))
    } elseif ($src.FullName.StartsWith($dot_sync_app_dir))
    {
      $dst = Join-Path (Join-Path $HOME "AppData") ($src.FullName.Substring($dot_sync_app_dir.Length + 1))
    }

    #  Write-Host "$dst => $src"
    if (Test-Path $dst)
    {
      # green
      # Write-Host -NoNewline "${dst} exists"
    } else
    {
      # make symbolic link
      Write-Host -NoNewline "${dst} <== {$src}"
      New-Item -ItemType SymbolicLink -Path $dst -Value $src.FullName -Force
    }
  }
}

function Get-Dotfile
{
  [CmdletBinding()]
  Param()

  Process
  {
    Get-ChildItem -Recurse -Force -File $dot_sync_dir

    # if windows AppData, LOCALAPPDATA...
    if ($IsWindows)
    {
      Get-ChildItem -Recurse -Force -File $dot_sync_app_dir
    }
  }
}

function Remove-DeadLink
{
  Get-ChildItem ~\.config\ -Recurse
  | Where-Object { $_.LinkTarget -and !(Test-Path $_.LinkTarget) }
  | ForEach-Object { write-host "Remove: $_"; $_ }
  | Remove-Item
}

function Sync-DotFileLink
{
  # make symbolic link
  Get-Dotfile | ForEach-Object { LinkDotFile $_ }

  # remove dead link
  Remove-DeadLink
}

function Pull-DotFile
{
  [CmdletBinding()]
  Param()

  Process
  {
    Push-Location $dot_dir
    git pull
    Pop-Location

    Sync-DotFileLink
  }
}

function Push-DotFile
{
  [CmdletBinding()]
  Param()

  Process
  {
    Push-Location $dot_dir
    git add .
    git commit -av
    git push
    Pop-Location
  }
}

if (has "${env:LOCALAPPDATA}\Programs\Microsoft VS Code\bin\code.cmd")
{
  Set-Alias code (Join-Path $env:LOCALAPPDATA "\Programs\Microsoft VS Code\bin\code.cmd")
}

function now()
{
  [System.DateTimeOffset]::Now
}

# Set-Alias docker podman
# Set-Alias docker-compose podman-compose
if (!(has tig))
{
  Set-Alias tig D:\msys64\usr\bin\tig.exe
}

# object fzf
function ofzf()
{
  $map = [System.Collections.Generic.Dictionary[int, Object]]::new()
  $res = $input
  | ForEach-Object { 
    $i = $map.Count
    $map.Add($i, $_)
    "$i $_" }
  | fzf
  if ($res)
  {
    $map[[int]$res.Split()[0]]
  }
}

if (Test-Path "nvim")
{
  $env:EDITOR = "nvim"
} else
{
  $env:EDITOR = "vim"
}

function lk
{
  Set-Location (walk $args)
}

function Get-Git-RemoteBranch()
{
  # git for-each-ref --sort=-committerdate refs/remotes/origin --format='%(refname:short)' --merged
  git branch --remotes --merged 
  | ForEach-Object { $_.Trim() }
  | Where-Object { !($_.StartsWith("origin/HEAD")) }
}

function Remove-Git-RemoteBranch
{
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline = $true)] [string[]] $inputStrings
  )
  process
  {
    # origin/fix/hoge
    $sp = $inputStrings.split("/", 2)
    $remote = $sp[0]
    $branch = $sp[1]
    Write-Host "git push $remote :$branch"
    git push $remote :$branch
  }
}

# https://zenn.dev/ciffelia/articles/c394962a8f188a
function fapt
{
  $result = apt list | cut -d "/" -f 1 | fzf --preview "apt-cache show {}"
  if ($result)
  {
    sudo apt install $result
  }
}

function fpac
{
  $result = pacman -Sl | cut -d " " -f 2 | fzf --preview "pacman -Si {}"
  if ($result)
  {
    sudo pacman -S $result
  }
}

function Get-coreutils
{
  # or ?
  # cargo install uu_cat
  return @("arch", "b2sum", "b3sum", "base32", "base64", "basename", "basenc", "cat", "cksum",
    "comm", "cp", "csplit", "cut", "date", "dd", "df", "dir", "dircolors", "dirname", "du", "echo",
    "env", "expand", "expr", "factor", "false", "fmt", "fold", "hashsum", "head", "hostname",
    "join", "link", "ln", "ls", "md5sum", "mkdir", "mktemp", "more", "mv", "nl", "nproc", "numfmt",
    "od", "paste", "pr", "printenv", "printf", "ptx", 
    # "pwd", 
    "readlink", "realpath", "rm",
    "rmdir", "seq", "sha1sum", "sha224sum", "sha256sum", "sha3-224sum", "sha3-256sum",
    "sha3-384sum", "sha3-512sum", "sha384sum", "sha3sum", "sha512sum", "shake128sum",
    "shake256sum", "shred", "shuf", "sleep", "sort", "split", "sum", "sync", "tac", "tail", "tee",
    "test", "touch", "tr", 
    # "true", 
    "truncate", "tsort", "uname", "unexpand", "uniq", "unlink",
    "vdir", "wc", "whoami", "yes")
}

if ($IsWindows)
{
  foreach ($u in Get-coreutils)
  {
    $src = @"
function $u {
  coreutils $u `$args
}
"@
    # Write-Output $src
    Invoke-Expression $src
    # Get-Item function:$u
  }
}

function Set-Apt-Mirror
{
  if(Test-Path /etc/apt/sources.list.bak)
  {
    Get-Item /etc/apt/sources.list.bak
  } else
  {
    sudo bash -c "sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list"
  }
}

function Start-docker-postgres
{
  # --rm: コンテナ終了時にコンテナ自動的に削除
  docker run -d --rm -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres postgres:16-alpine
}

# https://qiita.com/www-tacos/items/d23b24f5af8687f2db88
function Windows-RightClick
{
  $key = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
  if (! (Test-Path ${key}) )
  {
    New-Item ${key} -Force
  }
  Set-ItemProperty ${key} -Name "(default)" -Value ""
  Stop-Process -Name explorer -Force
}

function Set-Env($name, $value)
{
  [Environment]::SetEnvironmentVariable($name, $value, [EnvironmentVariableTarget]::User)
}

Import-Module prompt -ErrorAction SilentlyContinue
Import-Module util -ErrorAction SilentlyContinue
Import-Module install -ErrorAction SilentlyContinue

