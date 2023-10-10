[[cpp]] [[natvis]]

- @2023 [C++ standard library ABI compatibility | MaskRay](https://maskray.me/blog/2023-06-25-c++-standard-library-abi-compatibility)

# short string optimization (SSO)
@2022 [std::string でメモリーアロケートが発生しない最大バイト数](https://zenn.dev/tenka/articles/string_max_size_without_memory_allocation)

# libc++

## std::u8string
- [C++ String Layouts](https://eu90h.github.io/cpp-strings.html)
- [c++ - What are the mechanics of short string optimization in libc++? - Stack Overflow](https://stackoverflow.com/questions/21694302/what-are-the-mechanics-of-short-string-optimization-in-libc)
- @2022 [Implementation of string in libc++ - SoByte](https://www.sobyte.net/post/2022-08/libcpp-string/)
- @2020 [libc++’s implementation of std::string | Joel Laity](https://joellaity.com/2020/01/31/string.html)
```xml
  <Type Name="std::__1::basic_string&lt;char8_t,*&gt;">
    <Intrinsic Name="is_long"
        Expression="*(((char*)this)) &amp; 0x01" />
    <DisplayString Condition="is_long()">{*(((char8_t**)this)+2),s8}</DisplayString>
    <DisplayString Condition="!is_long()">{((char8_t*)this)+1,s8}</DisplayString>
    <Expand>
      <Item Name="[is_long]">is_long()</Item>
      <!-- <Item Name="[size]" Condition="is_long()" -->
      <!--     ExcludeView="simple">((size_t*)this)[1]</Item> -->
      <!-- <Item Name="[size]" Condition="!is_long()" -->
      <!--     ExcludeView="simple">*(((char*)this))</Item> -->
      <!-- <Item Name="[capacity]" Condition="is_long()" ExcludeView="simple"> -->
      <!--   ((size_t*)this)[2] &amp; (~((size_t)0) &gt;&gt; 1) -->
      <!-- </Item> -->
      <!-- <Item Name="[capacity]" Condition="!is_long()" -->
      <!--     ExcludeView="simple">22</Item> -->
      <!-- <ArrayItems> -->
      <!--   <Size Condition="is_long()">((size_t*)this)[1]</Size> -->
      <!--   <Size Condition="!is_long()"> -->
      <!--     *(((char*)this) + 3*sizeof(size_t) - 1) -->
      <!--   </Size> -->
      <!--   <ValuePointer Condition="is_long()">*(char**)this</ValuePointer> -->
      <!--   <ValuePointer Condition="!is_long()">(char*)this</ValuePointer> -->
      <!-- </ArrayItems> -->
    </Expand>
  </Type>
```
