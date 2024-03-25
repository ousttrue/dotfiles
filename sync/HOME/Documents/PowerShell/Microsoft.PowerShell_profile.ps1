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
$env:_CL_ = "/utf-8"
$env:XDG_CONFIG_HOME = "$HOME/.config"

$NVIM_PREFIX = Join-Path $HOME "neovim"

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
    # "msys" {
    #   Get-Item D:\msys64
    # }
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

$docs = Join-Path (Get-Path "dot") "docs/obsidian"

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
  $vc_dir = &vswhere -latest -products * -requires Microsoft.VisualStudio.Product.BuildTools -property installationPath
  if (!$vc_dir)
  {
    $vc_dir = &vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath 
  }
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
        $env:INCLUDE = $kv[1] #+ ";$HOME\local\include"
        "INCLUDE=> $env:INCLUDE"
      }
      "LIB"
      {
        $env:LIB = $kv[1] #+ ";$HOME\local\lib"
        "LIB=> $env:LIB"
      }
      "LIBPATH"
      {
        "LIBPATH=> $($kv[1])"
        $env:LIBPATH = $kv[1]
      }
      "VCINSTALLDIR"
      {
        "VCINSTALLDIR=> $($kv[1])"
        $env:VCINSTALLDIR = $kv[1]
      }
      "VSINSTALLDIR"
      {
        "VSINSTALLDIR=> $($kv[1])"
        $env:VSINSTALLDIR = $kv[1]
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

function Get-Python
{
  py -c "import sys; print(sys.base_prefix)"
}

# addPath(Join-Path (Get-Path "msys") "mingw64\bin")
addPath(Join-Path $HOME "\ghq\github.com\junegunn\fzf\bin")
addPath(Join-Path $HOME "\.fzf\bin")
addPath(Join-Path $HOME "\.deno\bin")
addPath(Join-Path $HOME "\.cargo\bin")
addPath(Join-Path $HOME "\go\bin")
addPath(Join-Path $HOME "\.local\bin")
insertPath(Join-Path $HOME "\local\bin")
if ($IsWindows)
{
  addPath("C:\Program Files\qemu")
  addPath('C:\Program Files\Erlang OTP\bin')
  # if(Test-Path "$HOME\zig")
  # {
  #   addPath("$HOME\zig")
  # } else
  # {
  if (!(has zig))
  {
    addPath(Join-Path $(Get-Python) 'lib\site-packages\ziglang')
  }

  # insertPath("$HOME\local\bin\zig\0.12.0-dev.3180+83e578a18\files")
  # }
} else
{
  addPath("/usr/local/go/bin")
}
if ($IsMacOS)
{
  addPath("/opt/homebrew/bin")
}
addPath(join-Path $HOME '/Downloads/Visual Studio Code.app/Contents/Resources/app/bin')

if (has py)
{
  $PY_PREFIX = Get-Python
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
    Push-Location (Get-Path "dot")
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
# if (has exa)
# {
#   Set-Alias ls exa
#   function ll
#   { 
#     exa -l $args 
#   }
#   function la
#   {
#     exa -a $args
#   }
# } elseif (has lsd)
# {
#   Set-Alias ls lsd
#   function ll
#   { 
#     lsd -l $args 
#   }
#   function la
#   {
#     lsd -a $args
#   }
# } elseif 
# (has ls)
# {

# }

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

function Install-dependency
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
  if (Test-Path "C:\Program Files\Neovim\bin\nvim.exe")
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
function v
{
  &"$NVIM_PREFIX\bin\nvim" $args
}

#if(!(has ldd))
#{
#  Set-Alias ldd (Join-Path (Get-Path "msys") "usr/bin/ldd.exe")
#}
# if (!(has file)) {
#   Set-Alias file (Join-Path (Get-Path "msys") "usr/bin/file.exe")
# }

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

function Download($url, $dst)
{
  $archive = $dst
  if((Get-Item $archive) -is [System.IO.DirectoryInfo])
  {
    $leaf = Split-Path -Leaf $url
    $archive = Join-Path $archive $leaf
  } 
  if (!(Test-Path $archive))
  {
    Invoke-WebRequest -Uri $url -OutFile $archive -AllowInsecureRedirect
  }
  $archive
}

function Extract($archive, $outdir)
{
  $extract = Join-Path $outdir (Split-Path -LeafBase $archive)
  write-host "extract: [$extract]"
  if (!(Test-Path $extract))
  {
    # Install-Module -Name 7Zip4Powershell
    Expand-7Zip $archive $extract
  }
  $extract
}

function Install-go
{
  if (!(has go))
  {
    # curl -L -O --trust-server-names https://go.dev/dl/go1.21.6.linux-amd64.tar.gz
    mkdir -p $HOME/Downloads
    $archive = Download "https://go.dev/dl/go1.21.6.linux-amd64.tar.gz" $HOME/Downloads
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf $archive
    if (!$IsWindows)
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

function Install-nvim
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
  $src = (Join-Path (ghq root) "/github.com/neovim/neovim")
  if (Test-Path $src)
  {
    Push-Location $src
    git pull
    if (Test-Path build)
    {
      rmrf .deps
      rmrf build
    }
  } else
  {
    ghq get https://github.com/neovim/neovim
    Push-Location $src
  }

  cmake -G Ninja -S cmake.deps -B .deps -DCMAKE_BUILD_TYPE=Release
  cmake --build .deps
  cmake -G Ninja -S . -B build -DCMAKE_BUILD_TYPE=Release
  cmake --build build
  cmake --install build --prefix $NVIM_PREFIX
  Pop-Location
}

function Install-rust
{
  if (!$IsWindows)
  {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  }
  cargo install zoxide ripgrep fd-find bottom lsd bat stylua tree-sitter-cli
  if ($IsWindows)
  {
    cargo install coreutils --features windows
  }
}

function Install-deno
{
  curl -fsSL https://deno.land/install.sh | sh
}

function Install-skk-dictionary
{
  mkdir -p ~/.skk
  Push-Location ~/.skk
  curl -L -O https://github.com/skk-dev/dict/raw/master/SKK-JISYO.L
  Pop-Location 
}

function Install-font
{
  mkdir -p ~/.fonts
  Push-Location ~/.fonts
  curl -L -O https://github.com/yuru7/HackGen/releases/download/v2.9.0/HackGen_NF_v2.9.0.zip
  unzip HackGen_NF_v2.9.0.zip
  Pop-Location
  fc-cache -fv
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

function Install-muon
{
  ghq get https://github.com/annacrombie/muon
  Push-Location (Join-Path (ghq root) "/github.com/annacrombie/muon")
  meson setup builddir --prefix $HOME/local
  meson install -C builddir
  Pop-Location
}

function Install-win32yank
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

function Install-all
{
  Install-go
  Install-nvim
  Install-rust
  Install-muon
  Install-deno
  Install-skk-dictionary
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

function Install-yay
{
  Push-Location $HOME
  pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git
  Push-Location yay
  makepkg -si
  Pop-Location

  git clone https://github.com/moson-mo/pacseek.git
  Push-Location pacseek
  go install .
  Pop-Location
  Pop-Location
}

function Install-exe($src, $dst)
{
  New-Item -ItemType File -Path $dst -Force
  Copy-Item $src $dst -Force
}

function Install-flex($prefix)
{
  $url = "https://github.com/lexxmark/winflexbison/releases/download/v2.5.25/win_flex_bison-2.5.25.zip"
  if (!(has win_flex))
  {
    $download_dir = "$HOME/Downloads"
    $archive = Download $url $download_dir
    $dir = Extract $archive $download_dir
    $bin_dir = Join-Path $prefix "bin"
    New-Item $bin_dir -ItemType Directory -ErrorAction SilentlyContinue
    Copy-Item -Recurse -Force $dir/* -Destination $bin_dir
  }
}

function Install-gperf($prefix)
{
  # $url = "https://gnuwin32.sourceforge.net/downlinks/gperf-bin-zip.php"
  $url = "https://github.com/leok7v/gnuwin32.mirror/raw/master/bin/gperf.exe"
  if (!(has gperf))
  {
    $dst = Join-Path $prefix "bin/gperf.exe"
    New-Item $dst -ErrorAction SilentlyContinue
    Remove-Item $dst
    Download $url $dst
    # $dir = Extract $archive $download_dir
    # Install-exe (Join-Path $dir "bin/gperf.exe") (Join-Path $prefix "bin/gperf.exe")
  }
}

function Install-tools($prefix)
{
  Install-flex $prefix
  Install-gperf $prefix
  if (!(has meson))
  {
    pip install meson
  }
  if (!(has cmake))
  {
    pip install cmake
  }
  if (!(has ninja))
  {
    pip install ninja
  }
  pip install packaging setuptools
}

function Install-glib($prefix)
{
  Install-tools $prefix

  $repos = "github.com/GNOME/glib"

  ghq get $repos
  Push-Location (Join-Path (ghq root) $repos)
  Get-Location
  if (Test-Path builddir)
  {
    Remove-Item -Recurse -Force builddir
  }

  $use_i="disabled"
  if(has gi-inspect-typelib.exe)
  {
    $use_i="enabled"
  }
  meson setup builddir --prefix $prefix -Dbuildtype=release "-Dintrospection=$use_i"

  meson install -C builddir
  Pop-Location

  Copy-Item $prefix/lib/libpcre2-8.a $prefix/lib/pcre2-8.lib
}

function Install-pkgconfig($prefix)
{
  $repos = "gitlab.freedesktop.org/pkg-config/pkg-config"
  ghq get $repos
  Push-Location (Join-Path (ghq root) $repos)
  Copy-Item config.h.win32.in config.h.win32
  $env:INCLUDE += ";$prefix\include\glib-2.0;$prefix\lib\glib-2.0\include"
  nmake /f Makefile.vc CFG=release
  Copy-Item release/x64/pkg-config.exe $prefix/bin/pkg-config.exe
  Pop-Location
}

function Install-gobjecgt-introspection($prefix)
{
  $repos = "github.com/GNOME/gobject-introspection"
  ghq get $repos
  Push-Location (Join-Path (ghq root) $repos)
  if (Test-Path builddir)
  {
    Remove-Item -Recurse -Force builddir
  }
  meson setup builddir --prefix $prefix -Dbuildtype=release
  meson install -C builddir
  Pop-Location
}

function Install-cairo($prefix)
{
  $repos = "gitlab.freedesktop.org/cairo/cairo"
  ghq get $repos
  Push-Location (Join-Path (ghq root) $repos)
  if (Test-Path builddir)
  {
    Remove-Item -Recurse -Force builddir
  }
  meson setup builddir --prefix $prefix -Dbuildtype=release -Dfontconfig=enabled -Dfreetype=enabled
  meson install -C builddir
  Pop-Location
}

function Install-gst
{
  $prefix = "$HOME/local"
  ghq get https://github.com/GStreamer/gstreamer
  Push-Location (Join-Path (ghq root) "github.com\GStreamer/gstreamer")
  Get-Location
  if (Test-Path builddir)
  {
    Remove-Item -Recurse -Force builddir
  }
  meson setup builddir --prefix $prefix -Dbuildtype=release -Dmedia-gstreamer=disabled -Dbuild-tests=false
  meson install -C builddir
  Pop-Location
}

function Install-gtk($prefix)
{
  $repos = "github.com/GNOME/gtk"
  ghq get $repos
  Push-Location (Join-Path (ghq root) $repos)
  Get-Location
  if (Test-Path builddir)
  {
    Remove-Item -Recurse -Force builddir
  }
  meson setup builddir --prefix $prefix -Dbuildtype=release -Dmedia-gstreamer=disabled -Dbuild-tests=false
  meson install -C builddir
  Pop-Location
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

function Install-libyaml
{
  $dir = Join-Path (ghq root) "github.com/yaml/libyaml"
  if (Test-Path $dir)
  {
    Push-Location $dir
    git pull
  } else
  {
    ghq get https://github.com/yaml/libyaml
    Push-Location $dir
  }
  cmake -G Ninja -S . -B build -DCMAKE_BUILD_TYPE=Release
  cmake --build build
  cmake --install build --prefix $HOME/local
  Pop-Location
}

function Install-openssl
{
  $dir = Join-Path (ghq root) "github.com\ousttrue\w3m\subprojects\openssl-3.0.8"
  Push-Location $dir
  Remove-Item -Recurse -Force builddir
  meson setup builddir --prefix $HOME/local
  meson install -C builddir
  New-Item "$HOME/local/include" -ItemType Directory -ErrorAction SilentlyContinue

  Copy-Item -Recurse .\generated-config\archs\VC-WIN64A\asm\include\progs.h "$HOME/local/include/progs.h"

  $include_openssl = "$HOME\local\include\openssl"
  if (Test-Path $include_openssl)
  {
    Remove-Item -Recurse -Force $include_openssl
  }
  Copy-Item -Recurse .\generated-config\archs\VC-WIN64A\asm\include\openssl $include_openssl

  $include_crypto = "$HOME\local\include\crypto"
  if (Test-Path $include_crypto)
  {
    Remove-Item -Recurse -Force $include_crypto
  }
  Copy-Item -Recurse .\generated-config\archs\VC-WIN64A\asm\include\crypto $include_crypto

  Pop-Location
}

function Install-ruby
{
  # Install-libyaml
  # Install-openssl
  # ruby
  New-Item "$HOME/local/src" -ItemType Directory -ErrorAction SilentlyContinue
  Set-Location "$HOME\local\src"
  $url = "https://cache.ruby-lang.org/pub/ruby/3.3/ruby-3.3.0.tar.gz"
  Invoke-WebRequest -Uri $url -OutFile "ruby-3.3.0.tar.gz"
  tar xf "ruby-3.3.0.tar.gz"
  Push-Location ruby-3.3.0
  Pop-Location
}

function Set-Prefix($prefix)
{
  # $prefix = Join-Path $HOME "local"
  $env:INCLUDE += ";$prefix\include"
  $env:LIB += ";$prefix\lib"
  $env:PKG_CONFIG_PATH = Join-Path $prefix "lib\pkgconfig"
  $env:GI_EXTRA_BASE_DLL_DIRS = "$prefix\bin" 
}

function Edit-Docs
{
  Set-Location $docs
  v
}

function Edit-Dotfiles
{
  Set-Location (Get-Path "dot")
  v
}
