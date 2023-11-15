[GitHub - immersive-web/dom-overlays: A feature incubation repo for layering DOM content on/in WebXR content. Feature lead: Piotr Bialecki](https://github.com/immersive-web/dom-overlays)


- @2021 [A-Frame で WebXR Dom-Overlay を利用する方法 - 忘れないうちにメモする](https://sgi-don.hatenablog.com/entry/2021/03/04/210757)
- @2021 [そういえば、A-Frame v1.1.0でdom-overlayとhit-testの実装が入りました。 - 忘れないうちにメモする](https://sgi-don.hatenablog.com/entry/2021/01/19/153429)

`?`
[GitHub - binzume/vr-workspace: WebXR workspace](https://github.com/binzume/vr-workspace)

```js
      let sessionInit = {
        requiredFeatures: ['hit-test', 'mesh-detection'],
        optionalFeatures: [],
      };
      if (useDomOverlay.checked) {
        sessionInit.optionalFeatures.push('dom-overlay');
        sessionInit.domOverlay = { root: document.body };
      }
      navigator.xr.requestSession('immersive-ar', sessionInit).then((session) => {
        session.mode = 'immersive-ar';
        xrButton.setSession(session);
        onSessionStarted(session);
      });
 
```

# floating ?
