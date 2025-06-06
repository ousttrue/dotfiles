# https://stackoverflow.com/questions/46577686/some-imported-command-names-contain-one-or-more-of-the-following-restricted-char

function Set-Prefix
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )
  # $prefix = Join-Path $HOME "local"
  $env:INCLUDE += ";$prefix\include"
  $env:LIB += ";$prefix\lib"
  $env:PKG_CONFIG_PATH = Join-Path $prefix "lib\pkgconfig"
  $env:GI_EXTRA_BASE_DLL_DIRS = "$prefix\bin" 
}

function Install-muon
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )

  ghq get https://github.com/annacrombie/muon
  Push-Location (Join-Path (ghq root) "/github.com/annacrombie/muon")
  meson setup builddir --prefix $prefix
  meson install -C builddir
  Pop-Location
}

function Install-win32yank
{
  mkdir -p ~/local/src
  Push-Location ~/local/src
  curl -L -O https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
  unzip ./win32yank-x64.zip win32yank.exe
  mkdir -p ~/local/bin
  Move-Item -force win32yank.exe ~/local/bin/win32yank.exe
  chmod +x ~/local/bin/win32yank.exe
  Pop-Location
}

function Install-all
{
  Install-go
  Install-nvim
  Install-rust
  Install-muon
  Install-deno
  Install-skk-dictionary
}


function Install-deno
{
  if($IsWindows)
  {
    Invoke-RestMethod https://deno.land/install.ps1 | Invoke-Expression
  } else
  {
    curl -fsSL https://deno.land/install.sh | sh
  }
}

function Install-skk_dictionary
{
  Download "https://github.com/skk-dev/dict/raw/master/SKK-JISYO.L" "$HOME/.skk/SKK-JISYO.L"
}

function Install-font
{
  mkdir -p ~/.fonts
  Push-Location ~/.fonts
  curl -L -O https://github.com/yuru7/HackGen/releases/download/v2.9.0/HackGen_NF_v2.9.0.zip
  unzip HackGen_NF_v2.9.0.zip
  Pop-Location
  fc-cache -fv
}


function Install-go
{
  if (!(has go))
  {
    if (!$IsWindows)
    {
      # curl -L -O --trust-server-names https://go.dev/dl/go1.21.6.linux-amd64.tar.gz
      mkdir -p $HOME/Downloads
      $archive = Download "https://go.dev/dl/go1.21.6.linux-amd64.tar.gz" $HOME/Downloads
      sudo rm -rf /usr/local/go
      sudo tar -C /usr/local -xzf $archive

      addPath("/usr/local/go/bin")
    }
  }

  go install github.com/x-motemen/ghq@latest
  mkdir -p $(ghq root)

  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf

  if ($IsWindows)
  {
    &"$HOME/.fzf/install.ps1"
  } else
  {
    &"$HOME/.fzf/install"
  }

  go install github.com/noborus/ov@latest

  go install github.com/jesseduffield/lazygit@latest
}

function Install-rust
{
  if (!$IsWindows)
  {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  }
  cargo install zoxide ripgrep fd-find bottom lsd bat stylua tree-sitter-cli xremap git-delta
  if ($IsWindows)
  {
    cargo install coreutils --features windows
  }
  cargo install gitui --locked
}


function Install-ruby
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )

  # Install-libyaml
  # Install-openssl
  # ruby
  New-Item "$prefix/src" -ItemType Directory -ErrorAction SilentlyContinue
  Set-Location "$HOME\local\src"
  $url = "https://cache.ruby-lang.org/pub/ruby/3.3/ruby-3.3.0.tar.gz"
  Invoke-WebRequest -Uri $url -OutFile "ruby-3.3.0.tar.gz"
  tar xf "ruby-3.3.0.tar.gz"
  Push-Location ruby-3.3.0
  Pop-Location
}

# https://doc.qt.io/qt-6/windows-building.html
function Install-qt
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )
  $src = Join-Path $prefix "src"
  New-Item $src -ItemType Directory -ErrorAction SilentlyContinue
  $archive = Download "https://download.qt.io/archive/qt/6.7/6.7.0/single/qt-everywhere-src-6.7.0.tar.xz" $src
  Extract $archive $src 

  $build = Join-Path $prefix "build"
  New-Item $build -ItemType Directory -ErrorAction SilentlyContinue
  Push-Location $build
  ../src/qt-everywhere-src-6.7.0/configure.bat -prefix $prefix -make examples -debug-and-release 
  cmake --build . --parallel
  cmake --install .
  Pop-Location
}

