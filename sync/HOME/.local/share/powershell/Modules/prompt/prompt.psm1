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
  } 
  # elseif ($IsWindows -and $location.FullName.StartsWith("$(Get-Path "blender")${SEP}"))
  # {
  #   $location = "🐵" + [System.IO.Path]::GetRelativePath((Get-Path "blender"), $location)
  # } 
  elseif ($location.FullName.StartsWith($HOME))
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

function Edit-Docs
{
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
  Set-Location (Get-Path "dot")
  if ($env:TERM -eq "tmux-256color")
  {
    tmux rename-window " "
  } 
  Write-Host "`e]2; $([char]0x07)"
  v
}

Export-ModuleMember -Function * -Alias *
