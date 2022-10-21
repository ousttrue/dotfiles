return {
  -- Shorthand example: the same snippet as above, but only setting the `trig` param
  s(
    "MM", -- the snip_param table is replaced by a single string holding `trig`
    { -- Table 2: snippet nodes
      t {
        "local M={}",
        "",
        "function M.setup()",
        "end",
        "",
        "return M",
      },
    }
  ),

  -- Shorthand example: the same snippet as above, but only setting the `trig` param
  s(
    "hi", -- the snip_param table is replaced by a single string holding `trig`
    { -- Table 2: snippet nodes
      t "Hello, world!",
    }
  ),
}

