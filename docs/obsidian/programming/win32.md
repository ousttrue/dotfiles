Win32
#Windows

code:.cpp
 struct Gwlp
 {
     // last param of CreateWindow to GWLP
     static void Set(HWND hWnd, LPARAM lParam)
     {
         auto pCreateStruct = reinterpret_cast<LPCREATESTRUCT>(lParam);
         SetWindowLongPtr(hWnd, GWLP_USERDATA, reinterpret_cast<LONG_PTR>(pCreateStruct->lpCreateParams));
     }
 
     template <class T>
     static T *Get(HWND hWnd)
     {
         return reinterpret_cast<T *>(GetWindowLongPtr(hWnd, GWLP_USERDATA));
     }
 };
	

https://bluefish.orz.hm/sdoc/winprog_tips.html#Close出来ないように
