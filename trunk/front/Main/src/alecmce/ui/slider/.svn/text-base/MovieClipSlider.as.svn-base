//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.slider {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import flash.geom.*;

    public class MovieClipSlider implements Slider {

        protected var _knob:MovieClip;
        protected var _groove:MovieClip;
        private var _changed:Signal;
        private var _isVisible:Boolean;
        private var _isEnabled:Boolean;
        private var _value:Number;
        private var _max:Number;
        private var _min:Number;
        private var _range:Number;
        private var _invrange:Number;
        private var _step:Number;
        private var _right:Number;
        private var _left:Number;
        private var _offsetX:Number;
        private var _width:Number;
        private var _invwidth:Number;

        public function MovieClipSlider(_arg1:MovieClip, _arg2:MovieClip, _arg3:Number=0.5, _arg4:Number=0, _arg5:Number=1, _arg6:Number=0){
            this._knob = _arg1;
            this._groove = _arg2;
            var _local7:Rectangle = this._knob.getBounds(this._knob);
            var _local8:Rectangle = this._groove.getBounds(this._groove.parent);
            this._right = (_local8.right - _local7.right);
            this._left = (_local8.left - _local7.left);
            this._width = (this._right - this._left);
            this._invwidth = (1 / this._width);
            this._changed = new Signal(MovieClipSlider, Number);
            this._min = _arg4;
            this._max = _arg5;
            this._range = (_arg5 - _arg4);
            this._invrange = (1 / this._range);
            this._step = _arg6;
            this.value = _arg3;
            this.addEventListeners();
        }
        public function get value():Number{
            return (this._value);
        }
        public function get min():Number{
            return (this._min);
        }
        public function get max():Number{
            return (this._max);
        }
        public function get step():Number{
            return (this._step);
        }
        public function set value(_arg1:Number):void{
            var _local3:Number;
            if (_arg1 < this._min){
                _arg1 = this._min;
            } else {
                if (_arg1 > this._max){
                    _arg1 = this._max;
                };
            };
            var _local2:Number = (_arg1 - this._min);
            if (this._step != 0){
                _local3 = (_local2 / this._step);
                _arg1 = (this._min + (this._step * Math.round(_local3)));
                _local2 = (_arg1 - this._min);
            };
            _local2 = (_local2 * this._invrange);
            if (this._value == _arg1){
                return;
            };
            this._knob.x = (this._left + (_local2 * this._width));
            this._value = _arg1;
            this._changed.dispatch(this, this._value);
        }
        public function get changed():ISignal{
            return (this._changed);
        }
        public function setBounds(_arg1:Number, _arg2:Number, _arg3:Number=0):void{
            this._min = _arg1;
            this._max = _arg2;
            this._range = (_arg2 - _arg1);
            this._step = _arg3;
            this.value = this._value;
        }
        public function get ui():MovieClip{
            return (null);
        }
        public function get isVisible():Boolean{
            return (this._isVisible);
        }
        public function get isEnabled():Boolean{
            return (this._isEnabled);
        }
        public function set isVisible(_arg1:Boolean):void{
            if (this._isVisible == _arg1){
                return;
            };
            this._isVisible = _arg1;
            this._knob.visible = _arg1;
            this._groove.visible = _arg1;
            if (((this._isVisible) && (this._isEnabled))){
                this.addEventListeners();
            } else {
                this.removeEventListeners();
            };
        }
        public function set isEnabled(_arg1:Boolean):void{
            if (this._isEnabled == _arg1){
                return;
            };
            this._isEnabled = _arg1;
            if (((this._isVisible) && (this._isEnabled))){
                this.addEventListeners();
            } else {
                this.removeEventListeners();
            };
        }
        private function addEventListeners():void{
            this._knob.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        }
        private function removeEventListeners():void{
            this._knob.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this._knob.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            this._knob.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
        private function onMouseDown(_arg1:MouseEvent):void{
            this._knob.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            this._knob.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            this._offsetX = (this._knob.x - this._knob.parent.mouseX);
        }
        private function onMouseMove(_arg1:MouseEvent):void{
            var _local2:Number = (this._knob.parent.mouseX + this._offsetX);
            if (_local2 < this._left){
                _local2 = this._left;
            } else {
                if (_local2 > this._right){
                    _local2 = this._right;
                };
            };
            var _local3:Number = ((_local2 - this._left) * this._invwidth);
            this.value = (this._min + (_local3 * this._range));
            _arg1.updateAfterEvent();
        }
        private function onMouseUp(_arg1:MouseEvent):void{
            this._knob.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            this._knob.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }

    }
}//package alecmce.ui.slider 
