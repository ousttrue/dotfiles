$env:HOME = $env:USERPROFILE
# $env:JAVA_HOME = $env:ANDROID_STUDIO_HOME + "\jre";
# $env:VCPKG_DISABLE_METRICS = 1

# $PSDefaultParameterValues['*:Encoding'] = 'utf8'
# if($env:TERM_PROGRAM -ne "vscode"){
#    chcp 65001
# }

## readline
# https://learn.microsoft.com/en-us/powershell/module/psreadline/about/about_psreadline_functions?view=powershell-7.2
Set-PSReadlineKeyHandler -Key 'Ctrl+u' -Function BackwardDeleteLine
Set-PSReadlineKeyHandler -Key 'Ctrl+b' -Function BackwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+f' -Function ForwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+d' -Function DeleteChar
Set-PSReadlineKeyHandler -Key 'Ctrl+h' -Function BackwardDeleteChar
Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key 'Ctrl+a' -Function BeginningOfLine
# Set-PSReadlineKeyHandler -Key 'Ctrl+e' -Function EndOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+m' -Function AcceptLine
Set-PSReadlineKeyHandler -Key 'Ctrl+k' -Function ForwardDeleteLine

# Import-Module -Name CompletionPredictor
# Set-PSReadLineOption -PredictionSource History
# Set-PSReadLineOption -PredictionViewStyle ListView

# ??
Set-PSReadlineKeyHandler -Chord Ctrl+[ -ScriptBlock { "hello" }

Remove-Item alias:mv
Remove-Item alias:cp
Remove-Item alias:rm
Remove-Item alias:rmdir
Remove-Item alias:diff -force
Remove-Item -Path Function:\mkdir

# Remove-Item alias:ls
# Import-Module -Name Terminal-Icons
# function ls()
# {
#     lsd $args
# }
# function ll()
# {
#     lsd -l $args
# }
# function la()
# {
#     lsd -a $args
# }

# function prompt () {
#   (Split-Path (Get-Location) -Leaf) + "\n > "
# }
function prompt()
{
    $path = $pwd.path.Replace($HOME, "~")
    return "${path}`n$ "
}

function ExecuteCommand ($commandPath, $commandArguments) 
{ 
    $pinfo = New-Object System.Diagnostics.ProcessStartInfo 
    $pinfo.FileName = $commandPath 
    $pinfo.RedirectStandardError = $true 
    $pinfo.RedirectStandardOutput = $true 
    $pinfo.UseShellExecute = $false 
    $pinfo.Arguments = $commandArguments 
    $pinfo.WorkingDirectory = "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\"
    $p = New-Object System.Diagnostics.Process 
    $p.StartInfo = $pinfo 
    $p.Start() | Out-Null 
    $p.WaitForExit() 
    [pscustomobject]@{ 
        stdout = $p.StandardOutput.ReadToEnd() 
        stderr = $p.StandardError.ReadToEnd() 
        ExitCode = $p.ExitCode 
    } 
} 

function vcenv()
{ 
    $VSWHERE = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

    $vc_dir = &$VSWHERE -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
    # C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools
    $bat = "$vc_dir\VC\Auxiliary\Build\vcvars64.bat"
    Write-Output $bat

    $v = ExecuteCommand "${env:COMSPEC}" "/C $bat & set"
    Write-Output $v.stdout
}
# vcenv

function global:which($cmd)
{
    Get-Command $cmd | Format-List
}

function insertPath($path)
{
    if($env:Path -notcontains $path)
    {
        $env:Path = $path + ";" + $env:Path
    }
}

function addPath($path)
{
    if($env:Path -notcontains $path)
    {
        $env:Path = $env:Path + ";" + $path
    }
}

# addPath($env:USERPROFILE + "/prefix/bin")
# addPath($env:USERPROFILE + "\.deno\bin")
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
# addPath($env:USERPROFILE + "\local\src\nvim-win64\bin")

# $env:BAZEL_WINSDK_FULL_VERSION="10.0.22000.0"
# $env:BAZEL_VS="C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools"
# $env:BAZEL_VC="C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC"
# $env:BAZEL_VC_FULL_VERSION="14.29.30133" 2019
# $env:BAZEL_VC_FULL_VERSION="14.34.31933"

# if (Test-Path "D:/gnome") {
#     insertPath("D:\gnome\bin")
#     $env:PKG_CONFIG_PATH="D:/gnome/lib/pkgconfig;D:/gnome/share/pkgconfig"
# }

# New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
# Import-Module posh-git
# oh-my-posh init pwsh --config ~/.custom.omp.json | Invoke-Expression

# For zoxide v0.8.0+
Invoke-Expression (& {
        $hook = if ($PSVersionTable.PSVersion.Major -lt 6)
        { 'prompt' 
        } else
        { 'pwd' 
        }
    (zoxide init --hook $hook powershell | Out-String)
    })

# cd ghq
function gg
{
    $dst = $(ghq list -p| fzf --reverse +m)
    if($dst)
    {
        Set-Location "$dst"
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

function dotpull
{
    Push-Location ${env:HOME}/dotfiles
    git pull
    Pop-Location
}
# function apkget
# {
#     $apk = $(adb shell pm list packages -3 | fzf)
#     if($apk && $apk.startswith("package:"))
#     {
#         $apk = $apk.Trim()
#         $name = $apk.SubString(8)
#         Write-Output "name: ${name}"
# 
#         $tmp_name = $(adb shell pm path $name).Trim()
#         if($tmp_name && $tmp_name.startswith("package:"))
#         {
#             $path = $tmp_name.SubString(8)
#             Write-Output "path: ${path}"
#             adb pull "${path}" "${name}.apk"
#         }
#     }
# }

