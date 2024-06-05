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
      "VSCMD_VER"
      {
        "VSCMD_VER=> $($kv[1])"
        $env:VSCMD_VER = $kv[1]
      }
    }
  }
  # Write-Output $v.stdout
}

Export-ModuleMember -Function * -Alias *
