# layout
`app/src/main/res/layout/activity_main.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">
    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Hello World!"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent" />
</androidx.constraintlayout.widget.ConstraintLayout>
```


# GLSurfaceView
- [SurfaceView と GLSurfaceView  |  Android オープンソース プロジェクト  |  Android Open Source Project](https://source.android.com/docs/core/graphics/arch-sv-glsv?hl=ja)
- [OpenGL ES 環境の構築  |  Android デベロッパー  |  Android Developers](https://developer.android.com/training/graphics/opengl/environment?hl=ja)
- [GLSurfaceView  |  Android Developers](https://developer.android.com/reference/android/opengl/GLSurfaceView)
- [GLSurfaceViewの利点と使い方 | Android-Note](https://android-note.open-memo.net/sub/other--use-gl-surface-view.html)
- [Android の OpenGL ES と SurfaceView / GLSurfaceView](https://www.scaredeer.com/2021/03/android-opengl-es-surfaceview-glsurfaceview.html)

[[android_ndk]]

```java
class GLES3JNIView extends GLSurfaceView
{
}
```
