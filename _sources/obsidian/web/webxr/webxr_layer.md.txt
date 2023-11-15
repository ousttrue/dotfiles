[[XRWebGLBinding]]

# layer type
## GLLayer
new XRWebGLLayer

## projection


## quad

```js
  const xrGlBinding = new XRWebGLBinding(xrSession, gl);
  const quadLayer = xrGlBinding.createQuadLayer({
    pixelWidth: 1024,
    pixelHeight: 1024,
  });
```

# XRSession.updateRenderState(layers:)
[XRSession: updateRenderState() method - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/XRSession/updateRenderState)

```js
session.updateRenderState({ layers: [cyldLayer, projLayer] });

function onXRSessionStarted(xrSession) {
  const glCanvas = document.createElement("canvas");
  const gl = glCanvas.getContext("webgl", { xrCompatible: true });
  const xrGlBinding = new XRWebGLBinding(xrSession, gl);
  const projectionLayer = new XRWebGLLayer(xrSession, gl);
  const quadLayer = xrGlBinding.createQuadLayer({
    pixelWidth: 1024,
    pixelHeight: 1024,
  });

  xrSession.updateRenderState({
    baseLayer: projectionLayer,
    // 排他
    layers: [projectionLayer, quadLayer],
  });

  xrSession.renderState.layers; // [projectionLayer, quadLayer]
}
```

