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

## pyvim/run_pyvim.py:run\

## pyvim/editor.py:Editor

### __init__

```py
        self.key_bindings = create_key_bindings(self)
        self.editor_layout = EditorLayout(self, self.window_arrangement)
        self.application = self._create_application()
```

```py
    def _create_application(self):
        """
        Create CommandLineInterface instance.
        """
        # Create Application.
        application = Application(
            input=self.input,
            output=self.output,
            editing_mode=EditingMode.VI,
            layout=self.editor_layout.layout,
            key_bindings=self.key_bindings,
#            get_title=lambda: get_terminal_title(self),
            style=DynamicStyle(lambda: self.current_style),
            paste_mode=Condition(lambda: self.paste_mode),
#            ignore_case=Condition(lambda: self.ignore_case),  # TODO
            include_default_pygments_style=False,
            mouse_support=Condition(lambda: self.enable_mouse_support),
            full_screen=True,
            enable_page_navigation_bindings=True)

        # Handle command line previews.
        # (e.g. when typing ':colorscheme blue', it should already show the
        # preview before pressing enter.)
        def preview(_):
            if self.application.layout.has_focus(self.command_buffer):
                self.previewer.preview(self.command_buffer.text)
        self.command_buffer.on_text_changed += preview

        return application
```

### run

```py
    def run(self):
        """
        Run the event loop for the interface.
        This starts the interaction.
        """
        # Make sure everything is in sync, before starting.
        self.sync_with_prompt_toolkit()

        def pre_run():
            # Start in navigation mode.
            self.application.vi_state.input_mode = InputMode.NAVIGATION

        # Run eventloop of prompt_toolkit.
        self.application.run(pre_run=pre_run)
```
