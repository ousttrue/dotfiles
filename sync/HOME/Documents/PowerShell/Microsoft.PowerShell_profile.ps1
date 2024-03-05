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
function Get-Path([string]$type)
{
  switch ($type)
  {
    "shada"
    { 
      if ($IsWindows)
      {
        Get-Item (Join-Path ${env:LOCALAPPDATA} "\nvim-data\shada") 
      } else
      {
        Get-Item (Join-Path ${env:HOME} ".local/state/nvim/shada") 
      }
    }
    "msys"
    {
      Get-Item D:\msys64
    }
    "dot"
    {
      Get-Item (Join-Path $HOME "dotfiles") 
    }
    "dot-sync"
    {
      Get-Item (Join-Path (Get-Path "dot") "sync/HOME")
    }
    "dot-sync-app"
    {
      Get-Item (Join-Path (Get-Path "dot") "sync/APPDATA")
    }
    "local"
    {
      Get-Item (Join-Path $HOME "local")
    }
    "local-src"
    {
      Get-Item (Join-Path (Get-Path "local") "src")
    }
    default
    {
      if ($IsWindows)
      {
        switch ($type)
        {
          "blender"
          {
            Get-Item (Join-Path ${env:AppData} "Blender Foundation\Blender")
          }
          default
          {
            $null 
          }
        }
      } else
      {
        $null 
      }
    }
  }
}

$module_dir = Join-Path (Get-Path "dot") "psmodule\mymodule" 
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

# asdf
$ASDF = Join-Path $env:HOME ".asdf/asdf.ps1"
if (Test-Path $ASDF)
{
  . "${ASDF}"
}

$SEP = [System.IO.Path]::DirectorySeparatorChar
$env:FZF_DEFAULT_OPTS = "--layout=reverse --preview-window down:70%"
$env:LUA_PATH = "${HOME}${SEP}lua${SEP}?.lua;${HOME}${SEP}lua${SEP}?${SEP}init.lua"



if (has ghq)
{
  $GHQ_ROOT = (Get-Item (ghq root))
}

#
# readline
#
# https://learn.microsoft.com/en-us/powershell/module/psreadline/about/about_psreadline_functions?view=powershell-7.2
# まとめて設定
#
# Set-PSReadLineOption -EditMode emacs
# 個別に設定
Set-PSReadlineKeyHandler -Key 'Ctrl+u' -Function BackwardDeleteLine
Set-PSReadlineKeyHandler -Key 'Ctrl+b' -Function BackwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+f' -Function ForwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+d' -Function DeleteCharOrExit
Set-PSReadlineKeyHandler -Key 'Ctrl+h' -Function BackwardDeleteChar
Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key 'Ctrl+a' -Function BeginningOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+e' -Function EndOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+m' -Function AcceptLine
Set-PSReadlineKeyHandler -Key 'Ctrl+k' -Function ForwardDeleteLine

Set-PSReadLineKeyHandler -Key "alt+r" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('<#SKIPHISTORY#> . $PROFILE')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

# ctrl + [
# [System.Console]::ReadKey()
Set-PSReadlineKeyHandler -Key 'Ctrl+Oem4' -Function RevertLine

#
# prompt
#
$IconMap = @{
  dotfiles             = " "
  rtc_memo             = "⚡"
  UniVRM               = " "
  minixr               = " "
  "ousttrue.github.io" = " "
  cmake_book           = "📙"
  blender_book         = "📙"
  lbsm                 = "🐵"
  "gltf-samples"       = "🗿"
}

