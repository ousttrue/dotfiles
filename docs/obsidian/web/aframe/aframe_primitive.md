[[aframe_component]]

[HTML & Primitives – A-Frame](https://aframe.io/docs/1.4.0/introduction/html-and-primitives.html)

> primitive は a-entity のラッパー。prefab みたいなもの

- [A-FRAME: プリミティブ一覧 #HTML - Qiita](https://qiita.com/matsukatsu/items/b1540dbf36da3d58dc80)

# AFRAME.registerPrimitive
```js
var extendDeep = AFRAME.utils.extendDeep;

// The mesh mixin provides common material properties for creating mesh-based primitives.
// This makes the material component a default component and maps all the base material properties.
var meshMixin = AFRAME.primitives.getMeshMixin();

AFRAME.registerPrimitive('a-box', extendDeep({}, meshMixin, {
  // Preset default components. These components and component properties will be attached to the entity out-of-the-box.
  defaultComponents: {
    geometry: {primitive: 'box'}
  },

  // Defined mappings from HTML attributes to component properties (using dots as delimiters).
  // If we set `depth="5"` in HTML, then the primitive will automatically set `geometry="depth: 5"`.
  mappings: {
    depth: 'geometry.depth',
    height: 'geometry.height',
    width: 'geometry.width'
  }
}));
```

- [aframe - How do I register a component made of a few elements in A-Frame? - Stack Overflow](https://stackoverflow.com/questions/45983491/how-do-i-register-a-component-made-of-a-few-elements-in-a-frame)

## samples
- [CodePen Embed - a-frame clock as primitive](https://codepen.io/leemark/embed/bWVwMv?height=300&theme-id=1232&slug-hash=bWVwMv&default-tab=html%2Cresult&user=leemark&embed-version=2&pen-title=a-frame%20clock%20as%20primitive&name=cp_embed_6)
