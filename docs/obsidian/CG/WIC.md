WIC
#wic

	https://docs.microsoft.com/en-us/windows/desktop/wic/-wic-lh

	https://docs.microsoft.com/en-us/windows/desktop/direct3d11/overviews-direct3d-11-resources-textures-how-to

[* CreateBitmap]
	[https://msdn.microsoft.com/en-us/library/windows/desktop/ff973956.aspx Chapter 11: Using the Windows Imaging Component]
code:create_bitmap.cpp
 #include <wincodec.h>
 #include <wrl/client.h>
 
    static Microsoft::WRL::ComPtr<IWICBitmap> CreateBitmap(int w, int h)
    {
        Microsoft::WRL::ComPtr<IWICImagingFactory> factory;
        auto hr = CoCreateInstance(
            CLSID_WICImagingFactory,
            NULL,
            CLSCTX_INPROC_SERVER,
            IID_PPV_ARGS(&factory)
        );
        if (FAILED(hr)) {
            return nullptr;
        }
	
        Microsoft::WRL::ComPtr<IWICBitmap> bitmap;
        hr = factory->CreateBitmap(w, h,
            GUID_WICPixelFormat32bppBGRA,
            WICBitmapCacheOnLoad,
            &bitmap
        );
        if (FAILED(hr)) {
            return nullptr;
        }
	
        return bitmap;
    }

[* GetRawData]
	https://docs.microsoft.com/en-us/windows/desktop/wic/-wic-bitmapsources-howto-modifypixels

code:lock.cpp
 void D2DGraphics::End(const LockFunc &callback)
 {
 	m_renderTarget->EndDraw();
 
 	UINT w, h;
 	auto hr = m_bitmap->GetSize(&w, &h);
 	if (FAILED(hr)) {
 		return;
 	}
 
 	Microsoft::WRL::ComPtr<IWICBitmapLock> lock;
 	WICRect rcLock = { 0, 0, w, h };
 	hr = m_bitmap->Lock(&rcLock, WICBitmapLockWrite, &lock);
 	if (FAILED(hr)) {
 		return;
 	}
 
 	UINT cbBufferSize = 0;
 	BYTE *pv = NULL;
 
 	// Retrieve a pointer to the pixel data.
 	hr = lock->GetDataPointer(&cbBufferSize, &pv);
 
 	// Pixel manipulation using the image data pointer pv.
 	callback(w, h, cbBufferSize, pv);
 }
