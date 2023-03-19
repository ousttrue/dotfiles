readallbytes
#c++

```cpp
template<typename T>
static std::vector<T> ReadAllBytes(const std::string &filename) {
  std::ifstream ifs(filename.c_str(), std::ios::binary | std::ios::ate);
  if(!ifs)
  {
    return {};
  }
  auto pos = ifs.tellg();
  auto size = pos / sizeof(T);
  if(pos % sizeof(T))
  {
    ++size;
  }
  std::vector<T> buffer(size);
  ifs.seekg(0, std::ios::beg);
  ifs.read((char*)buffer.data(), pos);
  return buffer;
}
```
