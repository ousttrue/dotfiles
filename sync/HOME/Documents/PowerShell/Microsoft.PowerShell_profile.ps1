Remove-Item  alias:* -force
if(!$env:HOME)
{
  $env:HOME = $env:USERPROFILE
}
$env:FZF_DEFAULT_OPTS="--layout=reverse --preview-window down:70%"
$DotDir = (Get-Item (Join-Path $env:HOME "dotfiles"))
function has($cmdname)
{
  try
  {
    Get-Command $cmdname -ErrorAction Stop | Select-Object -ExpandProperty Definition
    return $true
  } catch
  {
    return $false;
  }
}
function RemoveItemIf([string]$path)
{
  if(Test-Path $path)
  {
    Remove-Item $path -force
  }
}
if(has chcp)
{
  chcp 65001
}
if(has ghq)
{
  $GHQ_ROOT = (Get-Item (ghq root))
}
function SetAliasIfExists([string]$name, [string]$path)
{
  if(Test-Path $path)
  {
    Set-Alias -Name $name -Value $path
  }
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

$IconMap = @{
  dotfiles = " "
  rtc_memo = "⚡"
  UniVRM = " "
  minixr = " "
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

  $location = (Get-Item (Get-Location));
  $title = $location.Name
  if($GHQ_ROOT -and $location.FullName.StartsWith($GHQ_ROOT.FullName + "\"))
  {
    $location = $location.FullName.Substring($GHQ_ROOT.FullName.Length+1)
    if($location.StartsWith( "github.com\"))
    {
      $location = $location.Substring("github.com\".Length)
      if($location.StartsWith("ousttrue\"))
      {
        $location = " " + $location.Substring("ousttrue\".Length)
      } else
      {
        $location = " " + $location
      }
    } else
    {
      $location = " " + $location
    }
  } elseif($location.FullName.StartsWith($env:HOME))
  {
    if($location -eq $env:HOME)
    {
      $location = " "
    } else
    {
      $location = " " + $location.FullName.Substring($env:HOME.Length)
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
      $branch = " `e[32m[ ${branch}] ${sync} ${log}`e[0m"
    }
  } 

  "`e]2;${title}$([char]0x07)${prefix}`e[7m${location}`e[0m${branch}`n`e[${color}m>`e[0m "
}

# function ExecuteCommand ($commandPath, $commandArguments) 
# { 
#     $pinfo = New-Object System.Diagnostics.ProcessStartInfo 
#     $pinfo.FileName = $commandPath 
#     $pinfo.RedirectStandardError = $true 
#     $pinfo.RedirectStandardOutput = $true 
#     $pinfo.UseShellExecute = $false 
#     $pinfo.Arguments = $commandArguments 
#     $pinfo.WorkingDirectory = "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\"
#     $p = New-Object System.Diagnostics.Process 
#     $p.StartInfo = $pinfo 
#     $p.Start() | Out-Null 
#     $p.WaitForExit() 
#     [pscustomobject]@{ 
#         stdout = $p.StandardOutput.ReadToEnd() 
#         stderr = $p.StandardError.ReadToEnd() 
#         ExitCode = $p.ExitCode 
#     } 
# } 

# function vcenv()
# { 
#     $VSWHERE = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
#
#     $vc_dir = &$VSWHERE -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
#     # C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools
#     $bat = "$vc_dir\VC\Auxiliary\Build\vcvars64.bat"
#     Write-Output $bat
#
#     $v = ExecuteCommand "${env:COMSPEC}" "/C $bat & set"
#     Write-Output $v.stdout
# }
# vcenv

#
# path
#
function insertPath($path)
{
  if($env:Path -notcontains $path)
  {
    $env:Path = $path + ";" + $env:Path
  }
}
#
function addPath($path)
{
  if($env:Path -notcontains $path)
  {
    $env:Path = $env:Path + ";" + $path
  }
}

addPath($env:USERPROFILE + "\ghq\github.com\junegunn\fzf\bin")
addPath($env:USERPROFILE + "\.fzf\bin")
addPath($env:USERPROFILE + "\build\mingw\bin")
# addPath($env:USERPROFILE + "/prefix/bin")
addPath($env:USERPROFILE + "\.deno\bin")
addPath($env:USERPROFILE + "\.cargo\bin")
# addPath($env:USERPROFILE + "\go\bin")
insertPath($env:USERPROFILE + "\local\bin")
# addPath($env:USERPROFILE + "\AppData\Local\Programs\Microsoft VS Code")
# addPath("C:\Program Files\Git\usr\bin")
# addPath("C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\amd64")
# addPath($env:USERPROFILE + "\local\src\depot_tools")
# if($env:JAVA_HOME -ne $null){
#     addPath($env:JAVA_HOME + "\bin")
# }
# if($env:ANDROID_HOME -ne $null){
#     addPath($env:ANDROID_HOME + "\platform-tools")
#     addPath($env:ANDROID_HOME + "\ndk\21.4.7075529")
# }
# if($env:GRADLE_HOME -ne $null){
#     addPath($env:GRADLE_HOME + "\bin")
# }
# if($env:GTK_DIR -ne $null)
# {
#     insertPath($env:GTK_DIR + "\bin")
# }
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

# addPath($env:USERPROFILE + "\local\nim-1.6.8\bin")
addPath($env:USERPROFILE + "\neovim\bin")

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
    git switch $dst.Trim()
  }
}
# git switch force
function gsf
{
  $dst = $(git branch | fzf)
  if($dst)
  {
    git switch -f $dst.Trim()
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
function rt()
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

function v()
{
  nvim $args
}

function ud
{ Set-Location .. 
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

function LinkDotFile([System.IO.FileInfo]$src)
{
  $dst = ($src.FullName.Substring($DotDir.FullName.Length+1))
  Write-Host -NoNewline "${dst} "
  if(Test-Path $dst)
  {
    # green
    Write-Host "exists"
  } else
  {
    # make symbolic link
    Write-Host "<== {$src}"
    New-Item -ItemType SymbolicLink -Path $dst -Value $dst -Force
  }
}

function Get-Dotfile
{
  [CmdletBinding()]
  Param()

  Process
  {
    Get-ChildItem -Recurse -Force -File "${DotDir}/sync/HOME"

    # if windows AppData, LOCALAPPDATA...
  }
}

function Sync-DotFile
{
  [CmdletBinding()]
  Param()

  Process
  {
    Push-Location ${env:HOME}/dotfiles
    git pull

    # TODO: update symbolic links

    Pop-Location
  }
}

function Push-DotFile
{
  [CmdletBinding()]
  Param()

  Process
  {
    Push-Location ${env:HOME}/dotfiles
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
Set-Alias cd Set-Location

function now()
{
  [System.DateTimeOffset]::Now
}

function rmrf()
{
  Remove-Item -Recurse -Force $args
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

Set-Alias docker podman
Set-Alias docker-compose podman-compose
if(!(has tig))
{
  Set-Alias tig D:\msys64\usr\bin\tig.exe
}
