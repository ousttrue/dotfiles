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
  obsidian             = "📚"
  rtc_memo             = "⚡"
  UniVRM               = " "
  minixr               = " "
  "ousttrue.github.io" = " "
  cmake_book           = "📙"
  blender_book         = "📙"
  lbsm                 = "🐵"
  "gltf-samples"       = "🗿"
}

$BLENDER = Join-Path $HOME "AppData\Roaming\Blender Foundation\Blender" 

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

function replacePrefix($full, $prefix, $to)
{
  if ($full -eq $prefix)
  {
    return $to
  } 

  if($full -is [string])
  {
    return $to + $full.Substring($prefix.Length)
  }

  return $to + $full.FullName.Substring($prefix.Length)
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
    if ($location.StartsWith( "github.com${SEP}"))
    {
      $location = $location.Substring("github.com${SEP}".Length)
      if ($location.StartsWith("ousttrue"))
      {
        $location = replacePrefix $location "ousttrue" " "
      } else
      {
        $location = " " + $location
      }
    } else
    {
      $location = " " + $location
    }
  } elseif($location.FullName.StartsWith($BLENDER))
  {
    $location = replacePrefix $location $BLENDER "󰂫 "
  } elseif ($location.FullName.StartsWith($HOME))
  {
    $location = replacePrefix $location $HOME " "
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
      $log = $(git log "--pretty=format:#%h  %cr   %s" -n 1)
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

  # OSC7
  # https://wezfurlong.org/wezterm/shell-integration.html#osc-7-on-windows-with-cmdexe
  "`e]2;${title}$([char]0x07)${prefix}`e[7m${location}`e[0m${branch}`n`e[${color}m>`e[0m "
}

function Edit-Docs
{
  $docs = Join-Path $dot_dir "docs/obsidian"
  Set-Location $docs
  if ($env:TERM -eq "tmux-256color")
  {
    tmux rename-window "📚"
  } 
  Write-Host "`e]2;📚$([char]0x07)"
  v
}

function Edit-Dotfiles
{
  Set-Location $dot_dir
  if ($env:TERM -eq "tmux-256color")
  {
    tmux rename-window " "
  } 
  Write-Host "`e]2; $([char]0x07)"
  v
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

function Enter-blender($version="4.1")
{
  $dir = "$BLENDER\$version\scripts\addons"
  if(!(Test-Path dir))
  {
    New-Item $dir -ItemType Directory -ErrorAction SilentlyContinue
  }
  Set-Location $dir
}

function Enter-python
{
  if($IsWindows)
  {
    $dir = py -c "import sys; print(sys.base_prefix)"
  } elseif(has python)
  {
    $dir = python -c "import sys; print(sys.base_prefix)"
  } elseif(has python3)
  {
    $dir = python3 -c "import sys; print(sys.base_prefix)"
  }

  if($dir)
  {
    Set-Location $dir
    $dir
  }
}

Export-ModuleMember -Function * -Alias *
