// @ts-nocheck
const JOINTS = [
    { name: 'wrist', prim: 'a-box', color: '#ffffff' },
    { name: 'thumb-metacarpal', prim: 'a-box', color: '#ffffff' },
    { name: 'thumb-phalanx-proximal', prim: 'a-box', color: '#ffffff' },
    { name: 'thumb-phalanx-distal', prim: 'a-box', color: '#ffffff' },
    { name: 'thumb-tip', prim: 'a-sphere', color: '#ff0000' },
    { name: 'index-finger-metacarpal', prim: 'a-box', color: '#ffffff' },
    { name: 'index-finger-phalanx-proximal', prim: 'a-box', color: '#ffffff' },
    { name: 'index-finger-phalanx-intermediate', prim: 'a-box', color: '#ffffff' },
    { name: 'index-finger-phalanx-distal', prim: 'a-box', color: '#ffffff' },
    { name: 'index-finger-tip', prim: 'a-sphere', color: '#ffff00' },
    { name: 'middle-finger-metacarpal', prim: 'a-box', color: '#ffffff' },
    { name: 'middle-finger-phalanx-proximal', prim: 'a-box', color: '#ffffff' },
    { name: 'middle-finger-phalanx-intermediate', prim: 'a-box', color: '#ffffff' },
    { name: 'middle-finger-phalanx-distal', prim: 'a-box', color: '#ffffff' },
    { name: 'middle-finger-tip', prim: 'a-sphere', color: '#00ff00' },
    { name: 'ring-finger-metacarpal', prim: 'a-box', color: '#ffffff' },
    { name: 'ring-finger-phalanx-proximal', prim: 'a-box', color: '#ffffff' },
    { name: 'ring-finger-phalanx-intermediate', prim: 'a-box', color: '#ffffff' },
    { name: 'ring-finger-phalanx-distal', prim: 'a-box', color: '#ffffff' },
    { name: 'ring-finger-tip', prim: 'a-sphere', color: '#00ffff' },
    { name: 'pinky-finger-metacarpal', prim: 'a-box', color: '#ffffff' },
    { name: 'pinky-finger-phalanx-proximal', prim: 'a-box', color: '#ffffff' },
    { name: 'pinky-finger-phalanx-intermediate', prim: 'a-box', color: '#ffffff' },
    { name: 'pinky-finger-phalanx-distal', prim: 'a-box', color: '#ffffff' },
    { name: 'pinky-fingea-sphere', prim: 'a-sphere', color: '#0000ff' },
];

AFRAME.registerComponent('custom-hand-controls', {
    schema: {
        hand: { default: 'right', oneOf: ['left', 'right'] },
    },

    logger(msg) {
        console.log(`[${this.data.hand}] ${msg}`)
    },

    // call from AFRAME.utils.trackedControls.checkControllerPresentAndSetup
    injectTrackedControls() {
        this.logger('injectTrackedControls');
        var el = this.el;
        var data = this.data;
        el.setAttribute('tracked-controls', {
            hand: data.hand,
            iterateControllerProfiles: true,
            handTrackingEnabled: true
        });
    },

    // call from AFRAME.utils.trackedControls.checkControllerPresentAndSetup
    addEventListeners() {
        this.logger('addEventListeners');
    },

    // call from AFRAME.utils.trackedControls.checkControllerPresentAndSetup
    removeEventListeners() {
        this.logger('removeEventListener');
    },

    _checkIfControllerPresent() {
        AFRAME.utils.trackedControls.checkControllerPresentAndSetup(
            this, '',
            { hand: this.data.hand, iterateControllerProfiles: true, handTracking: true });
    },

    async _updateReferenceSpace() {
        /** @type XRSession */
        const xrSession = this.el.sceneEl.xrSession;
        this.referenceSpace = undefined;
        if (!xrSession) { return; }
        const referenceSpaceType = this.el.sceneEl.systems.webxr.sessionReferenceSpaceType;
        try {
            this.logger(`_updateReferenceSpace: ${referenceSpaceType}`);
            this.referenceSpace = await xrSession.requestReferenceSpace(referenceSpaceType)
        } catch (error) {
            this.el.sceneEl.systems.webxr.warnIfFeatureNotRequested(referenceSpaceType, 'tracked-controls-webxr uses reference space ' + referenceSpaceType);
            throw error;
        }
    },

    // AFRAME.Component lifecycle
    init() {
        this.logger('init: begin');
        const sceneEl = this.el.sceneEl;
        const webXROptionalAttributes = sceneEl.getAttribute('webxr').optionalFeatures;
        webXROptionalAttributes.push('hand-tracking');
        sceneEl.setAttribute('webxr', { optionalFeatures: webXROptionalAttributes });

        this.controllerPresent = false;
        this.hasPoses = false;
        this.jointPoses = new Float32Array(16 * JOINTS.length);
        this.jointRadii = new Float32Array(JOINTS.length);

        this.el.sceneEl.addEventListener('enter-vr',
            async () => {
                this.logger('enter-vr');
                await this._updateReferenceSpace();
            });
        this.el.sceneEl.addEventListener('exit-vr',
            async () => {
                this.logger('exit-vr');
                await this._updateReferenceSpace();
            });

        this.el.addEventListener('controllerconnected',
            () => this.logger('controllerconnected'));

        this.joints = [];
        for (const { name, prim, color } of JOINTS) {
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
            this.joints.push(joint);
        }
        this.logger('init: end');
    },

    // AFRAME.Component lifecycle
    play() {
        this.logger('play');
        this._checkIfControllerPresent();
        this.el.sceneEl.addEventListener('controllersupdated',
            _ => this._checkIfControllerPresent(), false);
    },

    // AFRAME.Component lifecycle
    pause() {
        this.logger('pause');
        this.el.sceneEl.removeEventListener('controllersupdated',
            _ => this._checkIfControllerPresent(), false);
    },

    // AFRAME.Component lifecycle
    tick() {
        const sceneEl = this.el.sceneEl;
        this.hasPoses = false;
        this.el.object3D.position.set(0, 0, 0);
        this.el.object3D.rotation.set(0, 0, 0);

        var frame = /** @type XRFrame */ (sceneEl.frame);
        var controller = /** @type XRInputSource */ (this.el.components['tracked-controls'] && this.el.components['tracked-controls'].controller);

        if (controller) {
            this.hasPoses = frame.fillPoses(controller.hand.values(), this.referenceSpace, this.jointPoses);
            if (this.hasPoses) {
                let offset = 0;
                for (let i = 0; i < this.joints.length; ++i, offset += 16) {
                    const o3d = /** @type THREE.Object3D */(this.joints[i].object3D);
                    o3d.matrix.fromArray(this.jointPoses, offset);
                }
            }
        }
    },
});
