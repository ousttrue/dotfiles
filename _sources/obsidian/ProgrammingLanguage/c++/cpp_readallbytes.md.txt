readallbytes
#c++

```cpp
static std::vector<uint8_t>
ReadAllBytes(const std::string& filename)
{
  std::ifstream ifs(filename.c_str(), std::ios::binary | std::ios::ate);
  if (!ifs) {
    return {};
  }
  auto pos = ifs.tellg();
  auto size = pos;
  std::vector<uint8_t> buffer(size);
  ifs.seekg(0, std::ios::beg);
  ifs.read((char*)buffer.data(), pos);
  return buffer;
}
```
