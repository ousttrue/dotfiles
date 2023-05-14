Imabe Based Light

# Distant light probes
無限遠 cubemap による間接照明

used to capture lighting information at “infinity”, where parallax can be ignored. Distant probes typically contain the sky, distant landscape features or buildings, etc. They are either captured by the engine or acquired from a camera as high dynamic range images (HDRI).
    
# Local light probes
used to capture a certain area of the world from a specific point of view. The capture is projected on a cube or sphere depending on the surrounding geometry. Local probes are more accurate than distance probes and are particularly useful to add local reflections to materials.
    
# Planar reflections
used to capture reflections by rendering the scene mirrored by a plane. This technique works only for flat surfaces such as building floors, roads and water.
    
# Screen space reflection
used to capture reflections based on the rendered scene (using the previous frame for instance) by ray-marching in the depth buffer. SSR gives great result but can be very expensive.

[https://t-pot.com/program/108_RealTimeGI/index.html t-pot『リアルタイム大域照明』]
https://learnopengl.com/PBR/IBL/Diffuse-irradiance

[* texture]
https://cgbeginner.net/hdri-footage/

[* blender]
https://cycles.wiki.fc2.com/wiki/IBL%20用%20HDRI%20の作り方

[* gltf environment]
https://github.com/KhronosGroup/glTF-IBL-Sampler
https://github.com/ux3d/glTF-Sample-Environments

RGBE
hdrshop
openexr, half

- [物理ベースにのっとったImage Based Lightingを実装してみた | NKTK-WEBLOG](https://blog.nktk-tech.com/2019-03-31-02/)

# SphericalHarmonics
- https://github.com/mebiusbox/docs/blob/master/CGのための球面調和関数.pdf
