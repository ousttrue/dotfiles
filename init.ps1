if(!(Test-Path $profile)){
  $here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
  $dst = (Join-Path $here "sync/HOME/Documents/PowerShell/Microsoft.PowerShell_profile.ps1")
  New-Item -ItemType SymbolicLink -Path $profile -Value $dst -Force

  Write-Host "visudo => <username> ALL=NOPASSWD: ALL"
  Write-Host "Set-Apt-Mirror"
}
