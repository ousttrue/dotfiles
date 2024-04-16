function profiling
{
  # "Install-Module -Name psprofiler -Scope CurrentUser -AllowPrerelease -Force"
  pwsh -NoProfile -Command {Measure-Script -path $profile -Top 5}
}

function download($url, [System.IO.DirectoryInfo]$dst)
{
  $archive = ""
  if(Test-Path -PathType Container $dst)
  {
    $leaf = Split-Path -Leaf $url
    $archive = Join-Path $dst $leaf
  } else
  {
    $archive = $dst
    New-Item (Split-Path -Parent $dst) -ItemType Directory -ErrorAction SilentlyContinue
  }

  if (!(Test-Path $archive))
  {
    Invoke-WebRequest -Uri $url -OutFile $archive -AllowInsecureRedirect
  }
  $archive
}

function extract($archive, $outdir)
{
  $extract = Join-Path $outdir (Split-Path -LeafBase $archive)

  if($(Split-Path -Extension $extract) -eq ".tar")
  {
    $extract = Join-Path $(Split-Path -Parent $extract) $(Split-Path -LeafBase $extract)
    write-host "extract: [$extract]"

    Push-Location $outdir
    tar xf $archive
    Pop-Location
  } else
  {
    write-host "extract: [$extract]"
    if (!(Test-Path $extract))
    {
      # Install-Module -Name 7Zip4Powershell
      Expand-7Zip $archive $extract
    }
  }
  $extract
}

function Get-Path([string]$type)
{
  switch ($type)
  {
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

Export-ModuleMember -Function * -Alias *
