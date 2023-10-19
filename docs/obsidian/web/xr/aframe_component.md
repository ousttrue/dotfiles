[[AFrame]] [[AFrameScene]]

- [Component – A-Frame](https://aframe.io/docs/1.4.0/core/component.html)
- [Writing a Component – A-Frame](https://aframe.io/docs/1.4.0/introduction/writing-a-component.html)

[自作A-Frameコンポーネントをnpmモジュールとして公開するための神ってるツール A-Frame component boilerplate - VOYAGE GROUP VR室ブログ](https://vr-lab.voyagegroup.com/entry/2016/12/15/120544)

# script
```
Then head to our HTML. Under the <head>, after the A-Frame JS <script> tag, and before <a-scene>, we will include our JS file with a <script> tag.
```

# AFRAME.registerComponent
```js
AFRAME.registerComponent('foo', {
  schema: {
    bar: {type: 'number'},
    baz: {type: 'string'}
  },

  init: function () {
    // Do something when component first attached.
  },

  update: function () {
    // Do something when component's data is updated.
  },

  remove: function () {
    // Do something when the component or its entity is detached.
  },

  tick: function (time, timeDelta) {
    // Do something on every scene tick or frame.
  }
});
```

# AFRAME.registerSystem
