local M = {}

function M.setup()
  nyagos.complete_for["go"] = function(args)
    if #args == 2 then
      return {
        "bug",
        "doc",
        "fmt",
        "install",
        "run",
        "version",
        "build",
        "env",
        "generate",
        "list",
        "test",
        "vet",
        "clean",
        "fix",
        "get",
        "mod",
        "tool",
      }
    else
      return nil -- files completion
    end
  end
end

return M