function get_git_status()
{
  git rev-parse --is-inside-work-tree 2>$null
  if (!$?)
  {
    return $false
  }

  $lines = @(git status --porcelain --branch)
  $sync = ""
  if ($lines[0] -match "\[([^]]+)\]")
  {
    $splits = $Matches[1].split(', ')
    for ($i = 0; $i -lt $splits.Length; $i++)
    {
      if ($splits[$i] -match "(\w+)\s+(\d+)")
      {
        $sync_status = $matches[1]
        $n = $matches[2]
        if ($sync_status -eq "behind")
        {
          $sync += " ${n}"
        } elseif ($sync_status -eq "ahead")
        {
          $sync += " ${n}"
        }
      }
    }
  } else
  {
    $sync = " "
  }

  # A, M, D, ?, U, !, C, R
  $status = @{
  }
  $iconMap = @{
    "?" = " "
    "M" = " "
    "D" = " "
    "R" = "↷ "
  }
  for ($i = 1; $i -lt $lines.Length; $i++)
  {
    $line = $lines[$i]
    $key = $line.Substring(1, 1)
    $status[$key] += 1
  }
  foreach ($key in $status.Keys)
  {
    $icon = $iconMap[$key]
    if ([string]::IsNullOrWhiteSpace($icon))
    {
      $icon = $key
    }
    $sync += "${icon}$($status[$key])"
  } 
 
  return $sync
}

function prompt()
{
  # TODO: git status
  # TODO: project kind
  # - dotfiles
  # - ghq
  # - lang
  $color = $? ? "32" : "31";

  $prefix = "🤔"
  if ($IsWindows)
  {
    $prefix = " "
  } elseif ($IsLinux)
  {
    $prefix = " "
  } elseif ($IsMacOS)
  {
    $prefix = " "
  }

  $location = (Get-Item -force (Get-Location));
  $title = $location.Name
  if ($GHQ_ROOT -and $location.FullName.StartsWith($GHQ_ROOT.FullName + $SEP))
  {
    $location = $location.FullName.Substring($GHQ_ROOT.FullName.Length + 1)
    if ($location.StartsWith( "github.com$()"))
    {
      $location = $location.Substring("github.com${SEP}".Length)
      if ($location.StartsWith("ousttrue${SEP}"))
      {
        $location = " " + $location.Substring("ousttrue${SEP}".Length)
      } else
      {
        $location = " " + $location
      }
    } else
    {
      $location = " " + $location
    }
  } elseif ($IsWindows -and $location.FullName.StartsWith("$(Get-Path "blender")${SEP}"))
  {
    $location = "🐵" + [System.IO.Path]::GetRelativePath((Get-Path "blender"), $location)
  } elseif ($location.FullName.StartsWith($HOME))
  {
    if ($location -eq $HOME)
    {
      $location = " "
    } else
    {
      $location = " " + $location.FullName.Substring($HOME.Length)
    }
  }

  # wezterm only
  if ($env:TERM -eq "tmux-256color")
  {
    if ($IconMap[$title])
    {
      tmux rename-window $IconMap[$title]
    } else
    {
      tmux rename-window $title
    }
  } else
  {
    if ($IconMap[$title])
    {
      $title = $IconMap[$title]
    }
  }

  $sync = (get_git_status)
  if ($sync)
  {
    $branch = $(git branch --show-current)
    if ($branch)
    {
      $log = $(git log "--pretty=format: %cr   %s" -n 1)
      $ref = (git rev-parse --abbrev-ref origin/HEAD).Split("/", 2)[1]
      $branch_color = "`e[30m`e[42m";
      if ($branch -ne $ref)
      {
        # red
        $branch_color = "`e[30m`e[41m";
      }
      $branch = "${branch_color}  ${branch} `e[0m ${sync} ${log}"
    }
  } 

  "`e]2;${title}$([char]0x07)${prefix}`e[7m${location}`e[0m${branch}`n`e[${color}m>`e[0m "
}

