//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.button {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;

    public class MovieClipButton implements Button {

        protected var _ui:MovieClip;
        protected var _target:MovieClip;
        private var _stage:Stage;
        private var _clicked:Signal;
        private var _over:Signal;
        private var _out:Signal;
        private var _isOver:Boolean;
        private var _isDown:Boolean;
        private var _isVisible:Boolean;
        private var _isEnabled:Boolean;
        private var _useHandCursor:Boolean;
        public var outFrame;
        public var overFrame;
        public var downFrame;
        public var disabledFrame;

        public function MovieClipButton(_arg1:MovieClip, _arg2=1, _arg3=2, _arg4=3, _arg5=4){
            this._ui = _arg1;
            this.outFrame = _arg2;
            this.overFrame = _arg3;
            this.downFrame = _arg4;
            this.disabledFrame = _arg5;
            if (this._ui.hit){
                this._target = this._ui.hit;
                this._ui.hit.alpha = 0;
            } else {
                this._target = this._ui;
            };
            this._target = (this._ui.hit) ? this._ui.hit : this._ui;
            this._clicked = new Signal(MovieClipButton);
            this._over = new Signal(MovieClipButton);
            this._out = new Signal(MovieClipButton);
            this._isDown = false;
            this._isOver = false;
            this._isEnabled = true;
            this._isVisible = true;
            this._useHandCursor = true;
            this._target.useHandCursor = this._useHandCursor;
            this._target.buttonMode = true;
            this._target.mouseChildren = false;
            this._target.mouseEnabled = true;
            this.addEventListeners();
            this.update();
        }
        public function get ui():MovieClip{
            return (this._ui);
        }
        private function onRollOver(_arg1:MouseEvent):void{
            if (this._isOver){
                return;
            };
            this._isOver = true;
            this._stage = this._ui.stage;
            this._stage.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            this.update();
            this._over.dispatch(this);
        }
        private function onRollOut(_arg1:MouseEvent):void{
            if (!this._isOver){
                return;
            };
            this._isOver = false;
            if (this._stage){
                this._stage.removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            };
            this.update();
            this._out.dispatch(this);
        }
        private function onMouseDown(_arg1:MouseEvent):void{
            if (this._isDown){
                return;
            };
            this._isDown = true;
            this._stage = this._ui.stage;
            this._stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            this.update();
        }
        private function onMouseOut(_arg1:MouseEvent):void{
            if (this._isDown){
                this.onRollOut(_arg1);
            };
        }
        private function onMouseUp(_arg1:MouseEvent):void{
            if (!this._isDown){
                return;
            };
            this._isDown = false;
            if (this._stage){
                this._stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            };
            this.update();
        }
        private function onClick(_arg1:MouseEvent):void{
            this._isDown = false;
            this.update();
            this.click();
        }
        protected function click():void{
            this._clicked.dispatch(this);
        }
        public function get isOver():Boolean{
            return (this._isOver);
        }
        public function get isDown():Boolean{
            return (this._isDown);
        }
        public function get isVisible():Boolean{
            return (false);
        }
        public function set isVisible(_arg1:Boolean):void{
            if (this._isVisible == _arg1){
                return;
            };
            this._isVisible = _arg1;
            this._ui.visible = _arg1;
            if (((this._isEnabled) && (this._isVisible))){
                this.addEventListeners();
            } else {
                this.removeEventListeners();
            };
            this.update();
        }
        public function get isEnabled():Boolean{
            return (this._isEnabled);
        }
        public function set isEnabled(_arg1:Boolean):void{
            if (this._isEnabled == _arg1){
                return;
            };
            this._isEnabled = _arg1;
            if (!this._isEnabled){
                this._isDown = false;
                this._isOver = false;
            };
            if (((this._isEnabled) && (this._isVisible))){
                this.addEventListeners();
            } else {
                this.removeEventListeners();
            };
            this.update();
        }
        public function update():void{
            var _local1:*;
            if (!this._isEnabled){
                _local1 = this.disabledFrame;
            } else {
                if (this._isDown){
                    _local1 = this.downFrame;
                } else {
                    if (this._isOver){
                        _local1 = this.overFrame;
                    } else {
                        _local1 = this.outFrame;
                    };
                };
            };
            this._ui.gotoAndStop(_local1);
        }
        public function get clicked():ISignal{
            return (this._clicked);
        }
        public function get over():ISignal{
            return (this._over);
        }
        public function get out():ISignal{
            return (this._out);
        }
        private function addEventListeners():void{
            this._target.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            this._target.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            this._target.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this._target.addEventListener(MouseEvent.CLICK, this.onClick);
            this._target.useHandCursor = this._useHandCursor;
        }
        private function removeEventListeners():void{
            this._target.removeEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            this._target.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            this._target.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this._target.removeEventListener(MouseEvent.CLICK, this.onClick);
            this._target.useHandCursor = false;
            if (!this._stage){
                return;
            };
            this._stage.removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            this._stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            this._stage = null;
        }
        public function get useHandCursor():Boolean{
            return (this._useHandCursor);
        }
        public function set useHandCursor(_arg1:Boolean):void{
            this._useHandCursor = _arg1;
            this._target.useHandCursor = ((((this._isEnabled) && (this._isVisible))) && (this._useHandCursor));
        }

    }
}//package alecmce.ui.button 
