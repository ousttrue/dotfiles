readallbytes
#c++

code:.cpp
 static std::vector<char> ReadAllBytes(char const *filename)
 {
     std::ifstream ifs(filename, std::ios::binary | std::ios::ate);
     auto pos = ifs.tellg();
     std::vector<char> buffer(pos);
     ifs.seekg(0, std::ios::beg);
     ifs.read(buffer.data(), pos);
     return buffer;
 }
