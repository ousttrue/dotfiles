[[nushell]]

- in
- get
- merge
- insert

# items で展開

```
{ new: york, san: francisco } | items {|key, value| echo $'($key) ($value)' }
```
