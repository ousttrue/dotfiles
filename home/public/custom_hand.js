const JOINTS = [
    'wrist',
    'thumb-metacarpal',
    'thumb-phalanx-proximal',
    'thumb-phalanx-distal',
    'thumb-tip',
    'index-finger-metacarpal',
    'index-finger-phalanx-proximal',
    'index-finger-phalanx-intermediate',
    'index-finger-phalanx-distal',
    'index-finger-tip',
    'middle-finger-metacarpal',
    'middle-finger-phalanx-proximal',
    'middle-finger-phalanx-intermediate',
    'middle-finger-phalanx-distal',
    'middle-finger-tip',
    'ring-finger-metacarpal',
    'ring-finger-phalanx-proximal',
    'ring-finger-phalanx-intermediate',
    'ring-finger-phalanx-distal',
    'ring-finger-tip',
    'pinky-finger-metacarpal',
    'pinky-finger-phalanx-proximal',
    'pinky-finger-phalanx-intermediate',
    'pinky-finger-phalanx-distal',
    'pinky-finger-tip'
];

/**
 * @param {string} name
 * @return {{prim: string; color: string}}
 */
function jointShape(name) {
    switch (name) {
        case "thumb-tip":
            return {
                prim: 'a-sphere',
                color: '#FF0000',
            }
        case "index-finger-tip":
            return {
                prim: 'a-sphere',
                color: '#FFFF00',
            }
        case "middle-finger-tip":
            return {
                prim: 'a-sphere',
                color: '#00FF00',
            }
        case "ring-finger-tip":
            return {
                prim: 'a-sphere',
                color: '#00FFFF',
            }
        case "pinky-finger-tip":
            return {
                prim: 'a-sphere',
                color: '#0000FF',
            }

        default:
            return {
                prim: 'a-box',
                color: '#FFFFFF',
            }
    }
}

AFRAME.registerComponent('custom-hand-controls', {
    schema: {
        hand: { default: 'right', oneOf: ['left', 'right'] },
    },

    init() {
        console.log(`${this.data.hand}: init: begin`);
        const sceneEl = this.el.sceneEl;
        const webXROptionalAttributes = sceneEl.getAttribute('webxr').optionalFeatures;
        webXROptionalAttributes.push('hand-tracking');
        sceneEl.setAttribute('webxr', { optionalFeatures: webXROptionalAttributes });

        // @ts-ignore
        this.controllerPresent = false;
        // @ts-ignore
        this.hasPoses = false;
        // @ts-ignore
        this.jointPoses = new Float32Array(16 * JOINTS.length);
        // @ts-ignore
        this.jointRadii = new Float32Array(JOINTS.length);

        this.el.sceneEl.addEventListener('enter-vr', async () => {
            console.log(`${this.data.hand}: enter-vr`);
            await this.updateReferenceSpace();
        });
        this.el.sceneEl.addEventListener('exit-vr', async () => {
            console.log(`${this.data.hand}: exit-vr`);
            await this.updateReferenceSpace();
        });

        this.el.addEventListener('controllerconnected', () => console.log('controllerconnected'));

        // @ts-ignore
        this.joints = [];
        for (const name of JOINTS) {
            const { prim, color } = jointShape(name);

            const joint = /** @type AFRAME.Entity */ document.createElement(prim);
            joint.setAttribute('id', this.data.hand + ':' + name);
            joint.setAttribute('color', color);

            if (prim == 'a-box') {
                joint.setAttribute('width', '0.01');
                joint.setAttribute('height', '0.01');
                joint.setAttribute('depth', '0.01');
            }
            else {
                joint.setAttribute('radius', '0.01');
            }
            joint.object3D.matrixAutoUpdate = false;
            this.el.sceneEl.appendChild(joint);
            // @ts-ignore
            this.joints.push(joint);
        }
        console.log(`${this.data.hand}: init: end`);
    },

    checkIfControllerPresent() {
        var data = this.data;
        var hand = data.hand ? data.hand : undefined;
        AFRAME.utils.trackedControls.checkControllerPresentAndSetup(
            this, '',
            { hand: hand, iterateControllerProfiles: true, handTracking: true });
    },

    onControllersUpdate() {
        var controller;
        this.checkIfControllerPresent();
        controller = this.el.components['tracked-controls'] && this.el.components['tracked-controls'].controller;
        // if (!this.el.getObject3D('mesh')) { return; }
        // if (!controller || !controller.hand || !controller.hand[0]) {
        //     this.el.getObject3D('mesh').visible = false;
        // }
    },

    injectTrackedControls() {
        console.log('injectTrackedControls');
        var el = this.el;
        var data = this.data;
        el.setAttribute('tracked-controls', {
            hand: data.hand,
            iterateControllerProfiles: true,
            handTrackingEnabled: true
        });
    },

    addEventListeners() {
        console.log('addEventListeners');
        // this.el.addEventListener('model-loaded', this.onModelLoaded);
        // for (var i = 0; i < this.jointEls.length; ++i) {
        //     this.jointEls[i].object3D.visible = true;
        // }
    },

    removeEventListeners() {
        console.log('removeEventListener');
        // this.el.removeEventListener('model-loaded', this.onModelLoaded);
        // for (var i = 0; i < this.jointEls.length; ++i) {
        //     this.jointEls[i].object3D.visible = false;
        // }
    },

    play() {
        console.log('play');

        // console.log(AFRAME);
        this.checkIfControllerPresent();

        this.el.sceneEl.addEventListener('controllersupdated',
            e => this.onControllersUpdate(e), false);
    },

    pause() {
        console.log('pause');
        // this.removeEventListeners();
        this.el.sceneEl.removeEventListener('controllersupdated',
            e => this.onControllersUpdate(e), false);
    },

    async updateReferenceSpace() {
        /** @type XRSession */
        const xrSession = this.el.sceneEl.xrSession;
        this.referenceSpace = undefined;
        if (!xrSession) { return; }
        const referenceSpaceType = this.el.sceneEl.systems.webxr.sessionReferenceSpaceType;
        try {
            console.log(`updateReferenceSpace: ${referenceSpaceType}`);
            this.referenceSpace = await xrSession.requestReferenceSpace(referenceSpaceType)
        } catch (error) {
            this.el.sceneEl.systems.webxr.warnIfFeatureNotRequested(referenceSpaceType, 'tracked-controls-webxr uses reference space ' + referenceSpaceType);
            throw error;
        }
    },

    tick() {
        const sceneEl = this.el.sceneEl;
        /** @type XRFrame */
        this.hasPoses = false;
        this.el.object3D.position.set(0, 0, 0);
        this.el.object3D.rotation.set(0, 0, 0);

        var frame = sceneEl.frame;
        var controller = this.el.components['tracked-controls'] && this.el.components['tracked-controls'].controller;
        // console.log(controller);

        if (controller) {
            this.hasPoses = frame.fillPoses(controller.hand.values(), this.referenceSpace, this.jointPoses);

            if (this.hasPoses) {
                let offset = 0;
                for (let i = 0; i < this.joints.length; ++i, offset += 16) {
                    /** @type THREE.Object3D */
                    const o3d = this.joints[i].object3D;
                    // const m = this.jointPoses.slice(pos, pos + 16);
                    // console.log(m);
                    // o3d.matrix.set(...m);
                    // o3d.matrixWorldNeedsUpdate = true;
                    o3d.matrix.fromArray(this.jointPoses, offset);
                }
            }
        }
    },
});
