
# LEAP_CONNECTION_MESSAGE
```c++
void serviceMessageLoop(){
	LEAP_CONNECTION_MESSAGE msg;
	while(_isRunning){
		unsigned int timeout = 1000;
		auto result = LeapPollConnection(connectionHandle, timeout, &msg);
		//Handle message
	}
}
```

@2019 `v4` [LeapMotion SDK スタートアップ (C API / v4) - Qiita](https://qiita.com/moccos/items/0aa986714df58fb837d0)

## eLeapEventType
