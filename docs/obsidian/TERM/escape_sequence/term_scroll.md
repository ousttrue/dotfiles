[[lua_escapesequence]]
[[escape_sequence]]

# scroll region
[DECSTBM—Set Top and Bottom Margins](https://vt100.net/docs/vt510-rm/DECSTBM.html)

`setwin DECSTBM`

```
1行目から50行目までをスクロールリージョンに指定
> lua_e "nyagos.write('\027[1;50r')"
```

[escape characters - How to use ESC sequences to make terminal region scrollable - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/169509/how-to-use-esc-sequences-to-make-terminal-region-scrollable)

```sh
printf "\033[1,24r"

# reset
printf "\033[r"
```

これを利用してステータスラインを実装する例。
[uim/fep/draw.c at master · uim/uim · GitHub](https://github.com/uim/uim/blob/master/fep/draw.c#L1130)
