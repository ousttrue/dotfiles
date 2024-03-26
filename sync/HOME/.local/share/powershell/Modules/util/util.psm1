function profiling
{
  # "Install-Module -Name psprofiler -Scope CurrentUser -AllowPrerelease -Force"
  pwsh -NoProfile -Command {Measure-Script -path $profile -Top 5}
}

Export-ModuleMember -Function * -Alias *
