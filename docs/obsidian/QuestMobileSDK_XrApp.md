[[QuestMobileSDK]]

# xrSamples
- [Mobile OpenXR Samples](https://developer.oculus.com/documentation/native/android/mobile-openxr-sample/)

## ovrbuild
`bin/scripts/build/ovrbuild.py`
環境変数
- JAVA_HOME = AndroidStudio_INSTALL/jre
- ANDROID_HOME = %USERPROFILE%/AppData/Local/Android/sdk
- ANDROID_NDK_HOME = %ANDROID_HOME%/ndk/NDK_VERSION
が必用。

`D:\OpenXRMobileSDK\bin\scripts\build\../../../gradlew assembleRelease --daemon -quiet --build-cache --configure-on-demand --parallel -Pshould_install`

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
