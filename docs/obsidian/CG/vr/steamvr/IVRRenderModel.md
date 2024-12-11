[[openvr]]

https://github.com/ValveSoftware/openvr/wiki/IVRRenderModels_Overview

# ロードする

LoadRenderModel_Async

```cpp
 /** a single vertex in a render model */
 struct RenderModel_Vertex_t
 {
 	HmdVector3_t vPosition;		// position in meters in device space
 	HmdVector3_t vNormal;
 	float rfTextureCoord[ 2 ];
 };
```

# 更新する

部品の姿勢を得る？

```cpp
 	/** Use this to query information about the component, as a function of the controller state.
 	*
 	* For dynamic controller components (ex: trigger) values will reflect component motions
 	* For static components this will return a consistent value independent of the VRControllerState_t
 	*
 	* If the pchRenderModelName or pchComponentName is invalid, this will return false (and transforms will be set to identity).
 	* Otherwise, return true
 	* Note: For dynamic objects, visibility may be dynamic. (I.e., true/false will be returned based on controller state and controller mode state ) */
 	virtual bool GetComponentStateForDevicePath( const char *pchRenderModelName, const char *pchComponentName, vr::VRInputValueHandle_t devicePath, const vr::RenderModel_ControllerMode_State_t *pState, vr::RenderModel_ComponentState_t *pComponentState ) = 0;
```

# unity

[[Unity]]
`SteamVR_RenderModel::LoadComponents`
`SteamVR_RenderModel::UpdateComponents`

# driver 側から供給するには

https://github.com/ValveSoftware/driver_hydra
[https://www.youtube.com/watch?v=0KEeympkT2Y]

# Prop_RenderModelName_String`

```cpp
 uint32_t CHydraHmdLatest::GetStringTrackedDeviceProperty( vr::ETrackedDeviceProperty prop, char * pchValue, uint32_t unBufferSize, vr::ETrackedPropertyError * pError )
 {
 	std::ostringstream ssRetVal;

 	switch ( prop )
 	{
 	case vr::Prop_RenderModelName_String:
 		// The {hydra} syntax lets us refer to rendermodels that are installed
 		// in the driver's own resources/rendermodels directory.  The driver can
 		// still refer to SteamVR models like "generic_hmd".
 		ssRetVal << "{hydra}hydra_controller";
 		break;
```

`DriverPose_t`

// driver
`vr::VRServerDriverHost()->TrackedDevicePoseUpdated( m_unObjectId, GetPose(), sizeof( DriverPose_t ) );`

// component
`RenderModel_ComponentState_t`
