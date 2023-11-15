[[webxr]]

[XRWebGLLayer - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/XRWebGLLayer)

[XRWebGLLayer: XRWebGLLayer() constructor - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/XRWebGLLayer/XRWebGLLayer)


```js
let pose = xrFrame.getViewerPose(xrReferenceSpace);

if (pose) {
  const glLayer = xrSession.renderState.baseLayer;
  gl.bindFrameBuffer(gl.FRAMEBUFFER, glLayer.Framebffer);

  for (const view of pose.views) {
    const viewport = glLayer.getViewport(view);
    gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);

    /* Render the view */
  }
}
```
