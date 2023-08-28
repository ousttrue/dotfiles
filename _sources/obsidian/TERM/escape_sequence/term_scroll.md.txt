[[lua_escapesequence]]
[[escape_sequence]]

# scroll region

`setwin DECSTBM`

```
1行目から50行目までをスクロールリージョンに指定
> lua_e "nyagos.write('\027[1;50r')"
```
