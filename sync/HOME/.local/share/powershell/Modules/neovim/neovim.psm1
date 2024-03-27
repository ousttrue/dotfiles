$NVIM_PREFIX = Join-Path $HOME "neovim"

Set-Alias v (Join-Path $NVIM_PREFIX "\bin\nvim")

function Install-nvim
{
  # https://github.com/neovim/neovim/blob/master/BUILD.md#build-prerequisites
  if (has brew)
  {
    brew install ninja cmake gettext curl
  } 
  if (has apt)
  {
    sudo apt update
    sudo apt install -y build-essential ninja-build gettext cmake unzip curl
  }
  if (has pacman)
  {
    sudo pacman -Sy
    sudo pacman -S base-devel cmake unzip ninja curl
  }
  if($IsWindows)
  {
    pip install cmake ninja
  }

  $repos = "/github.com/neovim/neovim"
  $src = (Join-Path (ghq root) $repos)
  if (Test-Path $src)
  {
    Push-Location $src
    git pull
    if (Test-Path build)
    {
      rmrf .deps
      rmrf build
    }
  } else
  {
    ghq get https://github.com/neovim/neovim
    Push-Location $src
  }

  cmake -G Ninja -S cmake.deps -B .deps -DCMAKE_BUILD_TYPE=Release
  cmake --build .deps
  cmake -G Ninja -S . -B build -DCMAKE_BUILD_TYPE=Release
  cmake --build build
  cmake --install build --prefix $NVIM_PREFIX
  Pop-Location
}

Export-ModuleMember -Function * -Alias *
