# draw

<https://python-prompt-toolkit.readthedocs.io/en/latest/pages/advanced_topics/rendering_flow.html>
```{graphviz}
digraph input {
Application -> _redraw;
_redraw -> Renderer_render;
Renderer_render -> screen[label="layout.container.write_to_screen"];
screen -> _output_screen_diff;
}
```

## Renderer


```py
def _output_screen_diff()
    # Loop over the rows.
    row_count = min(max(screen.height, previous_screen.height), height)
    c = 0  # Column counter.

    for y in range(row_count):
        new_row = screen.data_buffer[y]
        previous_row = previous_screen.data_buffer[y]
        zero_width_escapes_row = screen.zero_width_escapes[y]

        new_max_line_len = min(width - 1, get_max_column_index(new_row))
        previous_max_line_len = min(width - 1, get_max_column_index(previous_row))

        # Loop over the columns.
        c = 0
        while c <= new_max_line_len:
            new_char = new_row[c]
            old_char = previous_row[c]
            char_width = new_char.width or 1

            # each line / each column


class Renderer:
    def render(self):
        screen = Screen()

        # Screen.data_buffer と Screen.zero_width_escapes に情報を詰め込む
        layout.container.write_to_screen(screen...)
        screen.draw_all_floats()

        # Screen.data_buffer と Screen.zero_width_escapes をoutput に出力する
        _output_screen_diff()
```

## Screen

`Screen.data_buffer` に `row/column` 情報が入っている。

## reference

```{eval-rst}
.. autoclass:: prompt_toolkit.renderer.Renderer
    :members: render

.. autofunction:: prompt_toolkit.renderer._output_screen_diff
```

