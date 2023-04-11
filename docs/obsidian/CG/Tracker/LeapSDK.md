
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

# types
`LeapC.h`
## LEAP_TRACKING_EVENT
```c
struct LEAP_TRACKING_EVENT
{
	LEAP_HAND* pHands;
	uint32_t nHands;
};
```

## LEAP_HAND
```c
struct LEAP_HAND
{
	LEAP_DIGIT thumb;
	LEAP_DIGIT index;
	LEAP_DIGIT middle;
	LEAP_DIGIT ring;
	LEAP_DIGIT pinky;
	LEAP_BONE arm;
	LEAP_PALM palm;
};
```

## LEAP_DIGIT
指
```c
struct LEAP_DIGIT
{
	LEAP_BONE metacarpal;
	LEAP_BONE proximal;
	LEAP_BONE intermediate;
	LEAP_BONE distal;
};
```

## LEAP_BONE
```c
struct LEAP_BONE
{
	LEAP_VECTOR prev_joint;
	LEAP_VECTOR next_joint;
	float width;
	LEAP_QUATERNION rotation;
};

struct LEAP_VECTOR
{
	float x;
	float y;
	float z;
};
```

## LEAP_PALM
```c
struct LEAP_PALM
{
	LEAP_VECTOR position;
	LEAP_VECTOR stabilized_position;
	LEAP_VECTOR velocity;
	LEAP_VECTOR normal;
	float width;
	LEAP_VECTOR direction;
	LEAP_QUATERNION orientation;
};
```

## eLeapEventType
