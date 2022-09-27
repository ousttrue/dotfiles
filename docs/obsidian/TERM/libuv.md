# book
- [Table of Contents — An Introduction to libuv](https://nikhilm.github.io/uvbook/)
	- [uvbook -- libuvの仕組みとidle-basicの解説 · wshito's diary](http://diary.wshito.com/comp/lisp/uvbook/uvbook-idle-basic/)

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

# tty
## write(vt100 escape sequence)
- [uv_tty_t — TTY handle — libuv documentation](http://docs.libuv.org/en/v1.x/tty.html)
- [node.jsを支えるlibuvのチュートリアル"uvbook" :ユーティリティ - 自由課題](https://kimitok.hateblo.jp/entry/2014/04/24/231854)
## read
- [tty: read callback is called after closing · Issue #2012 · libuv/libuv · GitHub](https://github.com/libuv/libuv/issues/2012)

# uv_pipe_t

# uv_poll_t
## ncurses
- [Event Loops and NCurses – LinuxJedi's /dev/null](https://linuxjedi.co.uk/2020/04/29/event-loops-and-ncurses/)
> keyboard/mouse input, resize and refresh handling

# zig
- [Simplistic libuv wrapper example in Zig · GitHub](https://gist.github.com/Qix-/a53c46b0ff25a38a24a49c1dcea28d54)
