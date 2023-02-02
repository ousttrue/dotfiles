[[cpp]]

# std::string_view
## std::string

```c++
string_view sv;
string s = {sv.begin(), sv.end()};
```

```c++
string s;
string_view sv = string_view(s);
```
