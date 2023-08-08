//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.whistletree.view.ui {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import gaia.moga.whistletree.model.*;

    public class WhistleTree extends AssetWrapper {

        private var _clicked:Signal;
        private var _over:Signal;
        private var _out:Signal;
        private var _content:MovieClip;
        private var _frames:Object;
        private var _dFrame:int;
        private var _targetFrame:int;
        private var _state:WhistleTreeState;
        private var _animating:Boolean;
        private var _isMouseEnabled:Boolean;
        private var panel:Asset;

        public function WhistleTree(_arg1:Asset, _arg2:Asset){
            super(_arg1);
            this.panel = _arg2;
            _arg2.self.visible = false;
            mouseChildren = false;
            this._isMouseEnabled = true;
            this._clicked = new Signal();
            this._over = new Signal();
            this._out = new Signal();
            if (_arg1.isComplete){
                this.onLoadComplete(_arg1);
            } else {
                _arg1.complete.add(this.onLoadComplete);
            };
        }
        public function get over():ISignal{
            return (this._over);
        }
        public function get out():ISignal{
            return (this._out);
        }
        public function get clicked():ISignal{
            return (this._clicked);
        }
        public function get state():WhistleTreeState{
            return (this._state);
        }
        public function set state(_arg1:WhistleTreeState):void{
            if (this._state == _arg1){
                return;
            };
            var _local2 = (this._state == null);
            this._state = _arg1;
            if (_asset.isComplete){
                this.gotoState(this._state, _local2);
            };
        }
        public function showDialog(_arg1:String, _arg2:String, _arg3:String):void{
            var _local4:MovieClip = MovieClip(this.panel.content);
            _local4.label.text = _arg1;
            _local4.lastWatered.label.text = _arg2;
            _local4.moreWhistlesIn.label.text = _arg3;
            this.panel.self.visible = true;
        }
        public function hideDialog():void{
            this.panel.self.visible = false;
        }
        private function onLoadComplete(_arg1:Asset):void{
            this._content = MovieClip(_arg1.content);
            this._frames = this.getFrames(this._content);
            if (this._state){
                this.gotoState(this._state, true);
            };
            addChild(_arg1.self);
        }
        private function getFrames(_arg1:MovieClip):Object{
            var _local3:FrameLabel;
            var _local2:Object = {};
            for each (_local3 in _arg1.currentLabels) {
                _local2[_local3.name] = _local3.frame;
            };
            return (_local2);
        }
        private function gotoState(_arg1:WhistleTreeState, _arg2:Boolean=false):void{
            var _local3:String = _arg1.toString();
            this._targetFrame = this._frames[_local3];
            var _local4:int = this._content.currentFrame;
            if (((_arg2) || ((this._targetFrame == _local4)))){
                this._content.gotoAndStop(this._targetFrame);
                this.enableMouse();
                return;
            };
            this._dFrame = ((this._targetFrame > _local4)) ? 1 : -1;
            this._content.addEventListener(Event.ENTER_FRAME, this.animate);
            this._animating = true;
            this.disableMouse();
        }
        public function get enabled():Boolean{
            return (this._isMouseEnabled);
        }
        public function set enabled(_arg1:Boolean):void{
            if (this._isMouseEnabled == _arg1){
                return;
            };
            this._isMouseEnabled = _arg1;
            if (((this._isMouseEnabled) && (!(this._animating)))){
                this.enableMouse();
            } else {
                this.disableMouse();
            };
        }
        public function water():void{
            this._content.water.gotoAndPlay("watering");
            this._content.cta.play();
        }
        public function showCTA():void{
            this._content.cta.visible = true;
            this._content.cta.gotoAndStop(1);
        }
        public function hideCTA():void{
            this._content.cta.visible = false;
        }
        private function enableMouse():void{
            addEventListener(MouseEvent.ROLL_OVER, this.onRollOver, false, 0, true);
            addEventListener(MouseEvent.ROLL_OUT, this.onRollOut, false, 0, true);
            addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            buttonMode = true;
            useHandCursor = true;
        }
        private function disableMouse():void{
            removeEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            removeEventListener(MouseEvent.CLICK, this.onClick);
            buttonMode = false;
            useHandCursor = false;
        }
        private function onRollOver(_arg1:MouseEvent):void{
            this._over.dispatch();
        }
        private function onRollOut(_arg1:MouseEvent):void{
            this._out.dispatch();
        }
        private function onClick(_arg1:MouseEvent):void{
            this._clicked.dispatch(this);
        }
        private function animate(_arg1:Event):void{
            if (this._content.currentFrame == this._targetFrame){
                this._content.removeEventListener(Event.ENTER_FRAME, this.animate);
                this._animating = false;
                if (this._isMouseEnabled){
                    this.enableMouse();
                };
            } else {
                if (this._dFrame == 1){
                    this._content.nextFrame();
                } else {
                    this._content.prevFrame();
                };
            };
        }

    }
}//package gaia.moga.whistletree.view.ui 
