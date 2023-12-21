#
# [Nugetでインストールしたパッケージの読み込みサポート](https://qiita.com/ktz_alias/items/7306f0a44f0c051fa19d)
#
# using namespace Microsoft.PackageManagement.Packaging

class DependPackageInfo
{
  [string]$Provider
  [string]$Name
  [string]$Version
}

function New-PackageInfo
{
  [CmdletBinding()]
  param (
    [string]$Provider,
    [string]$Name,
    [string]$Version
  )

  [DependPackageInfo]@{
    Provider = $Provider
    Name = $Name
    Version = $Version
  }
}

function ConvertTo-PackageInfo
{
  [CmdletBinding()]
  param (
    [Parameter(ValueFromPipeline)]
    [Microsoft.PackageManagement.Packaging.SoftwareIdentity[]]$Package
  )

  foreach ($p in $Package)
  {
    New-PackageInfo -Name $p.Name -Version $p.Version -Provider $p.ProviderName
  }
}

function _NewDependPackage([Microsoft.PackageManagement.Packaging.SoftwareIdentity]$pkg)
{
  foreach ($dep in $pkg.Dependencies | Group-Object | ForEach-Object Name)
  {
    if ($dep -match "^(?<Provider>.+?):(?<Name>.+?)/(?<Version>.+?)$")
    {
      [DependPackageInfo]@{
        Provider = $Matches["Provider"]
        Name = $Matches["Name"]
        Version = $Matches["Version"]
      }
    }
  }
}

function Get-DependPackage
{
  [CmdletBinding()]
  param (
    [Parameter(ValueFromPipeline)]
    [Microsoft.PackageManagement.Packaging.SoftwareIdentity[]]$Package,
    [string]$Name,
    [string]$Version = $null
  )
  process
  {
    if (-not $Package)
    {
      if (-not $Name)
      { throw "Need package name parameter" 
      }

      $Package = @(
        if ($Version)
        { Get-Package -Name $Name -RequiredVersion $Version 
        } else
        { Get-Package -Name $Name 
        }
      )
    }

    foreach ($p in $Package)
    {
      _NewDependPackage $p
    }
  }
}

function Find-DependPackage
{
  [CmdletBinding()]
  param (
    [string]$Name,
    [string]$Version = $null
  )

  $pkg = 
  if ($Version)
  { Find-Package -Name $Name -RequiredVersion $Version 
  } else
  { Find-Package -Name $Name 
  }

  _NewDependPackage $pkg
}

function _GetPackageSourceDir([DependPackageInfo]$info)
{
  $pkg = 
  if ($info.Version)
  { Get-Package -Name $info.Name -RequiredVersion $info.Version -ErrorAction Ignore 
  } else
  { Get-Package -Name $info.Name 
  }

  if(!($pkg))
  {
    throw "no package ${info}"
  }

  Get-ChildItem "$($pkg.Source)/../lib"
}

function Get-PackageApiLevel
{
  [CmdletBinding()]
  param (
    [Parameter(ValueFromPipeline)]
    [DependPackageInfo[]]$Info,
    [string]$Name,
    [string]$Version = $null
  )
  process
  {
    if (-not $Info)
    {
      if (-not $Name)
      { throw "Need package name parameter" 
      }

      $Info = @( New-PackageInfo -Name $Name -Version $Version )
    }
    foreach ($i in $Info)
    {
      [PSCustomObject]@{
        Provider = $i.Provider
        Name = $i.Name
        Version = $i.Version
        ApiLevel = (_GetPackageSourceDir $i | ForEach-Object Name)
      }
    }
  }
}

function Resolve-PackageAssembly
{
  [CmdletBinding()]
  param (
    [Parameter(ValueFromPipeline)]
    [DependPackageInfo[]]$Info,
    [string]$Name,
    [string]$Version = $null,
    [string[]]$ApiLevel = @("netstandard2.0"),
    [switch]$Passthru
  )
  process
  {
    if (-not $Info)
    {
      if (-not $Name)
      { throw "Need package name parameter" 
      }

      $Info = @( New-PackageInfo -Name $Name -Version $Version )
    }

    foreach ($i in $Info)
    {
      $dir = _GetPackageSourceDir $i | Where-Object Name -in $ApiLevel | Select-Object -First 1
      if (-not $dir)
      { throw "Specified package API not found." 
      }

      if ($Passthru)
      { Add-Type -Path "$dir/*.dll" -Pass 
      } else
      { Add-Type -Path "$dir/*.dll" 
      }
    }
  }
}
