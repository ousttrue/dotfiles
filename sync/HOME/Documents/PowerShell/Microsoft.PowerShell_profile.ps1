#
# clear alias
#
Remove-Item  alias:* -force
Set-Alias cd Set-Location
Set-Alias pwd Get-Location
Set-Alias % ForEach-Object
Set-Alias ? Where-Object
function has($cmdname)
{
  try
  {
    # CmdletInfo | ApplicationInfo | AliasInfo | FunctionInfo
    switch(Get-Command $cmdname -ErrorAction Stop)
    {
      { $_ -is [System.Management.Automation.AliasInfo]}
      {$_.Definition
      }
      { $_ -is [System.Management.Automation.ApplicationInfo]}
      {$_.Definition
      }
      { $_ -is [System.Management.Automation.CmdletInfo]}
      {$_
      }
      { $_ -is [System.Management.Automation.FunctionInfo]}
      {$_
      }
      default
      {$_.GetType()
      }
    }
  } catch
  {
    return $false;
  }
}
if(!(has which))
{
  Set-Alias which has
}
function Get-Path([string]$type)
{
  switch($type)
  {
    "shada"
    { 
      if($IsWindows)
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
    { Get-Item (Join-Path $HOME "dotfiles") 
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
      if($IsWindows)
      {
        switch($type)
        {
          "blender" 
          {
            Get-Item (Join-Path ${env:AppData} "Blender Foundation\Blender")
          }
          "vswhere"
          {
            Get-Item (Join-Path ${env:ProgramFiles(x86)} "Microsoft Visual Studio\Installer\vswhere.exe")
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

$module_dir=Join-Path (Get-Path "dot") "psmodule\mymodule" 
$dll_path = Join-Path $module_dir "bin\Debug\net8.0\mymodule.dll"
if(!(Test-Path $dll_path))
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
if($IsWindows)
{
  chcp 65001
  $env:HOME = $env:USERPROFILE
  $EXE=".exe"
  $defs = @(
    [mymodule.Dependency]::new(
      "nvim", 
      "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.zip",
      "nvim-win64/bin/nvim.exe")
  )
} else
{
  $EXE=""
}

# asdf
$ASDF  = Join-Path $env:HOME ".asdf/asdf.ps1"
if(Test-Path $ASDF)
{
  . "${ASDF}"
}

$SEP = [System.IO.Path]::DirectorySeparatorChar
$env:FZF_DEFAULT_OPTS="--layout=reverse --preview-window down:70%"
$env:LUA_PATH="${HOME}${SEP}lua${SEP}?.lua;${HOME}${SEP}lua${SEP}?${SEP}init.lua"



if(has ghq)
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
  dotfiles = " "
  rtc_memo = "⚡"
  UniVRM = " "
  minixr = " "
  "ousttrue.github.io" = " "
  cmake_book = "📙"
  blender_book = "📙"
  lbsm = "🐵"
  "gltf-samples" = "🗿"
}

function get_git_status()
{
  git rev-parse --is-inside-work-tree 2>$null
  if(!$?)
  {
    return $false
  }

  $lines = @(git status --porcelain --branch)
  $sync = ""
  if($lines[0] -match "\[([^]]+)\]")
  {
    $splits = $Matches[1].split(', ')
    for ($i = 0; $i -lt $splits.Length; $i++)
    {
      if($splits[$i] -match "(\w+)\s+(\d+)")
      {
        $sync_status = $matches[1]
        $n = $matches[2]
        if($sync_status -eq "behind")
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
    if([string]::IsNullOrWhiteSpace($icon))
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
  if($IsWindows)
  {
    $prefix = " "
  } elseif($IsLinux)
  {
    $prefix = " "
  } elseif($IsMacOS)
  {
    $prefix + " "
  }

  $location = (Get-Item -force (Get-Location));
  $title = $location.Name
  if($GHQ_ROOT -and $location.FullName.StartsWith($GHQ_ROOT.FullName + $SEP))
  {
    $location = $location.FullName.Substring($GHQ_ROOT.FullName.Length+1)
    if($location.StartsWith( "github.com$()"))
    {
      $location = $location.Substring("github.com${SEP}".Length)
      if($location.StartsWith("ousttrue${SEP}"))
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
  } elseif($IsWindows -and $location.FullName.StartsWith("$(Get-Path "blender")${SEP}"))
  {
    $location = "🐵" + [System.IO.Path]::GetRelativePath((Get-Path "blender"), $location)
  } elseif($location.FullName.StartsWith($HOME))
  {
    if($location -eq $HOME)
    {
      $location = " "
    } else
    {
      $location = " " + $location.FullName.Substring($HOME.Length)
    }
  }

  if($IconMap[$title])
  {
    $title = $IconMap[$title]
  }

  $sync = (get_git_status)
  if($sync)
  {
    $branch = $(git branch --show-current)
    if ($branch)
    {
      # $branch = " `e[32m ${branch} $(git log --pretty=format:%s -n 1)`e[0m"
      $log = $(git log "--pretty=format: %cr   %s" -n 1)
      if($branch -eq "master")
      {
        $branch = "`e[30m`e[42m  ${branch} `e[0m ${sync} ${log}"
      } else
      {
        $branch = "`e[30m`e[41m  ${branch} `e[0m ${sync} ${log}"
      }
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
    stdout = $out
    stderr = $p.StandardError.ReadToEnd()
    ExitCode = $p.ExitCode
  }
}

function vcenv()
{ 
  # $vc_dir = (Get-VSSetupInstance).InstallationPath
  $vc_dir = &(Get-Path vswhere) -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
  #   # C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools
  # Write-Output $bat
  $v = (ExecuteCommand $vc_dir)

  foreach($l in $v.stdout.Split("`r`n"))
  {
    $kv = $l.Split("=", 2);
    switch($kv[0])
    {
      "PATH"
      { 
        foreach($e in $kv[1].Split(";"))
        {
          addPath($e)
        }
      }
      "INCLUDE"
      { "INCLUDE=> $($kv[1])"
        $env:INCLUDE= $kv[1]
      }
      "LIB"
      { "LIB=> $($kv[1])"
        $env:LIB=$kv[1]
      }
      "LIBPATH"
      { "LIBPATH=> $($kv[1])"
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
  if(-not $env:PATH.Contains($path))
  {
    $env:PATH = $path + [System.IO.Path]::PathSeparator + $env:PATH
  }
}
#
function addPath($path)
{
  if(-not $env:PATH.Contains($path))
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
insertPath(Join-Path $HOME "\local\bin")

if(Test-Path "C:\Python311")
{
  addPath("C:\Python311\Scripts")
  addPath("C:\Python311")
} elseif(Test-Path "C:\Python310")
{
  addPath("C:\Python310\Scripts")
  addPath("C:\Python310")
} elseif(Test-Path "C:\Python37")
{
  addPath("C:\Python37\Scripts")
  addPath("C:\Python37")
} elseif(Test-Path "C:\Python311-arm64")
{
  addPath("C:\Python311-arm64\Scripts")
  addPath("C:\Python311-arm64")
}

# For zoxide v0.8.0+
if(has zoxide)
{
  Invoke-Expression (& {
      $hook = if ($PSVersionTable.PSVersion.Major -lt 6)
      { 'prompt' 
      } else
      { 'pwd' 
      }
    (zoxide init --hook $hook powershell | Out-String)
    })
}

# cd ghq
function gg
{
  $dst = $(ghq list -p| fzf --reverse +m --preview "bat --color=always --style=header,grid --line-range :100 {}/README.md")
  if($dst)
  {
    Set-Location "$dst"
  }
}
function grm
{
  $dst = $(ghq list -p| fzf --reverse +m --preview "bat --color=always --style=header,grid {}/README.md")
  if($dst)
  {
    $parent = (Split-Path -Parent $dst)
    "remove : ${dst}" | Out-Host 
    Remove-Item -Recurse -Force $dst
    if(!(Get-ChildItem $parent))
    {
      # empty
      "remove parent: ${parent}" | Out-Host 
      Remove-Item -Recurse -Force $parent
    }
  }
}
function vv
{
  $dst = $(ghq list -p| fzf --reverse +m)
  if($dst)
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
  if($dst)
  {
    git switch $args $dst.Trim()
  }
}
# git switch remote
function gsr
{
  $dst = $(git branch -r | fzf)
  if($dst)
  {
    git switch -c $dst.Trim() $dst.Trim()
  }
}

function g_rm_merged
{
  git branch --merged
  | Select-String -NotMatch -Pattern "(\*|develop|master)" 
  | ForEach-Object{ git branch -d $_.ToString().Trim() }
}

# meson wrap
function mewrap
{
  $dst = $(meson wrap list| fzf --preview "meson wrap info {}")
  if($dst)
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
  if(!(Test-Path $args))
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
    {return $false
    }
    "^[a-z]$"
    {return $false
    }
    "exit"
    {return $false
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
function LinkDotFile([System.IO.FileInfo]$src)
{
  $syncHome = Get-Path "dot-sync"
  $syncApp = Get-Path "dot-sync-app"
  if($src.FullName.StartsWith($syncHome))
  {
    $dst = Join-Path $HOME ($src.FullName.Substring($syncHome.FullName.Length+1))
  } elseif($src.FullName.StartsWith($syncApp))
  {
    $dst = Join-Path (Join-Path $HOME "AppData") ($src.FullName.Substring($syncApp.FullName.Length+1))
  }
  if(Test-Path $dst)
  {
    # green
    # Write-Host -NoNewline "${dst} exists"
  } else
  {
    # make symbolic link
    Write-Host -NoNewline "${dst} <== {$src}"
    New-Item -ItemType SymbolicLink -Path $dst -Value $src -Force
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
    if($IsWindows)
    {
      $app = Get-Path "dot-sync-app"
      Get-ChildItem -Recurse -Force -File $app
    }
  }
}

function Remove-DeadLink
{
  Get-ChildItem ~\.config\ -Recurse
  | Where-Object{ $_.LinkTarget -and !(Test-Path $_.LinkTarget)}
  | ForEach-Object{write-host "Remove: $_"; $_}
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
    Get-Dotfile | ForEach-Object{ LinkDotFile $_ }

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
if(has exa)
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
} elseif(has lsd)
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
} elseif(has ls)
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
Set-Alias code "${env:LOCALAPPDATA}\Programs\Microsoft VS Code\bin\code.cmd"

function now()
{
  [System.DateTimeOffset]::Now
}

function rmrf()
{
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline=$true)] [string[]] $inputStrings
  )
  process
  {
    Remove-Item -Recurse -Force $inputStrings
  }
}

if($env:GIS_DIR -and (Test-Path (Join-Path $env:GIS_DIR "jma/area.json")))
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

Set-Alias docker podman
Set-Alias docker-compose podman-compose
if(!(has tig))
{
  Set-Alias tig D:\msys64\usr\bin\tig.exe
}

# object fzf
function ofzf()
{
  $map = [System.Collections.Generic.Dictionary[int, Object]]::new()
  $res = $input
  | ForEach-Object{ 
    $i = $map.Count
    $map.Add($i, $_)
    "$i $_" }
  | fzf
  if($res)
  {
    $map[[int]$res.Split()[0]]
  }
}

function Download-Dependency([mymodule.Dependency]$definition)
{
  $archive = Join-Path (Get-Path "local-src") $definition.GetArchive();
  if(Test-Path $archive)
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
  | ForEach-Object{ 
    $exe = Join-Path (Get-Path "local-src") $_.Exe
    if(Test-Path $exe)
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

# Set-Alias nvim (Join-Path (Get-Path "local-src") "nvim-win64/bin/nvim$EXE")
if($IsWindows)
{
  Set-Alias nvim "C:\Program Files\Neovim\bin\nvim.exe"
} else
{
  Set-Alias nvim (Join-Path $env:HOME "local/bin/nvim")
}
function v()
{
  nvim $args
}

if(!(has ldd))
{
  Set-Alias ldd (Join-Path (Get-Path "msys") "usr/bin/ldd.exe")
}
if(!(has file))
{
  Set-Alias file (Join-Path (Get-Path "msys") "usr/bin/file.exe")
}

function lk
{
  Set-Location (walk $args)
}
