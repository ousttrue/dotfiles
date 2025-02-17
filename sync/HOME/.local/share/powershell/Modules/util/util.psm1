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

function Right-Menu()
{
  # レジストリキーの定義
  $key = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"

  # レジストリキーが存在しなければ再帰的に作成
  if (! (Test-Path ${key}) )
  {
    New-Item ${key} -Force
  }

  # 既定プロパティにブランクを設定
  Set-ItemProperty ${key} -Name "(default)" -Value ""

  # Explorerの再起動
  Stop-Process -Name explorer -Force
}

Export-ModuleMember -Function * -Alias *
