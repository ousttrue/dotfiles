# Buffer

`Window`, `BufferControl`, `Buffer` の組み合わせ。

## Buffer

Document

## prompt_toolkit.layout.controls.BufferControl: UIControl

current_buffer があるときだけ有効になるキーバインディングがある。

```py
    @handle("up")
    def _go_up(event: E) -> None:
        event.current_buffer.auto_up(count=event.arg)
```

## Window: Container
