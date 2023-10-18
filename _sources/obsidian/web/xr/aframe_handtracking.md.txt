[[AFrame]]

# hand-tracking-controls
- @2020 [A-Frameのハンドトラッキングを試してみた - じゅころぐAR](https://www.jyuko49.com/entry/2020/12/14/214715)
- pinchstarted
- pinchended
- pinchmoved
```html

<script src="https://aframe.io/releases/1.3.0/aframe.min.js"></script>
<script>
document.addEventListener("DOMContentLoaded", 
	function(){
		addPitchMovedEvent(document.getElementById('leftHand'));
		addPitchMovedEvent(document.getElementById('rightHand'));
	}, false
);
function addPitchMovedEvent(hand)
{
	hand.addEventListener('pinchmoved', function (event) {
		document.getElementById('sphere').setAttribute('position', event.detail.position);
		document.getElementById('sphere').setAttribute('color', '#FFFF00');
	});
	
	hand.addEventListener('pinchended', function (event) {
		document.getElementById('sphere').setAttribute('color', '#0062C6');
	});
}
</script>
<a-scene device-orientation-permission-ui="enabled: false">
  <a-entity id="leftHand" hand-tracking-controls="hand: left; modelStyle: dots;"></a-entity>
  <a-entity id="rightHand" hand-tracking-controls="hand: right; modelStyle: dots;"></a-entity>
  <a-sphere id="sphere" position="0 0 0" radius="0.015" color="#0062C6"></a-sphere>
</a-scene>
```

## pinch
- `pinchmoved` @2020 [A-Frameのハンドトラッキングを試してみた - じゅころぐAR](https://www.jyuko49.com/entry/2020/12/14/214715)
- [javascript - How to move an object in the aframe scene by pinching? - Stack Overflow](https://stackoverflow.com/questions/77000162/how-to-move-an-object-in-the-aframe-scene-by-pinching)

# repos
- [GitHub - gftruj/aframe-hand-tracking-controls-extras: a-frame hand tracking extras](https://github.com/gftruj/aframe-hand-tracking-controls-extras)
- [GitHub - marlon360/webxr-handtracking: 👐 WebXR hand tracking examples](https://github.com/marlon360/webxr-handtracking)
- [GitHub - c-frame/aframe-super-hands-component: 👐All-in-one natural hand controller, pointer, and gaze interaction library for A-Frame](https://github.com/c-frame/aframe-super-hands-component)
- [GitHub - t100ta/tfjs-aframe-handtracking](https://github.com/t100ta/tfjs-aframe-handtracking)

## handy-work
[A-Frame Hand Tracking - Grabbable Objects and Toggleable Physics - YouTube](https://www.youtube.com/watch?v=PQ2bQRERePo&ab_channel=DaniloPasquariello)

- [GitHub - AdaRoseCannon/handy-work: Framework Agnostic Hand tracking for WebXR](https://github.com/AdaRoseCannon/handy-work)

# magic leap
- [Magic Leap2 の WebXR Hand Tracking （WebXR ハンドトラッキング）をA-Frameで実装してみた。 ｜Sadao Tokuyama](https://note.com/st_one/n/n736ca900cb12)

# leap
- [GitHub - openleap/aframe-leap-hands: A-Frame VR component for Leap Motion.](https://github.com/openleap/aframe-leap-hands)
