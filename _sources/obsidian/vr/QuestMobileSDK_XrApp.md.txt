[[QuestMobileSDK]]

# OVRFW::XrApp
[Using XrApp](https://developer.oculus.com/documentation/native/android/mobile-physical-tracked-keyboard/#native-integration)
base class

```c++
class XrApp {
public:
    // Called when the application initializes.
    // Must return true if the application initializes successfully.
    virtual bool AppInit(const xrJava* context);
    // Called when the application shuts down
    virtual void AppShutdown(const xrJava* context);
    virtual bool SessionInit();
    virtual void SessionEnd();
    virtual void Update(const ovrApplFrameIn& in);
    virtual void Render(const ovrApplFrameIn& in, ovrRendererOutput& out);

    // App state share
    std::unique_ptr<OVRFW::ovrFileSys> FileSys;
    OVRFW::ovrFileSys* GetFileSys() {
        return FileSys.get();
    }
};

#if defined(ANDROID)

#define ENTRY_POINT(appClass)                     \
    void android_main(struct android_app* app) {  \
        auto appl = std::make_unique<appClass>(); \
        appl->Run(app);                           \
    }

#elif defined(WIN32)

#define ENTRY_POINT(appClass)                               \
    __pragma(comment(linker, "/SUBSYSTEM:WINDOWS"));        \
    int APIENTRY WinMain(HINSTANCE, HINSTANCE, PSTR, int) { \
        auto appl = std::make_unique<appClass>();           \
        appl->Run();                                        \
        return 0;                                           \
    }

void XrApp::MainLoop(MainLoopContext& loopContext) {
    Init(loopContext.GetJavaContext());
    InitSession();

    bool stageBoundsDirty = true;
    int frameCount = -1;
    while (!loopContext.ShouldExitMainLoop()) {
        frameCount++;

		// FRAME
    }

    EndSession();
    Shutdown(loopContext.GetJavaContext());
}
```

## Render/GlWrapperWin32.c
`Windows`
GLEW 等に頼らずに OpenGLES 互換？の OpenGL context 自前で初期化している
`XR_TYPE_GRAPHICS_REQUIREMENTS_OPENGL_KHR`

`xrGetOpenGLGraphicsRequirementsKHR`
`ovrEgl_CreateContext(&Egl, NULL);`
`ovrGl_CreateContext_Windows`
`ksGpuWindow_Create`

## Android
`XR_TYPE_GRAPHICS_REQUIREMENTS_OPENGL_ES_KHR`

# EachFrame
`void XrApp::AppRenderFrame(const OVRFW::ovrApplFrameIn& in, OVRFW::ovrRendererOutput& out)`

# OVRFW::TinyUI

Windows で動くには、`.exe` からの相対パスにリソースの配置が必要
- font
- assets

```c++
class TinyUI {
   public:
    TinyUI() : GuiSys(nullptr), Locale(nullptr) {}
    ~TinyUI() {}
    bool Init(const xrJava* context, OVRFW::ovrFileSys* FileSys, bool updateColors = true);
    void Shutdown();
    void Update(const OVRFW::ovrApplFrameIn& in);
    void Render(const OVRFW::ovrApplFrameIn& in, OVRFW::ovrRendererOutput& out);

   private:
    OVRFW::OvrGuiSys* GuiSys;
};
```

# GUI/GuiSys.cpp
## OVRFW::OvrGuiSys

## OvrGuiSysLocal : public OvrGuiSys
```c++
    ovrFileSys* FileSys;
```

# Render/BitmapFont.cpp
## BitmapFontLocal

## BitmapFontSurfaceLocal
- TinyUI::Render
- OvrGuiSysLocal::Frame
- BitmapFontSurfaceLocal::Finish
- Vector3f BitmapFontSurfaceLocal::DrawText3D
- DrawTextToVertexBlock
```c++
    BitmapFontSurface* DefaultFontSurface;
    std::vector<VertexBlockType>
        VertexBlocks; // each pointer in the array points to an allocated block ov
```

### BitmapFontSurfaceLocal::Finish` で `nan` によりクラッシュする
- VRMenuObject::TransformByParent => scale nan
- localScale

```c++
class VRMenuObject
{
    OVR::Vector3f LocalScale; // local-space scale of this item
    // Initialize the object after creation
    void Init(OvrGuiSys& guiSys, VRMenuObjectParms const& parms);

            Vector2f dims = Surfaces[0].GetDims();

};

class VRMenuSurface
{
	OVR::Vector2f Dims; // width and height
};
```


# OVR_FileSys.cpp
## ovrFileSys
```c++
    FileSys = std::unique_ptr<OVRFW::ovrFileSys>(ovrFileSys::Create(context));
```

# ovrscene
古い SDK の asset ?
- [Oculus Mobile SDK 33.0](https://developer.oculus.com/downloads/package/oculus-mobile-sdk/)
- [GitHub - naturalinteraction/oculo: Test with Oculus Go.](https://github.com/naturalinteraction/oculo)

zip の拡張子を変えているぽい？
- boxbake.ktx
- models.bin
- models.json

# XrSamples
- [Mobile OpenXR Samples](https://developer.oculus.com/documentation/native/android/mobile-openxr-sample/)
## ovrbuild
`bin/scripts/build/ovrbuild.py`
環境変数
- JAVA_HOME = AndroidStudio_INSTALL/jre
- ANDROID_HOME = %USERPROFILE%/AppData/Local/Android/sdk
- ANDROID_NDK_HOME = %ANDROID_HOME%/ndk/NDK_VERSION
が必用。

`D:\OpenXRMobileSDK\bin\scripts\build\../../../gradlew assembleRelease --daemon -quiet --build-cache --configure-on-demand --parallel -Pshould_install`

## XrAppBase
## XrBodyTrackingFB
## XrColorSpaceFB
## XrCompositor_NativeActivity
## XrEyeTrackingSocialFB
## XrFaceTrackingFB
## XrHandsFB
## XrKeyboard
## XrPassthrough
## XrSceneModel
## XrSpaceWarp
## XrSpatialAnchor
## XrTouchControllerPro
