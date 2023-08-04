# Nushell Environment Config File
#
# version = 0.83.1

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

# ghq go
def-env gg [] {
    ghq list --full-path | fzf --preview $"bat --color=always --style=header,grid --line-range :80 {}/README.*" | decode utf-8 | str trim | cd $in
}

# git switch
def nfzf [] {
    to text | fzf --preview "git show --color=always {}" | str trim
}

def gs [] {
    git branch | lines | str trim | where { |s| 
        let xx = $s | str substring 0..2
        $xx != "* "
    } | str join "\n" | fzf --preview "git show --color=always {}" | str trim | git switch $in
}

# meson wrap 
def mewrap [] {
    meson wrap list | fzf --preview "meson wrap info{}" | str trim | meson wrap install $in
}

# fdir
def fz [path] {
    rg --files $path | fzf --preview $"bat --color=always {}"
}

def gt [] {
    git status
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
    seq date | get 0
}

def get_day [] {
    if ($in == (today)) {
        date format "(%a)"
    } else {
        date format "%a"
    }
}

def week [] {
    let week_day = date now | date format "%w" | into int
    let mon = date now | $in - 1day * ($week_day - 1) | date format "%Y-%m-%d"
    let week = seq date --begin-date $mon --days 14

    $week | each {|d| date to-record | {
        today: ($d | get_day)
        month: $in.month
        day: $in.day
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

let jma_area = if ("JMA_AREA" in $env) {
    $env.JMA_AREA
} else {
    "130000"
}

let weather_codes = [
  ["100", "晴", "CLEAR"],
  ["101", "晴時々曇", "PARTLY CLOUDY"],
  ["102", "晴一時雨", "CLEAR, OCCASIONAL SCATTERED SHOWERS"],
  ["103", "晴時々雨", "CLEAR, FREQUENT SCATTERED SHOWERS"],
  ["104", "晴一時雪", "CLEAR, SNOW FLURRIES"],
  ["105", "晴時々雪", "CLEAR, FREQUENT SNOW FLURRIES"],
  [
    "106",
    "晴一時雨か雪",
    "CLEAR, OCCASIONAL SCATTERED SHOWERS OR SNOW FLURRIES"
  ],
  ["107", "晴時々雨か雪", "CLEAR, FREQUENT SCATTERED SHOWERS OR SNOW FLURRIES"],
  [
    "108",
    "晴一時雨か雷雨",
    "CLEAR, OCCASIONAL SCATTERED SHOWERS AND/OR THUNDER"
  ],
  ["110", "晴後時々曇", "CLEAR, PARTLY CLOUDY LATER"],
  ["111", "晴後曇", "CLEAR, CLOUDY LATER"],
  ["112", "晴後一時雨", "CLEAR, OCCASIONAL SCATTERED SHOWERS LATER"],
  ["113", "晴後時々雨", "CLEAR, FREQUENT SCATTERED SHOWERS LATER"],
  ["114", "晴後雨", "CLEAR,RAIN LATER"],
  ["115", "晴後一時雪", "CLEAR, OCCASIONAL SNOW FLURRIES LATER"],
  ["116", "晴後時々雪", "CLEAR, FREQUENT SNOW FLURRIES LATER"],
  ["117", "晴後雪", "CLEAR,SNOW LATER"],
  ["118", "晴後雨か雪", "CLEAR, RAIN OR SNOW LATER"],
  ["119", "晴後雨か雷雨", "CLEAR, RAIN AND/OR THUNDER LATER"],
  [
    "120",
    "晴朝夕一時雨",
    "OCCASIONAL SCATTERED SHOWERS IN THE MORNING AND EVENING, CLEAR DURING THE DAY"
  ],
  [
    "121",
    "晴朝の内一時雨",
    "OCCASIONAL SCATTERED SHOWERS IN THE MORNING, CLEAR DURING THE DAY"
  ],
  ["122", "晴夕方一時雨", "CLEAR, OCCASIONAL SCATTERED SHOWERS IN THE EVENING"],
  [
    "123",
    "晴山沿い雷雨",
    "CLEAR IN THE PLAINS, RAIN AND THUNDER NEAR MOUTAINOUS AREAS"
  ],
  ["124", "晴山沿い雪", "CLEAR IN THE PLAINS, SNOW NEAR MOUTAINOUS AREAS"],
  ["125", "晴午後は雷雨", "CLEAR, RAIN AND THUNDER IN THE AFTERNOON"],
  ["126", "晴昼頃から雨", "CLEAR, RAIN IN THE AFTERNOON"],
  ["127", "晴夕方から雨", "CLEAR, RAIN IN THE EVENING"],
  ["128", "晴夜は雨", "CLEAR, RAIN IN THE NIGHT"],
  ["130", "朝の内霧後晴", "FOG IN THE MORNING, CLEAR LATER"],
  ["131", "晴明け方霧", "FOG AROUND DAWN, CLEAR LATER"],
  [
    "132",
    "晴朝夕曇",
    "CLOUDY IN THE MORNING AND EVENING, CLEAR DURING THE DAY"
  ],
  [
    "140",
    "晴時々雨で雷を伴う",
    "CLEAR, FREQUENT SCATTERED SHOWERS AND THUNDER"
  ],
  [
    "160",
    "晴一時雪か雨",
    "CLEAR, SNOW FLURRIES OR OCCASIONAL SCATTERED SHOWERS"
  ],
  ["170", "晴時々雪か雨", "CLEAR, FREQUENT SNOW FLURRIES OR SCATTERED SHOWERS"],
  ["181", "晴後雪か雨", "CLEAR, SNOW OR RAIN LATER"],
  ["200", "曇", "CLOUDY"],
  ["201", "曇時々晴", "MOSTLY CLOUDY"],
  ["202", "曇一時雨", "CLOUDY, OCCASIONAL SCATTERED SHOWERS"],
  ["203", "曇時々雨", "CLOUDY, FREQUENT SCATTERED SHOWERS"],
  ["204", "曇一時雪", "CLOUDY, OCCASIONAL SNOW FLURRIES"],
  ["205", "曇時々雪", "CLOUDY FREQUENT SNOW FLURRIES"],
  [
    "206",
    "曇一時雨か雪",
    "CLOUDY, OCCASIONAL SCATTERED SHOWERS OR SNOW FLURRIES"
  ],
  [
    "207",
    "曇時々雨か雪",
    "CLOUDY, FREQUENT SCCATERED SHOWERS OR SNOW FLURRIES"
  ],
  [
    "208",
    "曇一時雨か雷雨",
    "CLOUDY, OCCASIONAL SCATTERED SHOWERS AND/OR THUNDER"
  ],
  ["209", "霧", "FOG"],
  ["210", "曇後時々晴", "CLOUDY, PARTLY CLOUDY LATER"],
  ["211", "曇後晴", "CLOUDY, CLEAR LATER"],
  ["212", "曇後一時雨", "CLOUDY, OCCASIONAL SCATTERED SHOWERS LATER"],
  ["213", "曇後時々雨", "CLOUDY, FREQUENT SCATTERED SHOWERS LATER"],
  ["214", "曇後雨", "CLOUDY, RAIN LATER"],
  ["215", "曇後一時雪", "CLOUDY, SNOW FLURRIES LATER"],
  ["216", "曇後時々雪", "CLOUDY, FREQUENT SNOW FLURRIES LATER"],
  ["217", "曇後雪", "CLOUDY, SNOW LATER"],
  ["218", "曇後雨か雪", "CLOUDY, RAIN OR SNOW LATER"],
  ["219", "曇後雨か雷雨", "CLOUDY, RAIN AND/OR THUNDER LATER"],
  [
    "220",
    "曇朝夕一時雨",
    "OCCASIONAL SCCATERED SHOWERS IN THE MORNING AND EVENING, CLOUDY DURING THE DAY"
  ],
  [
    "221",
    "曇朝の内一時雨",
    "CLOUDY OCCASIONAL SCCATERED SHOWERS IN THE MORNING"
  ],
  [
    "222",
    "曇夕方一時雨",
    "CLOUDY, OCCASIONAL SCCATERED SHOWERS IN THE EVENING"
  ],
  [
    "223",
    "曇日中時々晴",
    "CLOUDY IN THE MORNING AND EVENING, PARTLY CLOUDY DURING THE DAY,"
  ],
  ["224", "曇昼頃から雨", "CLOUDY, RAIN IN THE AFTERNOON"],
  ["225", "曇夕方から雨", "CLOUDY, RAIN IN THE EVENING"],
  ["226", "曇夜は雨", "CLOUDY, RAIN IN THE NIGHT"],
  ["228", "曇昼頃から雪", "CLOUDY, SNOW IN THE AFTERNOON"],
  ["229", "曇夕方から雪", "CLOUDY, SNOW IN THE EVENING"],
  ["230", "曇夜は雪", "CLOUDY, SNOW IN THE NIGHT"],
  [
    "231",
    "曇海上海岸は霧か霧雨",
    "CLOUDY, FOG OR DRIZZLING ON THE SEA AND NEAR SEASHORE"
  ],
  [
    "240",
    "曇時々雨で雷を伴う",
    "CLOUDY, FREQUENT SCCATERED SHOWERS AND THUNDER"
  ],
  ["250", "曇時々雪で雷を伴う", "CLOUDY, FREQUENT SNOW AND THUNDER"],
  [
    "260",
    "曇一時雪か雨",
    "CLOUDY, SNOW FLURRIES OR OCCASIONAL SCATTERED SHOWERS"
  ],
  [
    "270",
    "曇時々雪か雨",
    "CLOUDY, FREQUENT SNOW FLURRIES OR SCATTERED SHOWERS"
  ],
  ["281", "曇後雪か雨", "CLOUDY, SNOW OR RAIN LATER"],
  ["300", "雨", "RAIN"],
  ["301", "雨時々晴", "RAIN, PARTLY CLOUDY"],
  ["302", "雨時々止む", "SHOWERS THROUGHOUT THE DAY"],
  ["303", "雨時々雪", "RAIN,FREQUENT SNOW FLURRIES"],
  ["304", "雨か雪", "RAINORSNOW"],
  ["306", "大雨", "HEAVYRAIN"],
  ["308", "雨で暴風を伴う", "RAINSTORM"],
  ["309", "雨一時雪", "RAIN,OCCASIONAL SNOW"],
  ["311", "雨後晴", "RAIN,CLEAR LATER"],
  ["313", "雨後曇", "RAIN,CLOUDY LATER"],
  ["314", "雨後時々雪", "RAIN, FREQUENT SNOW FLURRIES LATER"],
  ["315", "雨後雪", "RAIN,SNOW LATER"],
  ["316", "雨か雪後晴", "RAIN OR SNOW, CLEAR LATER"],
  ["317", "雨か雪後曇", "RAIN OR SNOW, CLOUDY LATER"],
  ["320", "朝の内雨後晴", "RAIN IN THE MORNING, CLEAR LATER"],
  ["321", "朝の内雨後曇", "RAIN IN THE MORNING, CLOUDY LATER"],
  [
    "322",
    "雨朝晩一時雪",
    "OCCASIONAL SNOW IN THE MORNING AND EVENING, RAIN DURING THE DAY"
  ],
  ["323", "雨昼頃から晴", "RAIN, CLEAR IN THE AFTERNOON"],
  ["324", "雨夕方から晴", "RAIN, CLEAR IN THE EVENING"],
  ["325", "雨夜は晴", "RAIN, CLEAR IN THE NIGHT"],
  ["326", "雨夕方から雪", "RAIN, SNOW IN THE EVENING"],
  ["327", "雨夜は雪", "RAIN,SNOW IN THE NIGHT"],
  ["328", "雨一時強く降る", "RAIN, EXPECT OCCASIONAL HEAVY RAINFALL"],
  ["329", "雨一時みぞれ", "RAIN, OCCASIONAL SLEET"],
  ["340", "雪か雨", "SNOWORRAIN"],
  ["350", "雨で雷を伴う", "RAIN AND THUNDER"],
  ["361", "雪か雨後晴", "SNOW OR RAIN, CLEAR LATER"],
  ["371", "雪か雨後曇", "SNOW OR RAIN, CLOUDY LATER"],
  ["400", "雪", "SNOW"],
  ["401", "雪時々晴", "SNOW, FREQUENT CLEAR"],
  ["402", "雪時々止む", "SNOWTHROUGHOUT THE DAY"],
  ["403", "雪時々雨", "SNOW,FREQUENT SCCATERED SHOWERS"],
  ["405", "大雪", "HEAVYSNOW"],
  ["406", "風雪強い", "SNOWSTORM"],
  ["407", "暴風雪", "HEAVYSNOWSTORM"],
  ["409", "雪一時雨", "SNOW, OCCASIONAL SCCATERED SHOWERS"],
  ["411", "雪後晴", "SNOW,CLEAR LATER"],
  ["413", "雪後曇", "SNOW,CLOUDY LATER"],
  ["414", "雪後雨", "SNOW,RAIN LATER"],
  ["420", "朝の内雪後晴", "SNOW IN THE MORNING, CLEAR LATER"],
  ["421", "朝の内雪後曇", "SNOW IN THE MORNING, CLOUDY LATER"],
  ["422", "雪昼頃から雨", "SNOW, RAIN IN THE AFTERNOON"],
  ["423", "雪夕方から雨", "SNOW, RAIN IN THE EVENING"],
  ["425", "雪一時強く降る", "SNOW, EXPECT OCCASIONAL HEAVY SNOWFALL"],
  ["426", "雪後みぞれ", "SNOW, SLEET LATER"],
  ["427", "雪一時みぞれ", "SNOW, OCCASIONAL SLEET"],
  ["450", "雪で雷を伴う", "SNOW AND THUNDER"]
] | each {|e| {code: $e.0, name: $e.1, eng: $e.2}}
let jma = {
    area: "https://www.jma.go.jp/bosai/common/const/area.json"
    overview: $"https://www.jma.go.jp/bosai/forecast/data/overview_forecast/($jma_area).json"
    forecast: $"https://www.jma.go.jp/bosai/forecast/data/forecast/($jma_area).json"

}

def area_completion [] { ["centers", "offices", "class10s", "class15s", "class20s"] }

def children [] {
    each {|e| $e | flatten $e.children }
}

def "jma area" [key: string@area_completion] {
    # centers
    http get $jma.area | get $key | transpose c0 c1 | each {|e| {$key:$e.c0}|merge $e.c1}
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

let api = {
    holiday: "https://seireki.teraren.com/holiday/2023.json"
    emoji: "https://github.com/github/gemoji/raw/master/db/emoji.json"
    khronos: {
        gl: "https://github.com/KhronosGroup/OpenGL-Registry/raw/main/xml/gl.xml"
    }
}

def emoji_category [] {
    [
        "Smileys & Emotion"
        "People & Body"
        "Animals & Nature"
        "Food & Drink"
        "Travel & Places"
        "Activities"
        "Objects"
        "Symbols"
        "Flags"
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
}
