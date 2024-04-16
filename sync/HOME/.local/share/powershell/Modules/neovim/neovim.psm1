function rmrf
{
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline = $true)] [string[]] $inputStrings
  )
  process
  {
    Remove-Item -Recurse -Force $inputStrings
  }
}

function Install-nvim($prefix = $NVIM_PREFIX)
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
  cmake --install build --prefix $prefix
  Pop-Location
}

function Remove-TSParser
{
  if (Test-Path "$HOME/local/lib/nvim/parser"
  )
  {
    rmrf "$HOME/local/lib/nvim/parser"
  }
  if (Test-Path "$HOME/.local/share/nvim/lazy/nvim-treesitter/parser"
  )
  {
    rmrf "$HOME/.local/share/nvim/lazy/nvim-treesitter/parser"
  }
  if (Test-Path "$HOME/.cache/nvim/treesitter/parser"
  )
  {
    rmrf "$HOME/.cache/nvim/treesitter/parser"
  }
}


Export-ModuleMember -Function * -Alias *
