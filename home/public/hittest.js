// @ts-check
/**
 * @typedef {Object} HitStatus
 * @property {boolean} isEnter
 */

/**
 * @typedef {Object} HitTest
 * @property {THREE.Box3} bb
 * @property {Map<any, HitStatus>} statusMap
 * @property {function} test
 */

AFRAME.registerComponent("hittest", {
    /**
     * @this {AFRAME.AComponent & HitTest}
     */
    init() {
        const obj = this.el.object3D;
        // @ts-ignore
        const geom = /** @type {THREE.BufferGeometry} */ (obj.children[0].geometry);
        geom.computeBoundingBox();
        this.bb = geom.boundingBox.clone();
        this.statusMap = new Map();
    },

    /**
     * @this {AFRAME.AComponent & HitTest}
     * @param {any} source
     * @param {THREE.Vector3} position
     */
    test(source, position) {
        let status = this.statusMap.get(source);
        if (!status) {
            status = { isEnter: false };
            this.statusMap.set(source, status);
        }

        // world
        const p = position.clone();
        // to local
        p.applyMatrix4(this.el.object3D.matrixWorld.invert());

        const isEnter = this.bb.containsPoint(p);
        if (status.isEnter != isEnter) {
            if (isEnter) {
                this.el.emit('enter', { source });
            }
            else {
                this.el.emit('exit', { source });
            }
            status.isEnter = isEnter;
        }
    },
}
);
