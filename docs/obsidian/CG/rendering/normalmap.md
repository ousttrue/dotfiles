[[Material|shading]]

- https://learnopengl.com/Advanced-Lighting/Normal-Mapping
- [チュートリアル13:法線マッピング](http://www.opengl-tutorial.org/jp/intermediate-tutorials/tutorial-13-normal-mapping/)

```c
uniform sampler2D normalMap;

void main()
{
	// obtain normal from normal map in range [0,1]
	normal = texture(normalMap, fs_in.TexCoords).rgb;
	// transform normal vector to range [-1,1]
	normal = normalize(normal * 2.0 - 1.0);

	[...]
	// proceed with lighting as normal
}
```

# debug shader

# Lighting in tangent space

# mikk tangent space

- https://github.com/tcoppex/ext-mikktspace
  `blender-2.63a/intern/mikktspace/mikktspace.h`
- https://github.com/teared/mikktspace-for-houdini

* http://www.terathon.com/code/tangent.html

- @2015 [ノーマルマップとローポリメッシュのタンジェントの計算 ~ 背景アーティストのぶろぐ](http://envgameartist.blogspot.com/2015/09/blog-post_24.html)

## xNormal

- http://www.xnormal.net/
- @2018 [xNormal でノーマルマップ(など)をベイクする - 写真から寿司を生成するためのメモ](https://manabuokajima.hatenablog.com/entry/2018/04/24/150442)

* @2012 [xnormalを使ってみた・・・その2 – PERKUP](http://www.perkup.jp/?p=4579)

## glTF

- https://github.com/KhronosGroup/glTF/issues/1252
- https://github.com/KhronosGroup/glTF/tree/master/specification/2.0#meshes
