[[luv]]

# version

- https://dist.libuv.org/dist/
- https://github.com/libuv/libuv/releases

## 1.48

# book

- [Table of Contents — An Introduction to libuv](https://nikhilm.github.io/uvbook/)

  - [uvbook -- libuvの仕組みとidle-basicの解説 · wshito's diary](http://diary.wshito.com/comp/lisp/uvbook/uvbook-idle-basic/)
  - [node.jsを支えるlibuvのチュートリアル"uvbook" :スレッド](https://kimitok.hateblo.jp/entry/2014/04/16/223643)

- @2014 [node.jsを支えるlibuvのチュートリアル"uvbook" :目次 - 自由課題](https://kimitok.hateblo.jp/entry/2014/03/30/184206)

  - [node.jsを支えるlibuvのチュートリアル"uvbook" :基礎 - 自由課題](https://kimitok.hateblo.jp/entry/2014/03/30/185544)

- @2019 [libuvとは(特にイベントループについて) - kkty’s blog](https://blog.kkty.jp/entry/2019/01/11/195601)

```c
#include <stdio.h>
#include <stdlib.h>
#include <uv.h>

int main() {
    uv_loop_t *loop = malloc(sizeof(uv_loop_t));
    uv_loop_init(loop);

    printf("Now quitting.\n");
    uv_run(loop, UV_RUN_DEFAULT);

    uv_loop_close(loop);
    free(loop);
    return 0;
}
```

- [Big Sky :: libuvのループはリファレンスの減少でも止められる。](https://mattn.kaoriya.net/software/lang/c/20111213134522.htm)

# uv_stream_t

## socket

- [第4回 libuv C10K〜C100K サーバサンプル [C++] | Netsphere Laboratories](https://www.nslabs.jp/libuv-c10k-server.rhtml)

## tty

- [uv_tty_t — TTY handle — libuv documentation](http://docs.libuv.org/en/v1.x/tty.html)

## write(vt100 escape sequence)

`stdout`

- @2014 [node.jsを支えるlibuvのチュートリアル"uvbook" :ユーティリティ - 自由課題](https://kimitok.hateblo.jp/entry/2014/04/24/231854)

## read

`stdin`

- [tty: read callback is called after closing · Issue #2012 · libuv/libuv · GitHub](https://github.com/libuv/libuv/issues/2012)

## ncurses

- [Event Loops and NCurses – LinuxJedi's /dev/null](https://linuxjedi.co.uk/2020/04/29/event-loops-and-ncurses/)

# uv_signal_t

[uv_signal_t — Signal handle - libuv documentation](https://docs.libuv.org/en/v1.x/signal.html)

# uv_process_t

[uv_process_t — Process handle — libuv documentation](http://docs.libuv.org/en/v1.x/process.html)

- [c - libuv: difference between fork and uv_spawn? - Stack Overflow](https://stackoverflow.com/questions/70031085/libuv-difference-between-fork-and-uv-spawn)

# uv_pipe_t

# uv_poll_t

## ncurses

- [Event Loops and NCurses – LinuxJedi's /dev/null](https://linuxjedi.co.uk/2020/04/29/event-loops-and-ncurses/)
  > keyboard/mouse input, resize and refresh handling

# uv_idle_t

[uvbook -- libuvの仕組みとidle-basicの解説 · wshito's diary](http://diary.wshito.com/comp/lisp/uvbook/uvbook-idle-basic/)

## uv_timer_t

[uv_timer_t — Timer handle - libuv documentation](https://docs.libuv.org/en/v1.x/timer.html)
[node.jsを支えるlibuvのチュートリアル"uvbook" :ユーティリティ - 自由課題](https://kimitok.hateblo.jp/entry/2014/04/24/231854)

# uv_work_t

- [Thread pool work scheduling - libuv documentation](https://docs.libuv.org/en/v1.x/threadpool.html)
- [libuvに関する覚書(4) : スレッド uv_work_t, uv_async_t](https://www.usagi1975.com/052220180938/)

```c
void worker(uv_work_t *req) {
}

void worker_after(uv_work_t *req, int status) {
}

uv_work_t work;
uv_queue_work(loop, &work, task, callback);
```

# uv_async_t

- [libuvに関する覚書(4) : スレッド uv_work_t, uv_async_t](https://www.usagi1975.com/052220180938/)
- thread data
- thread func
- end callback

```c
uv_async_t async;
uv_async_init(loop, &async, worker_progress);
```

# zig

- [Simplistic libuv wrapper example in Zig · GitHub](https://gist.github.com/Qix-/a53c46b0ff25a38a24a49c1dcea28d54)

# gtk

[[GTK3]]

- [libuv-glib/test-uv-gtk.c at master · derekdai/libuv-glib · GitHub](https://github.com/derekdai/libuv-glib/blob/master/test-uv-gtk.c)