function Install-yay
{
  Push-Location $HOME
  pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git
  Push-Location yay
  makepkg -si
  Pop-Location

  git clone https://github.com/moson-mo/pacseek.git
  Push-Location pacseek
  go install .
  Pop-Location
  Pop-Location
}

function Install-exe($src, $dst)
{
  New-Item -ItemType File -Path $dst -Force
  Copy-Item $src $dst -Force
}

# m4
function Install-flex
{
  param(
    [Parameter(Mandatory=$true)]
    [string]$prefix
  )

  $url = "https://github.com/lexxmark/winflexbison/releases/download/v2.5.25/win_flex_bison-2.5.25.zip"
  if (!(has win_flex))
  {
    $download_dir = "$HOME/Downloads"
    $archive = Download $url $download_dir
    $dir = Extract $archive $download_dir
    $bin_dir = Join-Path $prefix "bin"
    New-Item $bin_dir -ItemType Directory -ErrorAction SilentlyContinue
    Copy-Item -Recurse -Force $dir/* -Destination $bin_dir
  }
}

function Install-gperf
{
  param(
    [Parameter(Mandatory=$true)]
    [string]$prefix
  )

  # $url = "https://gnuwin32.sourceforge.net/downlinks/gperf-bin-zip.php"
  $url = "https://github.com/leok7v/gnuwin32.mirror/raw/master/bin/gperf.exe"
  if (!(has gperf))
  {
    $dst = Join-Path $prefix "bin/gperf.exe"
    New-Item $dst -ErrorAction SilentlyContinue
    Remove-Item $dst
    Download $url $dst
    # $dir = Extract $archive $download_dir
    # Install-exe (Join-Path $dir "bin/gperf.exe") (Join-Path $prefix "bin/gperf.exe")
  }
}

function Install-tools
{
  param(
    [Parameter(Mandatory=$true)]
    [string]$prefix
  )

  Install-flex $prefix
  Install-gperf $prefix
  if (!(has meson))
  {
    pip install meson
  }
  if (!(has cmake))
  {
    pip install cmake
  }
  if (!(has ninja))
  {
    pip install ninja
  }
  pip install packaging setuptools
}

function Install-glib
{
  param(
    [Parameter(Mandatory=$true)]
    [string]$prefix
  )

  Install-tools $prefix

  $repos = "github.com/GNOME/glib"

  ghq get $repos
  Push-Location (Join-Path (ghq root) $repos)
  Get-Location
  if (Test-Path builddir)
  {
    Remove-Item -Recurse -Force builddir
  }

  $use_i="disabled"
  if(has gi-inspect-typelib.exe)
  {
    $use_i="enabled"
  }
  meson setup builddir --prefix $prefix -Dbuildtype=release "-Dintrospection=$use_i"

  meson install -C builddir
  Pop-Location

  Copy-Item $prefix/lib/libpcre2-8.a $prefix/lib/pcre2-8.lib
}

function Install-pkgconfig
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )
  $repos = "gitlab.freedesktop.org/pkg-config/pkg-config"
  ghq get $repos
  Push-Location (Join-Path (ghq root) $repos)
  Copy-Item config.h.win32.in config.h.win32
  $env:INCLUDE += ";$prefix\include\glib-2.0;$prefix\lib\glib-2.0\include"
  nmake /f Makefile.vc CFG=release
  Copy-Item release/x64/pkg-config.exe $prefix/bin/pkg-config.exe
  Pop-Location
}

function Install-gobjecgtintrospection
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )
  Install-glib $prefix
  Install-pkgconfig $prefix

  $repos = "github.com/GNOME/gobject-introspection"
  ghq get $repos
  Push-Location (Join-Path (ghq root) $repos)
  if (Test-Path builddir)
  {
    Remove-Item -Recurse -Force builddir
  }

  # G_ALWAYS_INLINE
  $env:LIB+=";$prefix\lib"
  
  meson setup builddir -Dtests=false --prefix $prefix -Dbuildtype=release
  meson install -C builddir
  Pop-Location
}

function Install-cairo
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )
  $repos = "gitlab.freedesktop.org/cairo/cairo"
  ghq get $repos
  Push-Location (Join-Path (ghq root) $repos)
  if (Test-Path builddir)
  {
    Remove-Item -Recurse -Force builddir
  }
  meson setup builddir --prefix $prefix -Dbuildtype=release -Dfontconfig=enabled -Dfreetype=enabled
  meson install -C builddir
  Pop-Location
}

function Install-gst
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )
  ghq get https://github.com/GStreamer/gstreamer
  Push-Location (Join-Path (ghq root) "github.com\GStreamer/gstreamer")
  Get-Location
  if (Test-Path builddir)
  {
    Remove-Item -Recurse -Force builddir
  }
  # meson setup builddir --prefix $prefix -Dbuildtype=release -Dbad=disabled
  # meson setup builddir --prefix $prefix -Dbuildtype=release -Dbad=enabled -Dgst-plugins-bad:vulkan=disabled
  meson setup builddir --prefix $prefix -Dbuildtype=release -Dbad=enabled -Dgst-plugins-bad:d3d12=disabled
  meson install -C builddir
  Pop-Location
}

function Install-gtk
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )
  # Install-glib $prefix
  # Install-pkgconfig $prefix
  # Install-gobjecgt-introspection $prefix
  # Install-glib $prefix
  # Install-cairo $prefix

  $repos = "github.com/GNOME/gtk"
  ghq get $repos
  Push-Location (Join-Path (ghq root) $repos)
  Get-Location
  if (Test-Path builddir)
  {
    Remove-Item -Recurse -Force builddir
  }
  meson setup builddir --prefix $prefix -Dbuildtype=release -Dmedia-gstreamer=disabled -Dbuild-tests=false -Dbuild-testsuite=false -Dintrospection=enabled
  # meson setup builddir --prefix $prefix -Dbuildtype=release -Dbuild-tests=false -Dbuild-testsuite=false -Dintrospection=enabled
  meson install -C builddir
  Pop-Location
}

function Install-gtkmm
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )
  # doxygen
  # graphviz
  # cmake -G Ninja -S . -B build -DCMAKE_BUILD_TYPE=Release -Dwith_gvedit=OFF
  # cmake -G Ninja -S . -B build -DCMAKE_BUILD_TYPE=Release -DLIBXML2_WITH_ICONV=OFF -DLIBXML2_WITH_LZMA=OFF -DLIBXML2_WITH_ZLIB=OFF -DLIBXML2_WITH_PYTHON=OFF
  # cmake -G Ninja -S . -B build -DCMAKE_BUILD_TYPE=Release -DLIBXSLT_WITH_PYTHON=OFF
}

function Install-pygobject
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )
  $repos = "gitlab.gnome.org/GNOME/pygobject"
  ghq get $repos
  Push-Location (Join-Path (ghq root) $repos)
  Get-Location
  if (Test-Path builddir)
  {
    Remove-Item -Recurse -Force builddir
  }
  meson setup builddir -Dtests=false -Dpycairo=disabled --prefix $prefix -Dbuildtype=release
  meson install -C builddir
  Pop-Location
}

function Install-elixir
{
  sudo apt install inotify-tools
}`

function Install-adb
{
  param(
    [Parameter(Mandatory=$true)]
    [string]$prefix
  )
  if(!(Test-Path $jbr_dir))
  {
    New-Item (Split-Path -Parent $prefix) -ItemType Directory -ErrorAction SilentlyContinue
    $url = "https://cache-redirector.jetbrains.com/intellij-jbr/jbr_jcef-17.0.10-windows-x64-b1207.14.tar.gz"
    $archive = download $url $prefix
    $dir = extract $archive $prefix
  }
}

function Install-godot
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )
  $src = Join-Path $prefix "src"
  New-Item $src -ItemType Directory -ErrorAction SilentlyContinue
  $url = "https://github.com/godotengine/godot/releases/download/4.2.1-stable/godot-4.2.1-stable.tar.xz"
  $archive = Download $url $src
  Extract $archive $src 
}

# https://matsuand.github.io/docs.docker.jp.onthefly/engine/install/ubuntu/
function Install-docker
{
  sudo apt-get update
  sudo apt-get install ca-certificates curl gnupg lsb-release
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  bash -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null'
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
}

$ASDF_DIR = Join-Path $HOME ".asdf"
$ASDF = Join-Path $ASDF_DIR "asdf.ps1"
function Install-asdf
{
  if(Test-Path $ASDF_DIR)
  {
    Get-Item $ASDF_DIR
  } else
  {
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
  }
  . $ASDF
}
# asdf
if(Test-Path $ASDF)
{
  . $ASDF
}

function Install-libyaml
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )

  $dir = Join-Path (ghq root) "github.com/yaml/libyaml"
  if (Test-Path $dir)
  {
    Push-Location $dir
    git pull
  } else
  {
    ghq get https://github.com/yaml/libyaml
    Push-Location $dir
  }
  cmake -G Ninja -S . -B build -DCMAKE_BUILD_TYPE=Release
  cmake --build build
  cmake --install build --prefix $prefix
  Pop-Location
}

function Install-openssl
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )

  $dir = Join-Path (ghq root) "github.com\ousttrue\w3m\subprojects\openssl-3.0.8"
  Push-Location $dir
  Remove-Item -Recurse -Force builddir
  meson setup builddir --prefix $prefix
  meson install -C builddir
  New-Item "$prefix/include" -ItemType Directory -ErrorAction SilentlyContinue

  Copy-Item -Recurse .\generated-config\archs\VC-WIN64A\asm\include\progs.h "$prefix/include/progs.h"

  $include_openssl = "$HOME\local\include\openssl"
  if (Test-Path $include_openssl)
  {
    Remove-Item -Recurse -Force $include_openssl
  }
  Copy-Item -Recurse .\generated-config\archs\VC-WIN64A\asm\include\openssl $include_openssl

  $include_crypto = "$HOME\local\include\crypto"
  if (Test-Path $include_crypto)
  {
    Remove-Item -Recurse -Force $include_crypto
  }
  Copy-Item -Recurse .\generated-config\archs\VC-WIN64A\asm\include\crypto $include_crypto

  Pop-Location
}

function Set-SSl
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )
  $env:OPENSSL_LIB_DIR="$prefix\lib"
  $env:OPENSSL_INCLUDE_DIR="$prefix\include"
  $env:OPENSSL_DIR=$prefix
}

# function Install-zig
# {
#   $url = "https://ziglang.org/builds/zig-windows-x86_64-0.12.0.zip"
#   $archive = Download $url "$HOME/Downloads"
#   Extract $archive "$HOME/zig"
# }

function Install-zigup
{
  $url = "https://github.com/marler8997/zigup/releases/download/v2024_03_13/zigup.windows-latest-x86_64.zip"
  $archive = Download $url "$HOME/Downloads"
  $dir = Extract $archive "$HOME/Downloads"
  Copy-Item (Join-Path $dir "zigup.exe") $HOME/zig
}

function Install-pacseek
{
  # yay
  sudo pacman -Sy --needed git base-devel
  if(!(Test-Path $HOME/yay))
  {
    git clone https://aur.archlinux.org/yay.git $HOME/yay
  }
  Push-Location $HOME/yay
  makepkg -si
  Pop-Location
  # pakseek
  if(!(Test-Path $HOME/pacseek))
  {
    git clone https://github.com/moson-mo/pacseek.git $HOME/pacseek
  }
  Push-Location $HOME/pacseek
  go install .
  Pop-Location
}

function Install-ffmpeg
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )

  ghq get https://gitlab.freedesktop.org/gstreamer/meson-ports/ffmpeg
  Push-Location (Join-Path (ghq root) "\gitlab.freedesktop.org\gstreamer\meson-ports\ffmpeg")
  meson setup builddir --prefix $prefix -Dbuildtype=release -Dprograms=enabled -Dlibx264=enabled -Dlibx264_encoder=enabled --reconfigure
  meson install -C builddir
  Pop-Location
}

function Install-zigup
{
  $url = "https://github.com/marler8997/zigup/releases/download/v2024_05_05/zigup-x86_64-windows.zip"
  $archive = Download $url $HOME/local/src
  Extract $archive $HOME/local/src
  Copy-Item -Path $HOME/local/src/zigup-x86_64-windows/zigup.exe -Destination $HOME/local/bin/zigup.exe -Force
}

function Install-zls
{
  $url = "https://github.com/zigtools/zls/releases/download/0.12.0/zls-x86_64-windows.zip"
  $archive = Download $url $HOME/local/src
  Extract $archive $HOME/local/src
  Copy-Item -Path $HOME/local/src/zls-x86_64-windows/zls.exe -Destination $HOME/local/bin/zls.exe -Force
}

function Install-zig
{
  New-Item $HOME/local/src -ItemType Directory -ErrorAction SilentlyContinue

  Install-zigup
  zigup master
  Install-zls
}

function Install-nkf
{
  ghq get https://github.com/nurse/nkf
}

function Install-python
{
  param(
    [Parameter(Mandatory)]
    [System.IO.DirectoryInfo]$prefix
  )

  $src = Join-Path $prefix "src"
  New-Item $src -ItemType Directory -ErrorAction SilentlyContinue
  $archive = Download "https://www.python.org/ftp/python/3.12.5/Python-3.12.5.tar.xz" $src
  $dir = Extract $archive $src 
  Push-Location $dir
  ./configure --prefix=$prefix --with-ensurepip=install
  make
  make install
  Pop-Location
}

# TODO:
# harfbuzz
# fontconfig
# pango

Export-ModuleMember -Function * -Alias *
