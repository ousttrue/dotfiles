# input

<https://python-prompt-toolkit.readthedocs.io/en/latest/pages/advanced_topics/rendering_pipeline.html>

input により loop を駆動しているぽい。重要。

```{graphviz}
digraph input {
Application -> run_async;
run_async -> Application_input_attach[label="input_ready_callback"];
Application_input_attach -> wait_for_handles;
wait_for_handles -> Application;
}
```

## wait_for_handles in blocking thread

```py
        # Add reader.
        def ready() -> None:
            # Tell the callback that input's ready.
            try:
                callback()
            finally:
                run_in_executor_with_context(wait, loop=loop)

        # Wait for the input to become ready.
        # (Use an executor for this, the Windows asyncio event loop doesn't
        # allow us to wait for handles like stdin.)
        def wait() -> None:
            # Wait until either the handle becomes ready, or the remove event
            # has been set.
            result = wait_for_handles([remove_event, handle])

            if result is remove_event:
                windll.kernel32.CloseHandle(remove_event)
                return
            else:
                loop.call_soon_threadsafe(ready)

        run_in_executor_with_context(wait, loop=loop)
```

## blocking `windll.kernel32.WaitForMultipleObjects`

```{eval-rst}
.. autofunction:: prompt_toolkit.eventloop.win32.wait_for_handles
```

## run in thread

```{eval-rst}
.. autofunction:: prompt_toolkit.eventloop.utils.run_in_executor_with_context
```

<https://docs.python.org/3/library/asyncio-eventloop.html#asyncio.loop.run_in_executor>
