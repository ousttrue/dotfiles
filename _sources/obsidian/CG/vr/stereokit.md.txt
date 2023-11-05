[[vr]]

- [StereoKit | StereoKit Documentation](https://stereokit.net/)
	- [StereoKit - .NET を使用してMixed Realityする - Events | Microsoft Learn](https://learn.microsoft.com/ja-jp/events/mixed-reality-dev-days/stereokit-mixed-reality-using-dotnet)
- [GitHub - StereoKit/StereoKit: An easy-to-use mixed reality library for building HoloLens and VR applications with C# and OpenXR!](https://github.com/StereoKit/StereoKit)

# build
## Desktop
cmake

## StereoKitCTest

# API
## sk_init
```cpp
	system_t sys_app = { "App" };
	const char *app_update_deps[] = {"Input", "Defaults", "FrameBegin", "Platform", "Physics", "Renderer", "UI"};
	sys_app.update_dependencies     = app_update_deps;
	sys_app.update_dependency_count = _countof(app_update_deps);
	sys_app.func_update             = sk_app_update;
	systems_add(&sys_app);

void systems_add(const system_t *system) {
	systems.add(*system);
}
```

### systems.Platform
```cpp
void win32_step_begin_xr() {
	MSG msg = {0};
	while (PeekMessage(&msg, win32_window, 0U, 0U, PM_REMOVE)) {
		TranslateMessage(&msg);
		DispatchMessage (&msg);
	}
}

void openxr_step_begin() {
	openxr_poll_events();
	if (xr_running)
		openxr_poll_actions();
}
```

### systems.FrameBegin
### systems.FrameRender
### systems.Default
### systems.UI
### systems.Physics
### systems.App

## sk_run
```c++
void sk_run(void (*app_update)(void), void (*app_shutdown)(void)) {
	sk_assert_thread_valid();
	sk_first_step = true;
	
#if defined(SK_OS_WEB)
	web_start_main_loop(app_update, app_shutdown);
#else
	while (sk_step(app_update));

	if (app_shutdown != nullptr)
		app_shutdown();
	sk_shutdown();
#endif
}
```

### sk_step
- system_update
```cpp
void systems_update() {
	for (size_t i = 0; i < systems.count; i++) {
		if (systems[i].func_update != nullptr) {
			// start timing
			systems[i].profile_frame_start = stm_now();

			systems[i].func_update();

			// end timing
			if (systems[i].profile_frame_duration == 0)
				systems[i].profile_frame_duration = stm_since(systems[i].profile_frame_start);
			systems[i].profile_update_duration += systems[i].profile_frame_duration;
			systems[i].profile_update_count    += 1;
			systems[i].profile_frame_duration   = 0;
		}
	}
}
```
