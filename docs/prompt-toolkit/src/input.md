# input

input により loop を駆動しているぽい。重要。

```py
class Application
    def __init__(self, ...):

        # I/O.
        session = get_app_session()
        self.output = output or session.output
        self.input = input or session.input

```

## AppSession

Terminal の入出力との接続を表す。

```py
class AppSession:
    """
    An AppSession is an interactive session, usually connected to one terminal.
    Within one such session, interaction with many applications can happen, one
    after the other.

    The input/output device is not supposed to change during one session.

    Warning: Always use the `create_app_session` function to create an
    instance, so that it gets activated correctly.

    :param input: Use this as a default input for all applications
        running in this session, unless an input is passed to the `Application`
        explicitely.
    :param output: Use this as a default output.
    """

    def __init__(
        self, input: Optional["Input"] = None, output: Optional["Output"] = None
    ) -> None:

        self._input = input
        self._output = output

        # The application will be set dynamically by the `set_app` context
        # manager. This is called in the application itself.
        self.app: Optional["Application[Any]"] = None

    def __repr__(self) -> str:
        return f"AppSession(app={self.app!r})"

    @property
    def input(self) -> "Input":
        if self._input is None:
            from prompt_toolkit.input.defaults import create_input

            self._input = create_input()
        return self._input

    @property
    def output(self) -> "Output":
        if self._output is None:
            from prompt_toolkit.output.defaults import create_output

            self._output = create_output()
        return self._output
```

## create_input

```py
def create_input(
    stdin: Optional[TextIO] = None, always_prefer_tty: bool = False
) -> Input:
    """
    Create the appropriate `Input` object for the current os/environment.

    :param always_prefer_tty: When set, if `sys.stdin` is connected to a Unix
        `pipe`, check whether `sys.stdout` or `sys.stderr` are connected to a
        pseudo terminal. If so, open the tty for reading instead of reading for
        `sys.stdin`. (We can open `stdout` or `stderr` for reading, this is how
        a `$PAGER` works.)
    """
    if is_windows():
        from .win32 import Win32Input

        # If `stdin` was assigned `None` (which happens with pythonw.exe), use
        # a `DummyInput`. This triggers `EOFError` in the application code.
        if stdin is None and sys.stdin is None:
            return DummyInput()

        return Win32Input(stdin or sys.stdin)
    else:
        from .vt100 import Vt100Input

        # If no input TextIO is given, use stdin/stdout.
        if stdin is None:
            stdin = sys.stdin

            if always_prefer_tty:
                for io in [sys.stdin, sys.stdout, sys.stderr]:
                    if io.isatty():
                        stdin = io
                        break

        return Vt100Input(stdin)
```

## Win32Input

`prompt_toolkit/input/win32.py`

```py
class _Win32Handles:
    """
    Utility to keep track of which handles are connectod to which callbacks.

    `add_win32_handle` starts a tiny event loop in another thread which waits
    for the Win32 handle to become ready. When this happens, the callback will
    be called in the current asyncio event loop using `call_soon_threadsafe`.

    `remove_win32_handle` will stop this tiny event loop.

    NOTE: We use this technique, so that we don't have to use the
          `ProactorEventLoop` on Windows and we can wait for things like stdin
          in a `SelectorEventLoop`. This is important, because our inputhook
          mechanism (used by IPython), only works with the `SelectorEventLoop`.
    """

    def __init__(self) -> None:
        self._handle_callbacks: Dict[int, Callable[[], None]] = {}

        # Windows Events that are triggered when we have to stop watching this
        # handle.
        self._remove_events: Dict[int, HANDLE] = {}

    def add_win32_handle(self, handle: HANDLE, callback: Callable[[], None]) -> None:
        """
        Add a Win32 handle to the event loop.
        """
        handle_value = handle.value

        if handle_value is None:
            raise ValueError("Invalid handle.")

        # Make sure to remove a previous registered handler first.
        self.remove_win32_handle(handle)

        loop = get_event_loop()
        self._handle_callbacks[handle_value] = callback

        # Create remove event.
        remove_event = create_win32_event()
        self._remove_events[handle_value] = remove_event

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

    def remove_win32_handle(self, handle: HANDLE) -> Optional[Callable[[], None]]:
        """
        Remove a Win32 handle from the event loop.
        Return either the registered handler or `None`.
        """
        if handle.value is None:
            return None  # Ignore.

        # Trigger remove events, so that the reader knows to stop.
        try:
            event = self._remove_events.pop(handle.value)
        except KeyError:
            pass
        else:
            windll.kernel32.SetEvent(event)

        try:
            return self._handle_callbacks.pop(handle.value)
        except KeyError:
            return None


@contextmanager
def attach_win32_input(
    input: _Win32InputBase, callback: Callable[[], None]
) -> Iterator[None]:
    """
    Context manager that makes this input active in the current event loop.

    :param input: :class:`~prompt_toolkit.input.Input` object.
    :param input_ready_callback: Called when the input is ready to read.
    """
    win32_handles = input.win32_handles
    handle = input.handle

    if handle.value is None:
        raise ValueError("Invalid handle.")

    # Add reader.
    previous_callback = win32_handles.remove_win32_handle(handle)
    win32_handles.add_win32_handle(handle, callback)

    try:
        yield
    finally:
        win32_handles.remove_win32_handle(handle)

        if previous_callback:
            win32_handles.add_win32_handle(handle, previous_callback)


class Win32Input(_Win32InputBase):
    """
    `Input` class that reads from the Windows console.
    """

    def __init__(self, stdin: Optional[TextIO] = None) -> None:
        super().__init__()
        self.console_input_reader = ConsoleInputReader()

    def attach(self, input_ready_callback: Callable[[], None]) -> ContextManager[None]:
        """
        Return a context manager that makes this input active in the current
        event loop.
        """
        return attach_win32_input(self, input_ready_callback)

    def detach(self) -> ContextManager[None]:
        """
        Return a context manager that makes sure that this input is not active
        in the current event loop.
        """
        return detach_win32_input(self)

    def read_keys(self) -> List[KeyPress]:
        return list(self.console_input_reader.read())

    def flush(self) -> None:
        pass

    @property
    def closed(self) -> bool:
        return False

    def raw_mode(self) -> ContextManager[None]:
        return raw_mode()

    def cooked_mode(self) -> ContextManager[None]:
        return cooked_mode()

    def fileno(self) -> int:
        # The windows console doesn't depend on the file handle, so
        # this is not used for the event loop (which uses the
        # handle instead). But it's used in `Application.run_system_command`
        # which opens a subprocess with a given stdin/stdout.
        return sys.stdin.fileno()

    def typeahead_hash(self) -> str:
        return "win32-input"

    def close(self) -> None:
        self.console_input_reader.close()

    @property
    def handle(self) -> HANDLE:
        return self.console_input_reader.handle
```
