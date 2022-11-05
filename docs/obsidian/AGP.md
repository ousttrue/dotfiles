```
./gradlew assembleDebug
```

gradle `7.4` => AGP `7.3.1`
```groovy
dependencies {
	classpath 'com.android.tools.build:gradle:7.3.1'
}
```
- [ビルドを設定する  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/build?hl=ja)
- [Class Index  |  Android Developers](https://developer.android.com/reference/tools/gradle-api/7.3/classes?hl=ja)
Android Gradle Plugin
- [Android Gradle plugin API reference  |  Android Developers](https://developer.android.com/reference/tools/gradle-api?hl=ja)
- [Android Gradle プラグインのリリースノート  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/releases/gradle-plugin?hl=ja)
- [Android Gradle プラグインの DSL / API の移行スケジュール  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/releases/gradle-plugin-roadmap?hl=ja)
# root
## gradle.properties
## local.properties
`.gitignore`
## build.gradle
```groovy
plugins {
	/**
     * You should use `apply false` in the top-level build.gradle file
     * to add a Gradle plugin as a build dependency, but not apply it to the
     * current (root) project. You should not use `apply false` in sub-projects.
     * For more information, see
     * [Applying external plugins with same version to subprojects](https://docs.gradle.org/current/userguide/plugins.html#sec:subprojects_plugins_dsl).
     */
     id 'com.android.application'  version '7.3.0'   apply false
     id 'com.android.library'   version '7.3.0' apply false
     id 'org.jetbrains.kotlin.android' version '1.7.10' apply false
}
task clean(type: Delete) {
	delete rootProject.buildDir
}
// This block encapsulates custom properties and makes them available to all
// modules in the project. The following are only a few examples of the types
// of properties you can define.
ext {
	sdkVersion = 28
	// You can also create properties to specify versions for dependencies.
	// Having consistent versions between modules can avoid conflicts with behavior.
	supportLibVersion = "28.0.0"
}
```
## settings.gradle
```groovy
pluginManagement {
	/**
     * The pluginManagement {repositories {...}} block configures the
     * repositories Gradle uses to search or download the Gradle plugins and
     * their transitive dependencies. Gradle pre-configures support for remote
     * repositories such as JCenter, Maven Central, and Ivy. You can also use
     * local repositories or define your own remote repositories. The code below
     * defines the [Gradle Plugin Portal](https://plugins.gradle.org/), [Google's Maven repository](https://developer.android.com/studio/build/dependencies?agpversion=4.1&buildsystem=ndk-build&hl=ja#google-maven),
     * and the [Maven Central Repository](https://search.maven.org/) as the repositories Gradle should use to look for its dependencies.
     */
	 repositories {
		 gradlePluginPortal()
		 google()
		 mavenCentral()
	 }
}
dependencyResolutionManagement {
	/**
     * The dependencyResolutionManagement { repositories {...}}
     * block is where you configure the repositories and dependencies used by
     * all modules in your project, such as libraries that you are using to
     * create your application. However, you should configure module-specific
     * dependencies in each module-level build.gradle file. For new projects,
     * Android Studio includes [Google's Maven repository](https://developer.android.com/studio/build/dependencies?agpversion=4.1&buildsystem=ndk-build&hl=ja#google-maven)     * and the [Maven Central Repository](https://search.maven.org/) by
     * default, but it does not configure any dependencies (unless you select a
     * template that requires some).
     */
     repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
     repositories {
	     google()
	     mavenCentral()
	 }
}
rootProject.name = "My Application"
include ‘:app’
```
# module
- [アプリ モジュールを設定する  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/build/configure-app-module?hl=ja)
build.gradle
```groovy
/**
 * The first line in the build configuration applies the Android plugin for
 * Gradle to this build and makes the android block available to specify
 * Android-specific build options.
 */
plugins {
	id 'com.android.application'
}
/**
 * The android block is where you configure all your Android-specific
 * build options.
 */
 android {
	 /**
     * The app's [namespace](https://developer.android.com/studio/build/configure-app-module?hl=ja#set-namespace). Used primarily to access app resources.
     */    namespace 'com.example.myapp'    /**
     * compileSdkVersion specifies the Android API level Gradle should use to
     * compile your app. This means your app can use the API features included in
     * this API level and lower.
     */    compileSdkVersion 28    /**
     * The defaultConfig block encapsulates default settings and entries for all
     * build variants, and can override some attributes in main/AndroidManifest.xml
     * dynamically from the build system. You can configure product flavors to override
     * these values for different versions of your app.
     */
    defaultConfig {
	    applicationId "com.example.myapp"
	    minSdkVersion 15
	    targetSdkVersion 24
	    versionCode 1
	    versionName "1.0"
	}
     defaultConfig {        // Uniquely identifies the package for publishing.        applicationId 'com.example.myapp'        // Defines the minimum API level required to run the app.        minSdkVersion 15        // Specifies the API level used to test the app.        targetSdkVersion 28        // Defines the version number of your app.        versionCode 1        // Defines a user-friendly version name for your app.        versionName "1.0"    }    /**
     * The buildTypes block is where you can configure multiple [build types](https://developer.android.com/studio/build/build-variants?hl=ja#build-types).
     * By default, the build system defines two build types: debug and release. The
     * debug build type is not explicitly shown in the default build configuration,
     * but it includes debugging tools and is signed with the debug key. The release
     * build type applies Proguard settings and is not signed by default.
     */    buildTypes {        /**
         * By default, Android Studio configures the release build type to enable code
         * shrinking, using minifyEnabled, and specifies the default Proguard rules file.
         */        release {              minifyEnabled true // Enables code shrinking for the release build type.              proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'        }    }    /**
     * The productFlavors block is where you can configure multiple [product flavors](https://developer.android.com/studio/build/build-variants?hl=ja#product-flavors).
     * This allows you to create different versions of your app that can
     * override the defaultConfig block with their own settings. Product flavors
     * are optional, and the build system does not create them by default.
     *
     * This example creates a free and paid product flavor. Each product flavor
     * then specifies its own application ID, so that they can exist on the Google
     * Play Store, or an Android device, simultaneously.
     *
     * If you declare product flavors, you must also declare flavor dimensions
     * and assign each flavor to a flavor dimension.
     */    [flavorDimensions](https://developer.android.com/reference/tools/gradle-api/current/com/android/build/api/dsl/ProductFlavor?hl=ja#dimension) "tier"    productFlavors {        free {            dimension "tier"            applicationId 'com.example.myapp.free'        }        paid {            dimension "tier"            applicationId 'com.example.myapp.paid'        }    }
}
/**
 * The dependencies block in the module-level build configuration file
 * specifies dependencies required to build only the module itself.
 * To learn more, go to [Add build dependencies](https://developer.android.com/studio/build/dependencies?hl=ja).
 */dependencies {    implementation project(":lib")    implementation 'com.android.support:appcompat-v7:28.0.0'    implementation fileTree(dir: 'libs', include: ['*.jar'])
}
android {
	// Use the following syntax to access properties you defined at the project level:
	// rootProject.ext.property_name
	compileSdkVersion rootProject.ext.compileSdkVersion
}
dependencies {
implementation "com.android.support:appcompat-v7:${rootProject.ext.supportLibVersion}"
}
```

# BuildVariant ( productFlavors + buildTypes)
- [ビルド バリアントを設定する  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/build/build-variants?hl=ja)
- [ProductFlavor  |  Android Developers](https://developer.android.com/reference/tools/gradle-api/7.1/com/android/build/api/dsl/ProductFlavor?hl=ja#dimension)

```groovy
android {
    // Specifies one flavor dimension.    
	flavorDimensions "version"
	productFlavors {        
		demo {            
			// Assigns this product flavor to the "version" flavor dimension.
			// If you are using only one dimension, this property is optional,
			// and the plugin automatically assigns all the module's flavors to 
		   // that dimension.
		   dimension "version"
		   applicationIdSuffix ".demo"
		   versionNameSuffix "-demo"
	   }        
	   
	   full {            
		   dimension "version"            
		   applicationIdSuffix ".full"            
		   versionNameSuffix "-full"        
	   }    
   }
}
```

# SourceSet
```groovy
android {
	sourceSets {
		main {
			// src/main
			java.srcDirs = ['other/java']
			manifest.srcFile = 'other/AndroidManifest.xml'
		}
	}
}
```

# CMake
- [NDK と CMake のインストールと設定  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/projects/install-ndk?hl=ja#default-version)
> `3.10.2` がデフォルト

```groovy
externalNativeBuild {
	cmake {
		version '3.22.1' // 効かない？
		cppFlags '-DDEFAULT_GRAPHICS_PLUGIN_OPENGLES'
	}
}
```

代替
local.properties
```groovy
cmake.dir=C\:\\Users\\oustt\\AppData\\Local\\Android\\Sdk\\cmake\\3.22.1
```

CMAKE_LIBRARY_OUTPUT_DIRECTORY = build/intermediates/cxx/Debug/2a4p5z4v/obj/arm64-v8a
- add_library SHARED
- add_library SHARED IMPORTED
	- [CMake: IMPORTEDターゲット - Qiita](https://qiita.com/osamu0329/items/3e9868e83d3745b8c8b6)
- add_library MODULE

## cmake
      "CMAKE_EXE" ^
        "-H%USERPROFILE%\\ghq\\github.com\\ousttrue\\openxr_samples\\hello_xr\\app" ^
        "-DCMAKE_SYSTEM_NAME=Android" ^
        "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
        "-DCMAKE_SYSTEM_VERSION=24" ^
        "-DANDROID_PLATFORM=android-24" ^
        "-DANDROID_ABI=arm64-v8a" ^
        "-DCMAKE_ANDROID_ARCH_ABI=arm64-v8a" ^
        "-DANDROID_NDK=D:\\AndroidSdk\\ndk\\21.4.7075529" ^
        "-DCMAKE_ANDROID_NDK=D:\\AndroidSdk\\ndk\\21.4.7075529" ^
        "-DCMAKE_TOOLCHAIN_FILE=D:\\AndroidSdk\\ndk\\21.4.7075529\\build\\cmake\\android.toolchain.cmake" ^
        "-DCMAKE_MAKE_PROGRAM=D:\\AndroidSdk\\cmake\\3.18.1\\bin\\ninja.exe" ^
        "-DCMAKE_CXX_FLAGS=-DDEFAULT_GRAPHICS_PLUGIN_OPENGLES" ^
        "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=%USERPROFILE%\\ghq\\github.com\\ousttrue\\openxr_samples\\hello_xr\\app\\build\\intermediates\\cxx\\Debug\\4fc1c5w5\\obj\\arm64-v8a" ^
        "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=%USERPROFILE%\\ghq\\github.com\\ousttrue\\openxr_samples\\hello_xr\\app\\build\\intermediates\\cxx\\Debug\\4fc1c5w5\\obj\\arm64-v8a" ^
        "-DCMAKE_BUILD_TYPE=Debug" ^
        "-B%USERPROFILE%\\ghq\\github.com\\ousttrue\\openxr_samples\\hello_xr\\app\\.cxx\\Debug\\4fc1c5w5\\arm64-v8a" ^
        -GNinja
		