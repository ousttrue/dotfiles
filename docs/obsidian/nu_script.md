[[nushell]]

# Custom command
[Custom commands | Nushell](https://www.nushell.sh/book/custom_commands.html)

```nu
def greet [name] {
  ['hello' $name]
}
```

# string
```
$"hello ($name)"
```
