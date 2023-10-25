[[AFrame]]

# hand-tracking-controls
[hand-tracking-controls.js](https://github.com/aframevr/aframe/blob/master/src/components/hand-tracking-controls.js)

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
