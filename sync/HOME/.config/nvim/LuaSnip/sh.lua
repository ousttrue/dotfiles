return { -- Shorthand example: the same snippet as above, but only setting the `trig` param
  s(
    "CONFIGURE", -- the snip_param table is replaced by a single string holding `trig`
    { -- Table 2: snippet nodes
      t "cmake -B build -S . -DEXPORT_COMPILE_COMMANDS=1",
    }
  ),
}
