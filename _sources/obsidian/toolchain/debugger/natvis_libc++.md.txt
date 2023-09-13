[[natvis]]
namespace `std::__1` になる？

- [https://source.chromium.org/chromium/chromium/src/+/main:tools/win/DebugVisualizers/libc++.natvis;drc=79b4f8b9d4a9dc7130463d2ca286f0b5b8e3d962](https://source.chromium.org/chromium/chromium/src/+/main:tools/win/DebugVisualizers/libc++.natvis;drc=79b4f8b9d4a9dc7130463d2ca286f0b5b8e3d962)

# libc++
- [Please consider shipping debugger visualizers for libstdc++/libc++ · Issue #3423 · microsoft/vscode-cpptools · GitHub](https://github.com/microsoft/vscode-cpptools/issues/3423)
- [Contributing debug visualizers for libc++ - Runtimes / C++ - LLVM Discussion Forums](https://discourse.llvm.org/t/contributing-debug-visualizers-for-libc/51956/4)
- [build/config/c++/libc++.natvis - chromium/src - Git at Google](https://chromium.googlesource.com/chromium/src/+/HEAD/build/config/c++/libc++.natvis)

# std::u8string
`std::__1::basic_string&lt;char8_t,*&gt;`

```xml
<Type Name="std::__1::basic_string&lt;char8_t,*&gt;">
</Type>
```

```xml
  <Type Name="std::__1::unordered_map&lt;*&gt;">
    <Intrinsic Name="size" Expression="*(size_type*)&amp;__table_.__p2_" />
    <Intrinsic Name="bucket_count"
      Expression="*(size_type*)&amp;
                    ((__table::__bucket_list_deleter*)
                        ((void**)&amp;__table_.__bucket_list_ + 1))
                        -&gt;__data_" />
    <DisplayString>{{ size={size()} }}</DisplayString>
    <Expand>
      <Item Name="[bucket_count]">bucket_count()</Item>
      <Item Name="[load_factor]">
        bucket_count() != 0 ? (float)size() / bucket_count() : 0.f</Item>
      <Item Name="[max_load_factor]">*(float*)&amp;__table_.__p3_</Item>
      <!-- Use CustomListItems instead of LinkedListItems because we
        need to cast to __table::__node_pointer and LinkedListItems
        evaluates <Value> in the context of the node, not of the container,
        so we'd have to say std::unordered_map<$T1,...>::__table::__node_pointer
        and then we couldn't share this <Type> between unordered_(multi)map
        and unordered_(multi)set. -->
      <CustomListItems>
        <Variable Name="node"
          InitialValue="*(__table::__next_pointer*)&amp;__table_.__p1_" />
        <Size>size()</Size>
        <Loop>
          <Item>(*(__table::__node_pointer*)&amp;node)-&gt;__value_</Item>
          <Exec>node = node-&gt;__next_</Exec>
        </Loop>
      </CustomListItems>
    </Expand>
  </Type>

  <Type Name="std::__1::vector&lt;*&gt;">
    <Intrinsic Name="size" Expression="__end_ - __begin_" />
    <DisplayString>{{ size={size()} }}</DisplayString>
    <Expand>
      <ArrayItems>
        <Size>size()</Size>
        <ValuePointer>__begin_</ValuePointer>
      </ArrayItems>
    </Expand>
  </Type>

  <Type Name="std::__1::shared_ptr&lt;*&gt;">
    <DisplayString>[shared_ptr]</DisplayString>
    <Expand>
      <Item Name="ptr">right - left</Item>
    </Expand>
  </Type>

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
