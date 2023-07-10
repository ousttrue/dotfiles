[[spout]]

# ID3D11Texture2D: create
## D3D11_RESOURCE_MISC_SHARED

## D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX
`from windows8`
> **D3D11_RESOURCE_MISC_SHARED** and **D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX** are mutually exclusive.	
```c++
dstDesc.MiscFlags = D3D11_RESOURCE_MISC_SHARED_KEYEDMUTEX | D3D11_RESOURCE_MISC_SHARED_NTHANDLE;
```

- [Direct3DとDirect2D/DirectWriteの連携 | shobomalog](https://shobomaru.wordpress.com/2012/11/17/interop-direct3d-and-direct2d-directwrite/)
- IDXGIKeyedMutex::AcquireSync
- IDXGIKeyedMutex::ReleaseSync 

## CreateSharedHandle
### IDXGIResource1
```c++
			HANDLE handle;
			auto hr = otherResource->CreateSharedHandle(NULL //&secAttr
				, DXGI_SHARED_RESOURCE_READ
				, name.c_str() // 👈 named
				, &handle);
```

### IDXGIResource
```c++
GetSharedHandle(&handle)
```

# ID3D11Device::OpenSharedResource

ID3D11Device1::OpenSharedResourceByName メソッドを呼び出して共有リソースに名前でアクセスする場合は、リソース名が必要です。 代わりに ID3D11Device1::OpenSharedResource1 
