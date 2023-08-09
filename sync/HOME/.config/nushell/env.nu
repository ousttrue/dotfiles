# Nushell Environment Config File
#
# version = 0.83.1

let api = {
    holiday: "https://seireki.teraren.com/holiday/2023.json"
    emoji: "https://github.com/github/gemoji/raw/master/db/emoji.json"
    khronos: {
        gl: "https://github.com/KhronosGroup/OpenGL-Registry/raw/main/xml/gl.xml"
    }
    nerd: "https://github.com/ryanoasis/nerd-fonts/raw/master/glyphnames.json"
}

use ~/.config/nushell/jma.nu
use ~/.config/nushell/gin.nu
# https://github.com/nushell/nu_scripts/blob/main/custom-completions/git/git-completions.nu
use ~/.config/nushell/git-completions.nu

def get_home [] {
    if $nu.os-info.name == "windows" {
        $env.USERPROFILE
    } else {
        $env.HOME
    }
}

def get_dir [] {
    mut home = ""
    try {
        $home = (get_home)
    }
 # 
    let path = [
        ($env.PWD | str substring 0..($home | str length) | str replace --string $home "🏠"),
        ($env.PWD | str substring ($home | str length)..)
    ] | str join


    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    # let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_blue_bold })

    let path = $path | str replace --all --string (char path_sep) "/"

    let path = $path | str replace --string "github.com" " "

    $path
}

def create_left_prompt [] {

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "0" }

    def push [stat, text, fg, bg] {
        {
            text: $"($stat.text) (ansi {fg: $stat.bg, bg: $bg}) (ansi {fg: $fg bg: $bg})($text)"
            bg: $bg
        }
    }

    def branch_name [stat] {
        let g = gstat
        if ($g.repo_name != 'no_repository') {
            if (($g.branch == 'master') or ($g.branch == 'main')) {
                (push $stat $" ($g.branch)" white green)
            } else {
                (push $stat $" ($g.branch)" white red) 
            }
        } else {
            $stat
        }
    }

    let stat = {
        text: $"(ansi {fg:black bg:yellow})(get_dir)"
        bg: yellow
    }
    let stat = (branch_name $stat)
    let stat = (push $stat "" default default)

    $"($stat.text)\n($last_exit_code)"
}

def create_right_prompt [] {
    let g = gstat
    if ($g.repo_name != 'no_repository') {
        mut info = ""
        if ($g.wt_untracked > 0 
            or $g.wt_modified > 0 
            or $g.wt_deleted > 0 
            or $g.wt_type_changed > 0 
            or $g.wt_renamed > 0 
        ) {
            $info += $"(ansi {fg:black bg:red})*"
        }
        $info
    } else {
        ""
    }
}

