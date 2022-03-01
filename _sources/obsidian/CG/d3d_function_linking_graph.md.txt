function-linking-graph
#d3d11

https://docs.microsoft.com/en-us/windows/win32/direct3dhlsl/using-shader-linking
	https://docs.microsoft.com/en-us/windows/win32/direct3dhlsl/pachaging-a-shader-library module 作る
	https://docs.microsoft.com/en-us/windows/win32/direct3dhlsl/constructing-a-function-linking-graph

[* ID3D11LinkingNode]
https://docs.microsoft.com/en-us/windows/win32/api/d3d11shader/nn-d3d11shader-id3d11linkingnode

input
https://docs.microsoft.com/en-us/windows/win32/api/d3d11shader/nf-d3d11shader-id3d11functionlinkinggraph-setinputsignature

output
https://docs.microsoft.com/en-us/windows/win32/api/d3d11shader/nf-d3d11shader-id3d11functionlinkinggraph-setoutputsignature

function call
https://docs.microsoft.com/en-us/windows/win32/api/d3d11shader/nf-d3d11shader-id3d11functionlinkinggraph-callfunction
モジュール内の関数を呼び出す？

[* PassValue]
node を連結する
https://docs.microsoft.com/en-us/windows/win32/api/d3d11shader/nf-d3d11shader-id3d11functionlinkinggraph-passvalue

[* ModuleInstance]
ID3D11ModuleInstance 
constant buffer とかのバインド
https://docs.microsoft.com/en-us/windows/win32/api/d3d11shader/nn-d3d11shader-id3d11moduleinstance

[* Moduule]
ID3D11Module
関数とかが入っている？
D3DLoadModule 


http://masafumi.cocolog-nifty.com/masafumis_diary/2014/05/windows-81direc.html
http://microsoftdevelopernetworksamples.blogspot.com/2017/06/windowsappshlsl-shader-compiler-sample.html
https://i1.code.msdn.s-msft.com/Windows-8-Modern-Style-App-Samples

https://github.com/microsoft/VCSamples/tree/master/VC2012Samples/Windows%208%20samples/C%2B%2B/Windows%208%20app%20samples

code:.xml
```xml
 <?xml version="1.0" encoding="utf-8"?>
 
 <Package
   xmlns="http://schemas.microsoft.com/appx/manifest/foundation/windows10"
   xmlns:mp="http://schemas.microsoft.com/appx/2014/phone/manifest"
   xmlns:uap="http://schemas.microsoft.com/appx/manifest/uap/windows10"
   IgnorableNamespaces="uap mp">
 
   <Identity
     Name="7eed9f6b-ee1e-41dc-a4bc-cbe2e85db97f"
     Publisher="CN=oustt"
     Version="1.0.0.0" />
 
   <mp:PhoneIdentity PhoneProductId="7eed9f6b-ee1e-41dc-a4bc-cbe2e85db97f" PhonePublisherId="00000000-0000-0000-0000-000000000000"/>
 
   <Properties>
     <DisplayName>App1</DisplayName>
     <PublisherDisplayName>oustt</PublisherDisplayName>
     <Logo>Assets\StoreLogo.png</Logo>
   </Properties>
 
   <Dependencies>
     <TargetDeviceFamily Name="Windows.Universal" MinVersion="10.0.0.0" MaxVersionTested="10.0.0.0" />
   </Dependencies>
 
   <Resources>
     <Resource Language="x-generate"/>
   </Resources>
 
   <Applications>
     <Application Id="App"
       Executable="$targetnametoken$.exe"
       EntryPoint="App1.App">
       <uap:VisualElements
         DisplayName="App1"
         Square150x150Logo="Assets\Square150x150Logo.png"
         Square44x44Logo="Assets\Square44x44Logo.png"
         Description="App1"
         BackgroundColor="transparent">
         <uap:DefaultTile Wide310x150Logo="Assets\Wide310x150Logo.png"/>
         <uap:SplashScreen Image="Assets\SplashScreen.png" />
       </uap:VisualElements>
     </Application>
   </Applications>
 
   <Capabilities>
     <Capability Name="internetClient" />
   </Capabilities>
 </Package>
```
