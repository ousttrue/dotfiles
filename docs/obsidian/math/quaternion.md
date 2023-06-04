[[MeshSync]]
- https://www.f-sp.com/entry/2017/06/30/221124#補間における注意

# 乗算順
## unity

`root * parent * self` 


# pack
- [Quaternionを16byteから3byteへ圧縮。: べんじゃみんの裏庭。](http://cottonia-cotton.cocolog-nifty.com/backyard/2017/11/quaternion16byt.html)
- [Quaternion quantization: part 1](http://marc-b-reynolds.github.io/quaternions/2017/05/02/QuatQuantPart1.html)
- [GitHub - jpreiss/quatcompress: Compress a unit quaternion into 32 bits](https://github.com/jpreiss/quatcompress)
- [C# - Use "smallest three" compression for transmitting Quaternion rotations in Unity's UNET networking, from 16 bytes to 7 bytes. · GitHub](https://gist.github.com/StagPoint/bb7edf61c2e97ce54e3e4561627f6582)

## mesysync
- [GitHub - i-saint/Glimmer](https://github.com/i-saint/Glimmer)
- https://github.com/unity3d-jp/MeshSync/blob/dev/Plugin/MeshUtils/muQuat32.h

### csharp
- [GitHub - mao-test-h/Quaternion32: Quaternionの32bit圧縮](https://github.com/mao-test-h/Quaternion32)

`CompressedQuaternion`
- [infinity/CompressedQuaternion.h at 5d9f23559d2481708a90b7e28ae0a065ed45c0fe · grserver/infinity · GitHub](https://github.com/grserver/infinity/blob/5d9f23559d2481708a90b7e28ae0a065ed45c0fe/src/engine/shared/library/sharedMath/src/shared/CompressedQuaternion.h)

`https://github.com/mao-test-h/Quaternion32.git?path=Assets/Quaternion32`

# glsl
- [GLSLでクォータニオン(四元数) - Qiita](https://qiita.com/aa_debdeb/items/c34a3088b2d8d3731813)