# Use nushell functions to define your right and left prompt
# $env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
$env.NU_LIB_DIRS = [
    # ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
$env.NU_PLUGIN_DIRS = [
    # ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

let packs = open $"(get_home)/dotfiles/dotpack.yml"

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

# alias ll = (ls | grid -c)
def la [] { ls -a | where name !~ 'NTUSER.DAT' | where name !~ 'Microsoft.' | grid -c }
def ll [] { ls -l | where name !~ 'NTUSER.DAT' | where name !~ 'Microsoft.' }
alias v = nvim

# ghq go
def-env gg [] {
    ghq list --full-path | fzf --preview $"bat --color=always --style=header,grid --line-range :80 {}/README.*" | decode utf-8 | str trim | cd $in
}

# git switch
def nfzf [] {
    to text | fzf --preview "git show --color=always {}" | str trim
}

# meson wrap 
def mewrap [] {
    meson wrap list | fzf --preview "meson wrap info{}" | str trim | meson wrap install $in
}

# fdir
def fz [path] {
    rg --files $path | fzf --preview $"bat --color=always {}"
}

def "cargo search" [ query: string, --limit=10] { 
    ^cargo search $query --limit $limit
    | lines 
    | each { 
        |line| if ($line | str contains "#") { 
            $line | parse --regex '(?P<name>.+) = "(?P<version>.+)" +# (?P<description>.+)' 
        } else { 
            $line | parse --regex '(?P<name>.+) = "(?P<version>.+)"' 
        } 
    } 
    | flatten
}

def today [] {
    seq date | into datetime | get 0
}

def get_day [d] {
    let day = if ($d == (today)) {
        $d | date format "(%a)"
    } else {
        $d | date format " %a "
    }
    let holiday = (get_holiday $d)
    if ($holiday | is-empty) {
        $day
    } else {
        $"($day)($holiday)"
    }
}

def get_holiday [d] {
    let holiday = http get $api.holiday | update date {|| into datetime} | where date == $d

    if ($holiday | is-empty) {
        ""
    } else {
        $holiday | get 0.name
    }
}

def week [] {
    let week_day = date now | date format "%w" | into int
    let mon = date now | $in - 1day * ($week_day + 7) | date format "%Y-%m-%d"
    let week = seq date --begin-date $mon --days 13 | into datetime

    $week | each {|d| date to-record | {
        today: (get_day $d)
        month: $in.month
        day: $in.day
        weather: (jma weather $d)
    }}
}

def day [] {
    let h = date now | date format "%H" | into int
    seq 1 24 | each {|e|
        if ( $e == $h ) {
            $"*($e)"
        } else {
            $" ($e)"
        }
    }
}

def "github releases" [] {
    http get $"https://api.github.com/repos/($in)/releases" | select name tag_name published_at
}

def vswhere [] {
    `C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe` -products '*' -format json | from json
}


def area_completion [] { ["centers", "offices", "class10s", "class15s", "class20s"] }

def children [] {
    each {|e| $e | flatten $e.children }
}

# def "jma offices" [] {
#     http get $jma.area | get offices | transpose c0 c1 | each {|e| {office:$e.c0} | merge $e.c1}
# }
# def "jma class10s" [] {
#     http get $jma.area | get offices | transpose c0 c1 | each {|e| {office:$e.c0} | merge $e.c1}
# }
# def "jma class10s" [] {
#     http get $jma.area | get offices | transpose c0 c1 | each {|e| {office:$e.c0} | merge $e.c1}
# }
# def "jma class10s" [] {
#     http get $jma.area | get offices | transpose c0 c1 | each {|e| {office:$e.c0} | merge $e.c1}
# }

def emoji_category [] {
    [
       '"Smileys & Emotion"'
       '"People & Body"'
       '"Animals & Nature"'
       '"Food & Drink"'
       '"Travel & Places"'
       '"Activities"'
       '"Objects"'
       '"Symbols"'
       '"Flags"'
    ] 
}

def "emoji get" [category:string@emoji_category] {
    http get $api.emoji | where category == $category
}

# Code generated by zoxide. DO NOT EDIT.

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
if (not ($env | default false __zoxide_hooked | get __zoxide_hooked)) {
  $env.__zoxide_hooked = true
  $env.config = ($env | default {} config).config
  $env.config = ($env.config | default {} hooks)
  $env.config = ($env.config | update hooks ($env.config.hooks | default {} env_change))
  $env.config = ($env.config | update hooks.env_change ($env.config.hooks.env_change | default [] PWD))
  $env.config = ($env.config | update hooks.env_change.PWD ($env.config.hooks.env_change.PWD | append {|_, dir|
    zoxide add -- $dir
  }))
}

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

# Jump to a directory using only keywords.
def-env __zoxide_z [...rest:string] {
  let arg0 = ($rest | append '~').0
  let path = if (($rest | length) <= 1) and ($arg0 == '-' or ($arg0 | path expand | path type) == dir) {
    $arg0
  } else {
    (zoxide query --exclude $env.PWD -- $rest | str trim -r -c "\n")
  }
  cd $path
}

# Jump to a directory using interactive search.
def-env __zoxide_zi  [...rest:string] {
  cd $'(zoxide query --interactive -- $rest | str trim -r -c "\n")'
}

def printcolors [] {
  [30 40 90 100] | each { |color_offset|
    range 0..9 | each { |color|
      if color != 8 { # 8 is not a color code
        range 1..9 | each { |style|
          $"\e[($color + $color_offset);($style)m" + $'\e[($color + $color_offset)($style)m' + "\e[0m"
        } | str join
      }
    } | flatten
  } | flatten
}

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

alias z = __zoxide_z
alias zi = __zoxide_zi

# =============================================================================
#
# Add this to your env file (find it by running `$nu.env-path` in Nushell):
#
#   zoxide init nushell | save -f ~/.zoxide.nu
#
# Now, add this to the end of your config file (find it by running
# `$nu.config-path` in Nushell):
#
#   source ~/.zoxide.nu
#
# Note: zoxide only supports Nushell v0.73.0 and above.

if $nu.os-info.name == "windows" {
    $env.Path += ";C:\\Python310"
    $env.Path += ";C:\\Python310\\Scripts"
    $env.Path += $";(get_home)\\.cargo\\bin"
    $env.Path += $";(get_home)\\local\\bin"
    $env.Path += ";C:\\Program Files\\git\\usr\\bin"
}

$env.FZF_DEFAULT_OPTS = "--preview-window=top:60%,border-bottom --preview 'bat --color=always {}'"
