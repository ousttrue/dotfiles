# Application

* [python prompt toolkitの紹介と動作を理解するメモ](https://vaaaaaanquish.hatenablog.com/entry/2019/07/06/213909#Application)

https://python-prompt-toolkit.readthedocs.io/en/master/pages/full_screen_apps.html


```{inheritance-diagram} prompt_toolkit.application.Application
:private-bases:
:parts: 1
```

```{automodule} prompt_toolkit.application
:members:
:undoc-members:
:show-inheritance:
```

## run

```py
    def run(
        self,
        pre_run: Optional[Callable[[], None]] = None,
        set_exception_handler: bool = True,
        handle_sigint: bool = True,
        in_thread: bool = False,
    ) -> _AppResult:

        # 省略

        return loop.run_until_complete(
            self.run_async(pre_run=pre_run, set_exception_handler=set_exception_handler)
        )
```

👇

entry point

```py
    async def run_async(
        self,
        pre_run: Optional[Callable[[], None]] = None,
        set_exception_handler: bool = True,
        handle_sigint: bool = True,
        slow_callback_duration: float = 0.5,
    ) -> _AppResult:
        """
        Run the prompt_toolkit :class:`~prompt_toolkit.application.Application`
        until :meth:`~prompt_toolkit.application.Application.exit` has been
        called. Return the value that was passed to
        :meth:`~prompt_toolkit.application.Application.exit`.

        This is the main entry point for a prompt_toolkit
        :class:`~prompt_toolkit.application.Application` and usually the only
        place where the event loop is actually running.

        :param pre_run: Optional callable, which is called right after the
            "reset" of the application.
        :param set_exception_handler: When set, in case of an exception, go out
            of the alternate screen and hide the application, display the
            exception, and wait for the user to press ENTER.
        :param handle_sigint: Handle SIGINT signal if possible. This will call
            the `<sigint>` key binding when a SIGINT is received. (This only
            works in the main thread.)
        :param slow_callback_duration: Display warnings if code scheduled in
            the asyncio event loop takes more time than this. The asyncio
            default of `0.1` is sometimes not sufficient on a slow system,
            because exceptionally, the drawing of the app, which happens in the
            event loop, can take a bit longer from time to time.
        """
        assert not self._is_running, "Application is already running."


        async def _run_async() -> _AppResult:
            "Coroutine."
            loop = get_event_loop()
            f = loop.create_future()
            self.future = f  # XXX: make sure to set this before calling '_redraw'.
            self.loop = loop
            self.context = contextvars.copy_context()

            # Counter for cancelling 'flush' timeouts. Every time when a key is
            # pressed, we start a 'flush' timer for flushing our escape key. But
            # when any subsequent input is received, a new timer is started and
            # the current timer will be ignored.
            flush_task: Optional[asyncio.Task[None]] = None

            # Reset.
            # (`self.future` needs to be set when `pre_run` is called.)
            self.reset()
            self._pre_run(pre_run)

            # Feed type ahead input first.
            self.key_processor.feed_multiple(get_typeahead(self.input))
            self.key_processor.process_keys()

            def read_from_input() -> None:
                nonlocal flush_task

                # Ignore when we aren't running anymore. This callback will
                # removed from the loop next time. (It could be that it was
                # still in the 'tasks' list of the loop.)
                # Except: if we need to process incoming CPRs.
                if not self._is_running and not self.renderer.waiting_for_cpr:
                    return

                # Get keys from the input object.
                keys = self.input.read_keys()

                # Feed to key processor.
                self.key_processor.feed_multiple(keys)
                self.key_processor.process_keys()

                # Quit when the input stream was closed.
                if self.input.closed:
                    if not f.done():
                        f.set_exception(EOFError)
                else:
                    # Automatically flush keys.
                    if flush_task:
                        flush_task.cancel()
                    flush_task = self.create_background_task(auto_flush_input())

            async def auto_flush_input() -> None:
                # Flush input after timeout.
                # (Used for flushing the enter key.)
                # This sleep can be cancelled, in that case we won't flush yet.
                await sleep(self.ttimeoutlen)
                flush_input()

            def flush_input() -> None:
                if not self.is_done:
                    # Get keys, and feed to key processor.
                    keys = self.input.flush_keys()
                    self.key_processor.feed_multiple(keys)
                    self.key_processor.process_keys()

                    if self.input.closed:
                        f.set_exception(EOFError)

            # Enter raw mode, attach input and attach WINCH event handler.
            with self.input.raw_mode(), self.input.attach(
                read_from_input
            ), attach_winch_signal_handler(self._on_resize):

                # Draw UI.
                self._request_absolute_cursor_position()
                self._redraw()
                self._start_auto_refresh_task()

                self.create_background_task(self._poll_output_size())

                # Wait for UI to finish.
                try:
                    result = await f
                finally:
                    # In any case, when the application finishes.
                    # (Successful, or because of an error.)
                    try:
                        self._redraw(render_as_done=True)
                    finally:
                        # _redraw has a good chance to fail if it calls widgets
                        # with bad code. Make sure to reset the renderer
                        # anyway.
                        self.renderer.reset()

                        # Unset `is_running`, this ensures that possibly
                        # scheduled draws won't paint during the following
                        # yield.
                        self._is_running = False

                        # Detach event handlers for invalidate events.
                        # (Important when a UIControl is embedded in multiple
                        # applications, like ptterm in pymux. An invalidate
                        # should not trigger a repaint in terminated
                        # applications.)
                        for ev in self._invalidate_events:
                            ev -= self._invalidate_handler
                        self._invalidate_events = []

                        # Wait for CPR responses.
                        if self.output.responds_to_cpr:
                            await self.renderer.wait_for_cpr_responses()

                        # Wait for the run-in-terminals to terminate.
                        previous_run_in_terminal_f = self._running_in_terminal_f

                        if previous_run_in_terminal_f:
                            await previous_run_in_terminal_f

                        # Store unprocessed input as typeahead for next time.
                        store_typeahead(self.input, self.key_processor.empty_queue())

                return cast(_AppResult, result)

```
