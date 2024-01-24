https://github.com/folke/lazy.nvim

# pulgin spec

## config = true
no args

## opts = table
call config
config の省略記法。

```lua
config = function()
	require 'some'.setup(opts)
end
```

## config = func
call func

