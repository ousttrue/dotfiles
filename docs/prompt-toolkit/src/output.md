# output

`prompt_toolkit.output.defaults.py`

```py
        if is_win_vt100_enabled():
            return cast(
                Output,
                Windows10_Output(stdout, default_color_depth=color_depth_from_env),
            )
        if is_conemu_ansi():
            return cast(
                Output, ConEmuOutput(stdout, default_color_depth=color_depth_from_env)
            )
        else:
            return Win32Output(stdout, default_color_depth=color_depth_from_env)
```

```{eval-rst}
.. autoclass:: prompt_toolkit.output.windows10.Windows10_Output

.. autoclass:: prompt_toolkit.output.conemu.ConEmuOutput

.. autoclass:: prompt_toolkit.output.win32.Win32Output

```
