[[runtime]]

# Sample
```cpp
static LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam,
                                LPARAM lParam) {
  if (message == WM_CREATE) {
    auto p = reinterpret_cast<LPCREATESTRUCT>(lParam);
    SetWindowLongPtr(hWnd, GWLP_USERDATA,
                     reinterpret_cast<LONG_PTR>(p->lpCreateParams));
    return 0;
  }

  auto w = reinterpret_cast<Window *>(GetWindowLongPtr(hWnd, GWLP_USERDATA));
  if (w) {
    return w->proc(hWnd, message, wParam, lParam);
  } else {
    return DefWindowProcA(hWnd, message, wParam, lParam);
  }
}
```

```cpp
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
```
	

https://bluefish.orz.hm/sdoc/winprog_tips.html#Close出来ないように
