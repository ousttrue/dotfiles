
```c
ui_client_run(remote_ui);  // NORETURN

// os_exit() will be invoked when the client channel detaches
while (true) {
	LOOP_PROCESS_EVENTS(&main_loop, resize_events, -1);
}

#define LOOP_PROCESS_EVENTS(loop, multiqueue, timeout) \
  do { \
    if (multiqueue && !multiqueue_empty(multiqueue)) { \
      multiqueue_process_events(multiqueue); \
    } else { \
      loop_poll_events(loop, timeout); \
    } \
  } while (0)
```
