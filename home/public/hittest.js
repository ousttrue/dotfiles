const HitTest = {
    init() {
        const obj = this.el.object3D;
        const geom = /** @type {THREE.BufferGeometry} */
            (obj.children[0].geometry);
        geom.computeBoundingBox();
        this.bb = geom.boundingBox.clone();

        this.statusMap = {
        }
    },

    /**
     * @param {any} key
     * @param {THREE.Vector3} position
     */
    test(key, position) {
        // @ts-ignore
        let status = this.statusMap[key];
        if (!status) {
            status = {};
            // @ts-ignore
            this.statusMap[key] = status;
        }

        // world
        const p = /** @type {THREE.Vector3} */ (position.clone());
        // to local
        p.applyMatrix4(this.el.object3D.matrixWorld.invert());

        const isEnter = this.bb.containsPoint(p);
        if (status.isEnter != isEnter) {
            if (isEnter) {
                this.el.emit('enter', key);
            }
            else {
                this.el.emit('exit', key);
            }
            status.isEnter = isEnter;
        }
    },
}

AFRAME.registerComponent("hittest", HitTest);
