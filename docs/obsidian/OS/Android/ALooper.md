https://developer.android.com/ndk/reference/group/looper

- @2023 [AndroidオーディオスレッドのディスパッチをALooperで実装する](https://zenn.dev/atsushieno/articles/7c8de205676ebb)

# Version

## ndk r29

## ndk r28 Replace ALooper_pollAll with ALooper_pollOnce

- [Replace ALooper_pollAll with ALooper_pollOnce. by DanAlbert · Pull Request #1008 · android/ndk-samples · GitHub](https://github.com/android/ndk-samples/pull/1008)

```
looper.h:234:5: note: 'ALooper_pollAll' has been explicitly marked unavailable here
```

## ndk r27 ALooper_pollAll deprecated

- [ALooper_pollAll is removed in Android NDK to 27 · Issue #9505 · defold/defold · GitHub](https://github.com/defold/defold/issues/9505)

- [Android backend build error: ALooper_pollAll has been deprecated on Android NDK Version 27 · Issue #8013 · ocornut/imgui · GitHub](https://github.com/ocornut/imgui/issues/8013)
