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

```{eval-rst}
.. autoclass:: prompt_toolkit.renderer.Renderer
    :members: render

.. autofunction:: prompt_toolkit.renderer._output_screen_diff
```

