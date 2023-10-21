// @ts-check
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
const THUMB_TIP_INDEX = 4;
const INDEX_TIP_INDEX = 9;

const PINCH_START_DISTANCE = 0.015;
const PINCH_END_DISTANCE = 0.03;
const PINCH_POSITION_INTERPOLATION = 0.5;

/**
 * @typedef {Object} PinchDetail
 * @property {string} hand
 * @property {THREE.Matrix4} matrix
 */

/**
 * @typedef {Object} CustomHandControls
 * @property {XRReferenceSpace} referenceSpace
 * @property {boolean} controllerPresent
 * @property {boolean} hasPoses
 * @property {Float32Array} jointPoses
 * @property {Float32Array} jointRadii
 * @property {Set<AFRAME.AEntity>} hoverSet
 * @property {Set<AFRAME.AEntity>} pinchSet
 * @property {THREE.Vector3} indexTipPosition
 * @property {THREE.Vector3} thumbTipPosition
 * @property {PinchDetail} pinchEventDetail
 * @property {boolean} isPinched
 * @property {AFRAME.AEntity[]} joints 
 * @property {(AFRAME.AComponent & HitTest)[]} hitItems
 *
 * @property {function} logger
 * @property {function} _updateReferenceSpace
 * @property {function} _checkIfControllerPresent
 * @property {function} _updateHandTracking
 * @property {function} _updateInteraction
 */

