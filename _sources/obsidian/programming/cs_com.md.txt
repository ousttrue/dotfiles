InterfaceIsIUnknown
#com #csharp

[COM Interop Part 1: C# Client Tutorial https://msdn.microsoft.com/en-us/ie/aa645736(v=vs.94)]

[C#でCOMを使ってみた。 http://makky12.hatenablog.com/entry/2016/08/03/212312]

[C#でCOMを使ってみた。その２ http://makky12.hatenablog.com/entry/2016/08/04/203558]

https://ichigopack.net/win32com/com_csharp_2.html

[* interface]
code:.cs
 [Guid("xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
 interface IDirectSoundCapture8
 {
 }

[* newしてcastする]

`** IUnknown`
Marshal.GetTypedObjectForIUnknown

[* QueryInterface]
Marshal.QueryInterface

http://mikeo410.minim.ne.jp/cms/~programmingcominterface
