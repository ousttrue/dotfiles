# pyvim

<https://github.com/prompt-toolkit/pyvim>

`launch.json`

```js
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Current File",
            "type": "python",
            "request": "launch",
            "module": "pyvim",
            "console": "externalTerminal"
        }
    ]
}
```

## layout

```py
HSplit([
    TabsToolbar(editor),
    self._fc,
    CommandLine(editor),
    ReportMessageToolbar(editor),
    SystemToolbar(),
    search_toolbar,
]),
```

### TabsToolbar

```py
class TabsToolbar(ConditionalContainer):
    def __init__(self, editor):
        super(TabsToolbar, self).__init__(
            Window(TabsControl(editor), height=1),
            filter=Condition(lambda: len(editor.window_arrangement.tab_pages) > 1))
```

### self._fc

```py
        self._fc = FloatContainer(
            content=VSplit([
                Window(BufferControl())  # Dummy window
            ]),
            floats=[
                Float(xcursor=True, ycursor=True,
                      content=CompletionsMenu(max_height=12,
                                              scroll_offset=2,
                                              extra_filter=~has_focus(editor.command_buffer))),
                Float(content=BufferListOverlay(editor), bottom=1, left=0),
                Float(bottom=1, left=0, right=0, height=1,
                      content=ConditionalContainer(
                          CompletionsToolbar(),
                          filter=has_focus(editor.command_buffer) &
                                       ~_bufferlist_overlay_visible(editor) &
                                       Condition(lambda: editor.show_wildmenu))),
                Float(bottom=1, left=0, right=0, height=1,
                      content=ValidationToolbar()),
                Float(bottom=1, left=0, right=0, height=1,
                      content=MessageToolbarBar(editor)),
                Float(content=WelcomeMessageWindow(editor),
                      height=WELCOME_MESSAGE_HEIGHT,
                      width=WELCOME_MESSAGE_WIDTH),
            ]
        )
```

### WindowArrangement

木構造。(split されうる)

```py
        def create_layout_from_node(node):
            if isinstance(node, window_arrangement.Window):
                # Create frame for Window, or reuse it, if we had one already.
                key = (node, node.editor_buffer)
                frame = existing_frames.get(key)
                if frame is None:
                    frame, pt_window = self._create_window_frame(node.editor_buffer)

                    # Link layout Window to arrangement.
                    node.pt_window = pt_window

                self._frames[key] = frame
                return frame

            elif isinstance(node, window_arrangement.VSplit):
                return VSplit(
                    [create_layout_from_node(n) for n in node],
                    padding=1,
                    padding_char=self.get_vertical_border_char(),
                    padding_style='class:frameborder')

            if isinstance(node, window_arrangement.HSplit):
                return HSplit([create_layout_from_node(n) for n in node])

        layout = create_layout_from_node(self.window_arrangement.active_tab.root)
        self._fc.content = layout
```