AFRAME.registerComponent('custom-hand-controls', {
    schema: {
        hand: { default: 'right', oneOf: ['left', 'right'] },
    },

    /**
     * @param {string} msg
     */
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
        // @ts-ignore
        AFRAME.utils.trackedControls.checkControllerPresentAndSetup(
            this, '',
            { hand: this.data.hand, iterateControllerProfiles: true, handTracking: true });
    },

    /**
     * @this {AFRAME.AComponent & CustomHandControls}
     */
    async _updateReferenceSpace() {
        // @ts-ignore
        const xrSession = /** @type {XRSession} */ (this.el.sceneEl.xrSession);
        this.referenceSpace = undefined;
        if (!xrSession) {
            return;
        }
        // @ts-ignore
        const referenceSpaceType = this.el.sceneEl.systems.webxr.sessionReferenceSpaceType;
        try {
            this.logger(`_updateReferenceSpace: ${referenceSpaceType}`);
            this.referenceSpace = await xrSession.requestReferenceSpace(referenceSpaceType)
        } catch (error) {
            // @ts-ignore
            this.el.sceneEl.systems.webxr.warnIfFeatureNotRequested(referenceSpaceType, 'tracked-controls-webxr uses reference space ' + referenceSpaceType);
            throw error;
        }
    },

    /**
     * AFRAME.Component lifecycle
     * @this {AFRAME.AComponent & CustomHandControls}
     */
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

        this.hoverSet = new Set();
        this.pinchSet = new Set();

        this.indexTipPosition = new THREE.Vector3();
        this.thumbTipPosition = new THREE.Vector3();
        this.pinchEventDetail = {
            hand: this.data.hand,
            matrix: new THREE.Matrix4(),
        };
        this.isPinched = false;

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
            const joint = document.createElement(prim);
            joint.setAttribute('id', this.data.hand + ':' + name);
            joint.setAttribute('color', color);

            if (prim == 'a-box') {
                joint.setAttribute('width', '0.01');
                joint.setAttribute('height', '0.01');
                joint.setAttribute('depth', '0.01');
            }
            else {
                joint.setAttribute('radius', '0.005');
            }
            joint.object3D.matrixAutoUpdate = false;
            this.el.sceneEl.appendChild(joint);
            this.joints.push(joint);
        }
        this.logger('init: end');

        this.el.addEventListener('pinchstarted', () => {
            this.joints[INDEX_TIP_INDEX].setAttribute('color', '#FF00FF')
            this.pinchSet.clear();
            this.hoverSet.forEach(el => {
                this.pinchSet.add(el);
            });
        });
        this.el.addEventListener('pinchended', () => {
            this.joints[INDEX_TIP_INDEX].setAttribute('color', '#FFFF00')
            this.pinchSet.clear();
        });
    },

    /**
     * AFRAME.Component lifecycle
     * @this {AFRAME.AComponent & CustomHandControls}
     */
    play() {
        this.logger('play');
        this._checkIfControllerPresent();
        this.el.sceneEl.addEventListener('controllersupdated',
            _ => this._checkIfControllerPresent(), false);
    },

    /**
     * AFRAME.Component lifecycle
     * @this {AFRAME.AComponent & CustomHandControls}
     */
    pause() {
        this.logger('pause');
        this.el.sceneEl.removeEventListener('controllersupdated',
            _ => this._checkIfControllerPresent(), false);
    },

    /**
     * @this {AFRAME.AComponent & CustomHandControls}
     * @return boolean
     */
    _updateHandTracking() {
        this.hasPoses = false;

        // @ts-ignore
        const input = /** @type XRInputSource */ (this.el.components['tracked-controls'] && this.el.components['tracked-controls'].controller);
        if (!input) {
            return false;
        }

        // @ts-ignore
        const frame = /** @type {XRFrame} */ (this.el.sceneEl.frame);
        // https://www.w3.org/TR/webxr-hand-input-1/
        // @ts-ignore
        this.hasPoses = frame.fillPoses(input.hand.values(), this.referenceSpace, this.jointPoses);
        return this.hasPoses;
    },

    /**
     * @this {AFRAME.AComponent & CustomHandControls}
     */
    _updateInteraction() {
        // apply hand tracking to hand joint boxes
        let offset = 0;
        for (let i = 0; i < this.joints.length; ++i, offset += 16) {
            const o3d = /** @type THREE.Object3D */(this.joints[i].object3D);
            o3d.matrix.fromArray(this.jointPoses, offset);
        }

        if (this.hitItems === undefined) {
            // find elements that has hittest
            this.hitItems = [];
            for (const _el of document.querySelectorAll('[hittest]')) {
                const el = /** @type AFRAME.AEntity */ (_el);
                const hittest = /** @type {AFRAME.AComponent & HitTest} */ (el.components.hittest);
                hittest.el.addEventListener('enter', evt => {
                    if (evt.detail.source == this) {
                        el.setAttribute('color', 'red')
                        this.hoverSet.add(el);
                    }
                });
                hittest.el.addEventListener('exit', evt => {
                    if (evt.detail.source == this) {
                        el.setAttribute('color', 'white')
                        this.hoverSet.delete(el)
                    }
                });
                this.hitItems.push(hittest);
            }
            console.log(`query: ${this.hitItems.length}`)
        }

        // hitTest
        for (const hittest of this.hitItems) {
            if (this.pinchSet.has(hittest.el)) {
                continue;
            }
            hittest.test(this, this.indexTipPosition);
        }

        // update pinch status
        this.indexTipPosition.setFromMatrixPosition(
            this.joints[INDEX_TIP_INDEX].object3D.matrix);
        this.thumbTipPosition.setFromMatrixPosition(
            this.joints[THUMB_TIP_INDEX].object3D.matrix);
        var distance = this.indexTipPosition.distanceTo(this.thumbTipPosition);
        const isPinched = distance < PINCH_START_DISTANCE;
        if (this.isPinched != isPinched) {
            if (isPinched) {
                this.el.emit('pinchstarted', this.pinchEventDetail);
            }
            else {
                this.el.emit('pinchended', this.pinchEventDetail);
            }
            this.isPinched = isPinched;
        }

        // move pinch elements
        this.pinchSet.forEach(el => {
            el.setAttribute('position', this.indexTipPosition);
        });
    },

    /**
     * AFRAME.Component lifecycle
     * @this {AFRAME.AComponent & CustomHandControls}
     */
    tick() {
        if (this._updateHandTracking()) {
            this._updateInteraction();
        }
    }
});
