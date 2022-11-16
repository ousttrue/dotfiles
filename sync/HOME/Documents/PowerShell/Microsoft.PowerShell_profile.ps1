$env:HOME = $env:USERPROFILE
$env:JAVA_HOME = $env:ANDROID_STUDIO_HOME + "\jre";

if($env:TERM_PROGRAM -ne "vscode"){
    chcp 65001
}

function Execute-Command ($commandPath, $commandArguments) 
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

function vcenv(){ 
    $VSWHERE = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

    $vc_dir = &$VSWHERE -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
# C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools
    $bat = "$vc_dir\VC\Auxiliary\Build\vcvars64.bat"
echo $bat

    $v = Execute-Command "${env:COMSPEC}" "/C $bat & set"
    echo $v.stdout
}
# vcenv

function global:which($cmd){
    gcm $cmd | fl
}

function insertPath($path){
    if($env:Path -notcontains $path){
        $env:Path = $path + ";" + $env:Path
    }
}

function addPath($path) {
    if($env:Path -notcontains $path){
        $env:Path = $env:Path + ";" + $path
    }
}

insertPath($env:USERPROFILE + "\.deno\bin")
insertPath($env:USERPROFILE + "\.cargo\bin")
insertPath($env:USERPROFILE + "\go\bin")
insertPath($env:USERPROFILE + "\local\bin")
addPath($env:USERPROFILE + "\AppData\Local\Programs\Microsoft VS Code")
addPath("C:\Program Files\Git\usr\bin")
if($env:JAVA_HOME -ne $null){
    addPath($env:JAVA_HOME + "\bin")
}
if($env:ANDROID_HOME -ne $null){
    addPath($env:ANDROID_HOME + "\platform-tools")
    addPath($env:ANDROID_HOME + "\ndk\21.4.7075529")
}
if($env:GRADLE_HOME -ne $null){
    addPath($env:GRADLE_HOME + "\bin")
}
if($env:GTK_DIR -ne $null)
{
    insertPath($env:GTK_DIR + "\bin")
}
if(Test-Path "C:\Python311")
{
    addPath("C:\Python311\Scripts")
    addPath("C:\Python311")
}
elseif(Test-Path "C:\Python310")
{
    addPath("C:\Python310\Scripts")
    addPath("C:\Python310")
}
elseif(Test-Path "C:\Python37")
{
    addPath("C:\Python37\Scripts")
    addPath("C:\Python37")
}
# readline
# https://learn.microsoft.com/en-us/powershell/module/psreadline/about/about_psreadline_functions?view=powershell-7.2
Set-PSReadlineKeyHandler -Key 'Ctrl+u' -Function BackwardDeleteLine
Set-PSReadlineKeyHandler -Key 'Ctrl+b' -Function BackwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+f' -Function ForwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+d' -Function DeleteChar
Set-PSReadlineKeyHandler -Key 'Ctrl+h' -Function BackwardDeleteChar
Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key 'Ctrl+a' -Function BeginningOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+e' -Function EndOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+m' -Function AcceptLine
Set-PSReadlineKeyHandler -Key 'Ctrl+k' -Function ForwardDeleteLine

# New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
Import-Module posh-git
oh-my-posh init pwsh --config ~/.custom.omp.json | Invoke-Expression

# For zoxide v0.8.0+
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

function gg {
    $dst = $(ghq list -p| fzf --reverse +m)
    if($dst){
        cd "$dst"
    }
}

function gs {
    $dst = $(git branch | fzf).Trim()
    if($dst)
    {
        git switch $dst
    }
}
function gsf {
    $dst = $(git branch | fzf).Trim()
    if($dst)
    {
        git switch -f $dst
    }
}

del alias:ls  # PowerShell 側の ls を削除
function ls() {
    lsd $args
}
function ll() {
    lsd -l $args
}
function la() {
    lsd -a $args
}
function glg(){
    git lga
}
function gcd(){
    cd $(git rev-parse --show-toplevel)
}
function gst(){
    git status -sb
}

function rmrf {
     <#
        .DESCRIPTION
        Deletes the specified file or directory.
        .PARAMETER target
        Target file or directory to be deleted.
        .NOTES
        This is an equivalent command of "rm -rf" in Unix-like systems.
        #>
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Target
    )
    Remove-Item -Recurse -Force $Target
}
function pipup {
    py -m pip install pip --upgrade
}
function dotpull {
    pushd ${env:HOME}/dotfiles
    git pull
    popd
}



