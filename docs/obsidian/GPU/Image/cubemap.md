cubemap
#d3d12 #equirectangular #IBL

https://tositeru.github.io/ImasaraDX11/part/texture2
https://riyaaaaasan.hatenablog.com/entry/2018/03/06/005444


https://docs.microsoft.com/en-us/windows/win32/direct3d11/overviews-direct3d-11-resources-textures-intro#using-a-2d-texture-array-as-a-texture-cube

https://channel9.msdn.com/Series/CDirectX-Game-Development-Skyboxes-and-Porting-DX11-to-112/04

https://docs.microsoft.com/en-us/windows/win32/direct3d9/cubic-environment-mapping
https://github.com/KhronosGroup/glTF-Sample-Environments

[ミップマップを使ってラフネスのある材質のリフレクションを実装した https://riyaaaaasan.hatenablog.com/entry/2018/04/11/220629]

[【Unity】Shader GraphでStylizedなSkyboxシェーダを実装する【Advent Calendar 12/5】](https://media.colorfulpalette.co.jp/n/n136e0ef5e1e7)

resource


2DTextureの配列
	+x
	-x
	+y
	-y
	+z
	-z
code:resource.cpp
 D3D12_RESOURCE_DESC desc{
     .Dimension = D3D12_RESOURCE_DIMENSION_TEXTURE2D,
     .Alignment = 0,
     .Width = width,
     .Height = height,
     .DepthOrArraySize = 6, // cube !
     .MipLevels = 1,
     .Format = DXGI_FORMAT_R8G8B8A8_UNORM,
     .SampleDesc = {1, 0},
     .Layout = D3D12_TEXTURE_LAYOUT_UNKNOWN,
     .Flags = D3D12_RESOURCE_FLAG_NONE,
 };

view
code:view.cpp
 D3D12_SHADER_RESOURCE_VIEW_DESC desc{
     .Format = DXGI_FORMAT_R8G8B8A8_UNORM,
     .ViewDimension = D3D12_SRV_DIMENSION_TEXTURECUBE,
     .Shader4ComponentMapping = D3D12_DEFAULT_SHADER_4_COMPONENT_MAPPING,
     .TextureCube = {
         .MostDetailedMip = 0,
         .MipLevels = 1,
         .ResourceMinLODClamp = 0.0f,
     },
 };



CubeTexture
[HLSLのTextureCubeの情報が少なすぎる https://riyaaaaasan.hatenablog.com/entry/2018/03/06/005444]
https://blog.techlab-xe.net/directx12-cubemap-1/

	D3D12_SRV_DIMENSION_TEXTURECUBE 
	D3D12_SRV_DIMENSION_TEXTURECUBEARRAY

vertical cross
	https://knowledge.shade3d.jp/knowledgebase/6面に分離されたキューブマップテクスチャをファ


https://github.com/dariomanesku/cmftStudio
https://github.com/SaschaWillems/Vulkan-glTF-PBR/blob/master/data/environments/README.md

Equi
https://ja.coder.work/so/c%2B%2B/432448

https://matheowis.github.io/HDRI-to-CubeMap/

[* create cubemap]
https://www.codeintrinsic.com/blender-how-to-create-cubemap-and-enviroment-textures/

[* dynamic sky]
https://ceriseworks.com/dynamic-sky/

https://blender.stackexchange.com/questions/46891/how-to-render-an-environment-to-a-cube-map-in-cycles
[https://qiita.com/shujimuna1102/items/1e37a924919de0d016f0 PlayCanvasのEnvironmentに入れるSphereMap/cubeMapをBlenderで作ってみよう。 - Qiita]


[https://www.youtube.com/watch?v=JdsTb_vbRBE]

