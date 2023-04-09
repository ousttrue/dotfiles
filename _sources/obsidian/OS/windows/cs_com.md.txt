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


ComInterface
#csharp #windows

https://ponherm.wordpress.com/2017/03/27/c-で-direct3d12-3/
https://github.com/ousttrue/UniKinect/blob/master/UniKinect/Nui/Import.cs
https://github.com/microsoft/Windows-universal-samples/blob/master/Samples/BasicHologram/cs/Common/InteropStatics.cs

	[C#でCOMを使ってみた。 http://makky12.hatenablog.com/entry/2016/08/03/212312]
code:.cs
 [Guid("xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
 private interface IDirectSoundCapture8
 {
     [PreserveSig]
     int CreateCaptureBuffer(ref DSCBUFFERDESC pcDSCBufferDesc, out IntPtr ppDSCBuffer, [MarshalAs(UnmanagedType.IUnknown)] object pUnkOuter);
     [PreserveSig]
     int GetCaps(ref DSCCAPS pDSCCaps);
     [PreserveSig]
     int Initialize(ref Guid pcGuidDevice);
 }

https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/interop/example-com-class

code:.cs
     [Guid("EAA4976A-45C3-4BC5-BC0B-E474F4C3C83F")]
     public interface ComClass1Interface
     {
     }

[* Marshal]
	Marshal.QueryInterface
		GUID => IntPtr
	Marshal.AddRef
 Marshal.Release(IntPtr)
 Marshal.ReleaseComObject(Object)
	Marshal.GetTypedObjectForIUnknown(IntPtr)
		[C#でCOMを使ってみた。その２ http://makky12.hatenablog.com/entry/2016/08/04/203558]
		IntPtr => Object(RCW) => cast interface
	Marshal.IsComObject

 Marshal.GetComInterfaceForObject
	Marshal.GetComInterfaceForObjectInContext(Object, Type)
		=> IntPtr
	Marshal.GetIUnknownForObject
		=> IntPtr
	Marshal.GetIUnknownForObjectInContext

error handling
	Marshal.GetExceptionForHR
	Marshal.GetHRForException

typeinfo
	Marshal.GetITypeInfoForType
	Marshal.GetITypeInfoForType

slot
	Marshal.GetStartComSlot
	Marshal.GetEndComSlot(Type) Method
	Marshal.GetMethodInfoForComSlot(Type, Int32, ComMemberType) Method
	Marshal.GetComSlotForMethodInfo(MemberInfo) Method


[* wrapper]

RCWは、ComInterfaceをC#使う場合。

CCW は、C# でComを定義する場合？
	https://docs.microsoft.com/en-us/dotnet/standard/native-interop/com-callable-wrapper?view=netframework-4.8

[* IDispatch]
d3d11とかでは出てこない
https://docs.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.comimportattribute?view=netframework-4.8
