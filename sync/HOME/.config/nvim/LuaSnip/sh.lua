return { -- Shorthand example: the same snippet as above, but only setting the `trig` param
  s(
    "CMAKE", -- the snip_param table is replaced by a single string holding `trig`
    { -- Table 2: snippet nodes
      t "cmake -B build -S . -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -G Ninja",
    }
  ),
}
