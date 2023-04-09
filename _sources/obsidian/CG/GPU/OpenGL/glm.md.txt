[[LinearAlgebra]]

- [GitHub - g-truc/glm: OpenGL Mathematics (GLM)](https://github.com/g-truc/glm)

- [Notes on GLM - Top Page](https://miz-ar.info/glm-notes/)

- @2020 [glm - グラフィックスプログラミングのためのC++数学系ライブラリー - Qiita](https://qiita.com/usagi/items/f34976a3d3011506ff7d)
- [GLMのマニュアルがヘボいので自分で書き始めた | 雑記帳](https://blog.miz-ar.info/2018/06/glm-notes/)

```cpp
#include <glm/glm.hpp>
```


# rotation
## quat
- [GLM: glm::gtc::quaternion Namespace Reference](https://glm.g-truc.net/0.9.0/api/a00135.html)

```cpp
#include <glm/gtc/quaternion.hpp>

glm::quat

{} // {0, 0, 0, 0}
{1, 0, 0, 0} //
glm::quat_identity()
```

```cpp
#include <glm/gtx/quaternion.hpp>

glm::toMat4
```

# translation
## mat4 => translation
## translation => mat4

# scale
## scale => mat4

# decompose

# projection



# glm::mat4
- [GLM_GTX_transform](https://glm.g-truc.net/0.9.4/api/a00206.html)
- [https://gameprogrammingunit.web.fc2.com/glm/matrix_transform.htm](https://gameprogrammingunit.web.fc2.com/glm/matrix_transform.htm)

```cpp
#include <glm/gtx/transform.hpp> 
```

# SIMD
- [Advanced Usage](https://glm.g-truc.net/0.9.1/api/a00002.html)
