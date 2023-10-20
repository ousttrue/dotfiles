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
var THUMB_TIP_INDEX = 4;
var INDEX_TIP_INDEX = 9;

var PINCH_START_DISTANCE = 0.015;
var PINCH_END_DISTANCE = 0.03;
var PINCH_POSITION_INTERPOLATION = 0.5;

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
        this.hoverMap = {}

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
            const joint = /** @type AFRAME.Entity */ document.createElement(prim);
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
        });
        this.el.addEventListener('pinchended', () => {
            this.joints[INDEX_TIP_INDEX].setAttribute('color', '#FFFF00')
        });
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

                this.indexTipPosition.setFromMatrixPosition(
                    this.joints[INDEX_TIP_INDEX].object3D.matrix);
                this.thumbTipPosition.setFromMatrixPosition(
                    this.joints[THUMB_TIP_INDEX].object3D.matrix);


                if (this.hitItems === undefined) {
                    this.hitItems = [];
                    for (const el of document.querySelectorAll('[hittest]')) {
                        const hittest = el.components.hittest;
                        hittest.el.addEventListener('enter', (key) => {
                            // if (key == this) 
                            {
                                el.setAttribute('color', 'red')
                                this.hoverMap[el] = el
                            }
                        });
                        hittest.el.addEventListener('exit', (key) => {
                            // if (key == this) 
                            {
                                el.setAttribute('color', 'white')
                                delete this.hoverMap[el]
                            }
                        });
                        this.hitItems.push(hittest);
                    }
                    console.log(`query: ${this.hitItems.length}`)
                }

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

                // hitTest
                for (const hittest of this.hitItems) {
                    hittest.test(this, this.indexTipPosition);
                }

                if (this.isPinched) {
                    for (const key in this.hoverMap) {
                        // const obj = /** @type THREE.Object3D */ (this.hoverMap[key].object3D);
                        // obj.position = this.indexTipPosition;
                        this.hoverMap[key].setAttribute('position', this.indexTipPosition);
                    }
                }
            }
        }
    },
});
