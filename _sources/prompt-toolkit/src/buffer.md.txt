# Buffer < BufferControl < Window

## Buffer

### Document

### Cursor
        
```py
Buffer.__working_index = 0
Buffer.__cursor_position = 0
```

## prompt_toolkit.layout.controls.BufferControl: UIControl

current_buffer があるときだけ有効になるキーバインディングがある。

```py
    @handle("up")
    def _go_up(event: E) -> None:
        event.current_buffer.auto_up(count=event.arg)
```

## Window: Container
