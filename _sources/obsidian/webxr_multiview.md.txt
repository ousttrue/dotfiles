```js
      mv_ext = gl.getExtension('OCULUS_multiview');
      if (mv_ext) {
        console.log("OCULUS_multiview extension is supported");
        is_multisampled_supported = true;
      }
      else {
        console.log("OCULUS_multiview extension is NOT supported");
      }
      if (!mv_ext) {
        mv_ext = gl.getExtension('OVR_multiview2');
        if (mv_ext) {
          console.log("OVR_multiview2 extension is supported");
        }
        else {
          console.log("Neither OCULUS_multiview nor OVR_multiview2 extension is NOT supported");
        }
      }
```