function ExecuteCommand ($vc_dir)
{ 
  $bat = (Join-Path $vc_dir "VC\Auxiliary\Build\vcvars64.bat")
  # (Get-Item $bat)

  $pinfo = New-Object System.Diagnostics.ProcessStartInfo
  $pinfo.FileName = $env:COMSPEC
  $pinfo.RedirectStandardError = $true
  $pinfo.RedirectStandardOutput = $true
  $pinfo.RedirectStandardInput = $true
  $pinfo.UseShellExecute = $false
  # $commandArguments="/K `"$bat`""
  # $pinfo.Arguments = $commandArguments
  # $pinfo.ArgumentList.Add("/K")
  # $pinfo.ArgumentList.Add("`"$bat`"")
  # Write-Output $pinfo.ArgumentList
  $pinfo.WorkingDirectory = $vc_dir
  $p = New-Object System.Diagnostics.Process
  $p.StartInfo = $pinfo
  $p.Start() | Out-Null
  $p.StandardInput.WriteLine("call `"$bat`"")
  $p.StandardInput.WriteLine("set")
  $p.StandardInput.WriteLine("exit")

  $out = ""
  # require flush. WaitForExit cause dead lock
  while ($null -ne ($l = $p.StandardOutput.ReadLine()))
  {
    $out += "$l`r`n"
  }
  $p.WaitForExit()
  $p
  [pscustomobject]@{
    stdout   = $out
    stderr   = $p.StandardError.ReadToEnd()
    ExitCode = $p.ExitCode
  }
}

function vcenv()
{ 
  # $vc_dir = (Get-VSSetupInstance).InstallationPath
  # $vc_dir = &vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
  $vc_dir = &vswhere -latest -products * -requires Microsoft.VisualStudio.Product.BuildTools -property installationPath
  Write-Output $vc_dir
  $v = (ExecuteCommand $vc_dir)

  foreach ($l in $v.stdout.Split("`r`n"))
  {
    $kv = $l.Split("=", 2);
    switch ($kv[0])
    {
      "PATH"
      { 
        foreach ($e in $kv[1].Split(";"))
        {
          addPath($e)
        }
      }
      "INCLUDE"
      {
        "INCLUDE=> $($kv[1])"
        $env:INCLUDE = $kv[1]
      }
      "LIB"
      {
        "LIB=> $($kv[1])"
        $env:LIB = $kv[1]
      }
      "LIBPATH"
      {
        "LIBPATH=> $($kv[1])"
        $env:LIBPATH = $kv[1]
      }
    }
  }
  # Write-Output $v.stdout
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

# addPath(Join-Path (Get-Path "msys") "mingw64\bin")
addPath(Join-Path $HOME "\ghq\github.com\junegunn\fzf\bin")
addPath(Join-Path $HOME "\.fzf\bin")
addPath(Join-Path $HOME "\.deno\bin")
addPath(Join-Path $HOME "\.cargo\bin")
addPath(Join-Path $HOME "\go\bin")
addPath(Join-Path $HOME "\.local\bin")
insertPath(Join-Path $HOME "\local\bin")
if(!$IsWindows)
{
  addPath("/usr/local/go/bin")
}
if($IsMacOS)
{
  addPath("/opt/homebrew/bin")
}
addPath(join-Path $HOME '/Downloads/Visual Studio Code.app/Contents/Resources/app/bin')
addPath("C:\Program Files\qemu")
addPath('C:\Program Files\Erlang OTP\bin')

if(has py)
{
  $PY_PREFIX = $(py -c "import sys; print(sys.base_prefix)")
  insertPath($PY_PREFIX)
  insertPath(Join-Path $PY_PREFIX "Scripts")
}

if ($IsMacOS)
{
  $env:N_PREFIX = (Join-Path $env:HOME "/.n")
  addPath(Join-Path $env:N_PREFIX "/bin")
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

function g_rm_merged
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
# module
# default not required
# Import-Module -Verbose -Name CompletionPredictor
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineOption -HistoryNoDuplicates
Set-PSReadlineOption -AddToHistoryHandler {
  param ($command)
  switch -regex ($command)
  {
    "SKIPHISTORY"
    {
      return $false
    }
    "^[a-z]$"
    {
      return $false
    }
    "exit"
    {
      return $false
    }
  }
  return $true
}
# Import-Module -Verbose posh-git
# $GitPromptSettings.EnableFileStatus = $false
# Import-Module -Verbose -Name Terminal-Icons

Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
  dotnet complete --position $cursorPosition "$commandAst" | ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
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
    $syncHome = Get-Path "dot-sync"
    $syncApp = Get-Path "dot-sync-app"
    if ($src.FullName.StartsWith($syncHome))
    {
      $dst = Join-Path $HOME ($src.FullName.Substring($syncHome.FullName.Length + 1))
    } elseif ($src.FullName.StartsWith($syncApp))
    {
      $dst = Join-Path (Join-Path $HOME "AppData") ($src.FullName.Substring($syncApp.FullName.Length + 1))
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
    Get-ChildItem -Recurse -Force -File (Get-Path "dot-sync")

    # if windows AppData, LOCALAPPDATA...
    if ($IsWindows)
    {
      $app = Get-Path "dot-sync-app"
      Get-ChildItem -Recurse -Force -File $app
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

function Pull-DotFile
{
  [CmdletBinding()]
  Param()

  Process
  {
    Push-Location (Get-Path "dot")
    git pull

    # make symbolic link
    Get-Dotfile | ForEach-Object { LinkDotFile $_ }

    # remove dead link
    Remove-DeadLink

    Pop-Location
  }
}

function Push-DotFile
{
  [CmdletBinding()]
  Param()

  Process
  {
    Push-Location (Get-Path "dot")
    git add .
    git commit -av
    git push
    Pop-Location
  }
}

#
# alias
#
if (has exa)
{
  Set-Alias ls exa
  function ll
  { 
    exa -l $args 
  }
  function la
  {
    exa -a $args
  }
} elseif (has lsd)
{
  Set-Alias ls lsd
  function ll
  { 
    lsd -l $args 
  }
  function la
  {
    lsd -a $args
  }
} elseif (has ls)
{
  function ll
  { 
    ls -l $args 
  }
  function la
  {
    ls -a $args
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

function rmrf
{
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline = $true)] [string[]] $inputStrings
  )
  process
  {
    Remove-Item -Recurse -Force $inputStrings
  }
}

if ($env:GIS_DIR -and (Test-Path (Join-Path $env:GIS_DIR "jma/area.json")))
{
  $area = (Get-Content (Join-Path $env:GIS_DIR "jma/area.json") | ConvertFrom-Json -AsHashtable)[0]
} else
{
  $area = @{}
}

# function areaItems($key, $list)
# {
#   $items = $area[$key]
#   foreach($key in $items.keys)
#   {
#     $value = $items[$key]
#     $value["id"]= $key
#     [void]$list.Add($value)
#   }
# }

# function Get-Area()
# {
#   $list = [System.Collections.ArrayList]::new()
#
#   areaItems "centers" $list
#   areaItems "offices" $list
#   areaItems "class10s" $list
#   areaItems "class15s" $list
#   areaItems "class20s" $list
#
#   $list.ToArray()
# }
# 

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

function Download-Dependency([mymodule.Dependency]$definition)
{
  $archive = Join-Path (Get-Path "local-src") $definition.GetArchive();
  if (Test-Path $archive)
  {
    Write-Host "$archive exists"
  } else
  {
    Write-Host "download $archive <== $($definition.Url) ..."
    Invoke-WebRequest -Uri $definition.Url -OutFile $archive
  }
}

function Extract-Dependency([mymodule.Dependency]$definition)
{
  $archive = Join-Path (Get-Path "local-src") $definition.GetArchive();
  Expand-Archive -Path $archive -DestinationPath (Split-Path -parent $archive)
}

function Install-Dependency
{
  $input
  | ForEach-Object { 
    $exe = Join-Path (Get-Path "local-src") $_.Exe
    if (Test-Path $exe)
    {
      [void](Write-Host "$($_.Exe) exists")
    } else
    {
      [void](Download-Dependency $_)
      $_
    }
  }
  | ForEach-Object {
    [void](Extract-Dependency $_)
  }
}

if (Test-Path "nvim")
{
  $env:EDITOR = "nvim"
} else
{
  $env:EDITOR = "vim"
}

# Set-Alias nvim (Join-Path (Get-Path "local-src") "nvim-win64/bin/nvim$EXE")
if ($IsWindows)
{
  if(Test-Path "C:\Program Files\Neovim\bin\nvim.exe")
  {
    Set-Alias nvim "C:\Program Files\Neovim\bin\nvim.exe"
  } else
  {
    Set-Alias nvim "$HOME\local\bin\nvim.exe"
  }
} else
{
  Set-Alias nvim (Join-Path $env:HOME "local/bin/nvim")
}
function v()
{
  nvim $args
}

#if(!(has ldd))
#{
#  Set-Alias ldd (Join-Path (Get-Path "msys") "usr/bin/ldd.exe")
#}
if (!(has file))
{
  Set-Alias file (Join-Path (Get-Path "msys") "usr/bin/file.exe")
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

function Install-Go
{
  if (!(has go))
  {
    mkdir -p $HOME/local/src
    Push-Location $HOME/local/src
    wget --trust-server-names https://go.dev/dl/go1.21.6.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz
    Pop-Location
    if(!$IsWindows)
    {
      addPath("/usr/local/go/bin")
    }
  }

  go install github.com/x-motemen/ghq@latest
  mkdir -p $(ghq root)

  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf

  if ($IsWindows)
  {
    &"$HOME/.fzf/install.ps1"
  } else
  {
    &"$HOME/.fzf/install"
  }
}

function Install-Nvim
{
  # https://github.com/neovim/neovim/blob/master/BUILD.md#build-prerequisites
  if (has brew)
  {
    brew install ninja cmake gettext curl
  } 
  if (has apt)
  {
    sudo apt update
    sudo apt install -y build-essential ninja-build gettext cmake unzip curl
  }
  if (has pacman)
  {
    sudo pacman -Sy
    sudo pacman -S base-devel cmake unzip ninja curl
  }
  ghq get https://github.com/neovim/neovim
  Push-Location (Join-Path (ghq root) "/github.com/neovim/neovim")
  git pull
  cmake -G Ninja -S cmake.deps -B .deps -DCMAKE_BUILD_TYPE=Release
  cmake --build .deps
  cmake -G Ninja -S . -B build -DCMAKE_BUILD_TYPE=Release
  cmake --build build
  cmake --install build --prefix $HOME/local
  Pop-Location
}

function Install-Rust
{
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  cargo install zoxide ripgrep fd-find bottom lsd bat stylua tree-sitter-cli
}

function Install-Deno
{
  curl -fsSL https://deno.land/install.sh | sh
}

function Install-Skk-Dictionary
{
  mkdir -p ~/.skk
  Push-Location ~/.skk
  curl -L -o SKK-JISYO.L https://github.com/skk-dev/dict/raw/master/SKK-JISYO.L
  Pop-Location 
}

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

function Install-Muon
{
  ghq get https://github.com/annacrombie/muon
  Push-Location (Join-Path (ghq root) "/github.com/annacrombie/muon")
  meson setup builddir --prefix $HOME/local
  meson install -C builddir
  Pop-Location
}

function Install-Win32Yank
{
  mkdir -p ~/local/src
  Push-Location ~/local/src
  curl -L -O https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
  unzip ./win32yank-x64.zip win32yank.exe
  mkdir -p ~/local/bin
  Move-Item -force win32yank.exe ~/local/bin/win32yank.exe
  chmod +x ~/local/bin/win32yank.exe
  Pop-Location
}

function Install-All
{
  Install-Go
  Install-Nvim
  Install-Rust
  Install-Muon
  Install-Deno
  Install-Skk-Dictionary
}

function Remove-TSParser
{
  if (Test-Path "$HOME/local/lib/nvim/parser"
  )
  {
    rmrf "$HOME/local/lib/nvim/parser"
  }
  if (Test-Path "$HOME/.local/share/nvim/lazy/nvim-treesitter/parser"
  )
  {
    rmrf "$HOME/.local/share/nvim/lazy/nvim-treesitter/parser"
  }
  if (Test-Path "$HOME/.cache/nvim/treesitter/parser"
  )
  {
    rmrf "$HOME/.cache/nvim/treesitter/parser"
  }
}
