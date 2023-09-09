[[natvis]]

`MSVC`

- [STL/stl/debugger/STL.natvis at main · microsoft/STL · GitHub](https://github.com/microsoft/STL/blob/main/stl/debugger/STL.natvis#L172C17-L209C10)

# std::u8string
`std::basic_string&lt;char8_t,*&gt;`


```xml
<!-- VC 2013 -->
<Type Name="std::reference_wrapper&lt;*&gt;" Priority="MediumLow">
     <DisplayString>{_Callee}</DisplayString>
    <Expand>
        <ExpandedItem>_Callee</ExpandedItem>
    </Expand>
</Type>

<!-- VC 2015 -->
<Type Name="std::reference_wrapper&lt;*&gt;">
    <DisplayString>{*_Ptr}</DisplayString>
    <Expand>
        <Item Name="[ptr]">_Ptr</Item>
    </Expand>
</Type>

<Type Name="std::basic_string&lt;char8_t,*&gt;" Priority="High">
	<Intrinsic Name="size" Expression="_Mypair._Myval2._Mysize" />
	<Intrinsic Name="capacity" Expression="_Mypair._Myval2._Myres" />
	<!-- _BUF_SIZE = 16 / sizeof(char) &lt; 1 ? 1 : 16 / sizeof(char) == 16 -->
	<Intrinsic Name="bufSize" Expression="16" />
	<Intrinsic Name="isShortString" Expression="capacity() &lt; bufSize()" />
	<Intrinsic Name="isLongString" Expression="capacity() &gt;= bufSize()" />
	<DisplayString Condition="isShortString()">{_Mypair._Myval2._Bx._Buf,nas8}</DisplayString>
	<DisplayString Condition="isLongString()">{_Mypair._Myval2._Bx._Ptr,nas8}</DisplayString>
	<StringView Condition="isShortString()">_Mypair._Myval2._Bx._Buf,nas8</StringView>
	<StringView Condition="isLongString()">_Mypair._Myval2._Bx._Ptr,nas8</StringView>
	<Expand>
	<Item Name="[size]" ExcludeView="simple">size()</Item>
	<Item Name="[capacity]" ExcludeView="simple">capacity()</Item>
	<Item Name="[allocator]" ExcludeView="simple">_Mypair</Item>
	<ArrayItems>
	<Size>_Mypair._Myval2._Mysize</Size>
	<ValuePointer Condition="isShortString()">_Mypair._Myval2._Bx._Buf</ValuePointer>
	<ValuePointer Condition="isLongString()">_Mypair._Myval2._Bx._Ptr</ValuePointer>
	</ArrayItems>
	</Expand>
</Type>
```

# std::variant
- [visual c++ - How to display template parameter type name in natvis? - Stack Overflow](https://stackoverflow.com/questions/54458842/how-to-display-template-parameter-type-name-in-natvis)

```xml
    <Type
        Name="std::variant&lt;std::monostate,bool,float,*&gt;"
        Priority="High">
        <DisplayString Condition="_Which==0">{{null}}</DisplayString>
        <DisplayString Condition="_Which==1" Optional="true">{{bool}}</DisplayString>
        <DisplayString Condition="_Which==2" Optional="true">{{float}}</DisplayString>
        <DisplayString Condition="_Which==3" Optional="true">{{u8string}}</DisplayString>
        <DisplayString Condition="_Which==4" Optional="true">{{array}}</DisplayString>
        <DisplayString Condition="_Which==5" Optional="true">{{object}}</DisplayString>
        <Expand>
            <Item Name="which">_Which</Item>
            <Item Name="value0" Condition="_Which==0">null</Item>
            <Item Name="value1" Condition="_Which==1" Optional="true">std::get&lt;bool&gt;(*this)</Item>
            <Item Name="value2" Condition="_Which==2" Optional="true">std::get&lt;float&gt;()</Item>
            <Item Name="value3" Condition="_Which==3" Optional="true">std::get&lt;std::u8string&gt;()</Item>
            <Item Name="value4" Condition="_Which==4" Optional="true">[]</Item>
            <Item Name="value5" Condition="_Which==5" Optional="true">{{}}</Item>
        </Expand>
    </Type>
```

