// @ts-check
AFRAME.registerComponent("boxes", {
    schema: {
        size: { default: 0.08 },
    },

    init() {
        const scene = this.el.sceneEl;
        const size = this.data.size;
        for (let x = -1; x <= 1; x += 0.5) {
            for (let y = 0; y <= 2; y += 0.5) {
                for (let z = -2; z <= 0; z += 0.5) {
                    const box = document.createElement("a-box");
                    box.setAttribute("width", size);
                    box.setAttribute("height", size);
                    box.setAttribute("depth", size);
                    box.setAttribute("position", `${x} ${y} ${z}`);
                    box.setAttribute('hittest', '')
                    scene.appendChild(box);
                }
            }
        }
    },
});
