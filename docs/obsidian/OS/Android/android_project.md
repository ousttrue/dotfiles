[[Android]]

Projectの構成

# [[gradle]]

- [ビルドを設定する  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/build?hl=ja)
- [Android Gradle plugin API reference  |  Android Developers](https://developer.android.com/reference/tools/gradle-api?hl=ja)

## build.gradle

```groovy
// Top-level build file where you can add configuration options common to all sub-projects/modules.
plugins {
    id 'com.android.application' version '7.3.1' apply false
    id 'com.android.library' version '7.3.1' apply false
    id 'org.jetbrains.kotlin.android' version '1.7.20' apply false
}
```

## settings.gradle
プロジェクト設定

```groovy
pluginManagement {
    repositories {
        gradlePluginPortal()
        google()
        mavenCentral()
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.name = "My Application"
include ':app' // app module
```

## modules
- [Android のモジュールのパスを簡潔にする - Qiita](https://qiita.com/beyondseeker/items/6a1f0caddf995f5df46d)

### app/build.gradle

- [アプリ モジュールを設定する  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/build/configure-app-module?hl=ja)
- アプリケーション ID は名前空間と同じにしておきます。

```groovy
plugins {
    id 'com.android.application'
    id 'org.jetbrains.kotlin.android'
}
  
android {
    namespace 'com.example.myapplication'
    compileSdk 32
  
    defaultConfig {
        applicationId "com.example.myapplication"
        minSdk 21
        targetSdk 32
        versionCode 1
        versionName "1.0"

        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }
}

dependencies {
    implementation 'androidx.core:core-ktx:1.7.0'
    implementation 'androidx.appcompat:appcompat:1.4.1'
    implementation 'com.google.android.material:material:1.5.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.3'
    testImplementation 'junit:junit:4.13.2'
    androidTestImplementation 'androidx.test.ext:junit:1.1.3'
    androidTestImplementation 'androidx.test.espresso:espresso-core:3.4.0'
}
```

### app/src/main appモジュールの main ソースセット
#### app/src/main/AndroidManifest.xml
- @2018 [AndroidManifestについて](https://sasakiyuki.github.io/posts/android_document_android_manifest/)

```xml
<?xml version="1.0" encoding="utf-8"?>

<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">
    <application
        android:allowBackup="true"
        android:dataExtractionRules="@xml/data_extraction_rules"
        android:fullBackupContent="@xml/backup_rules"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.MyApplication"
        tools:targetApi="31">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
            <meta-data
                android:name="android.app.lib_name"
                android:value="" />
        </activity>
    </application>
</manifest>
```

`{namespace}.MainActivity`

#### app/src/main/java/com/example/myapplication/MainActivity.kt

```kotlin
package com.example.myapplication

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
		// resource layout activity_main
        setContentView(R.layout.activity_main) // view が描画
    }
}
```

=> [[android_view]]
