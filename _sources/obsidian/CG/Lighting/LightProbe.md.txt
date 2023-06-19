[[HDR]]

# Distant light probes
無限遠 cubemap による間接照明

used to capture lighting information at “infinity”, where parallax can be ignored. Distant probes typically contain the sky, distant landscape features or buildings, etc. They are either captured by the engine or acquired from a camera as high dynamic range images (HDRI).
    
# Local light probes
used to capture a certain area of the world from a specific point of view. The capture is projected on a cube or sphere depending on the surrounding geometry. Local probes are more accurate than distance probes and are particularly useful to add local reflections to materials.

# LightMap
[[LightMap]]

# Spherical Gaussian Lightmaps
https://github.com/TheRealMJP/BakingLab

- [Introduction to Spherical Gaussians | Puye's Blog](https://puye.blog/posts/SG-Intro-EN/)
- [Site Unreachable](https://mynameismjp.wordpress.com/2016/10/09/new-blog-series-lightmap-baking-and-spherical-gaussians/)
- [SG Series Part 1: A Brief (and Incomplete) History of Baked Lighting Representations](https://therealmjp.github.io/posts/sg-series-part-1-a-brief-and-incomplete-history-of-baked-lighting-representations/)
- [The Order 1886: Spherical Gaussian Lightmaps - Graphics and GPU Programming - GameDev.net](https://gamedev.net/forums/topic/671115-the-order-1886-spherical-gaussian-lightmaps/5251421/)
