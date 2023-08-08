//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.lib.ui {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import org.osflash.signals.*;
    import flash.geom.*;

    public class VScrollBar {

        private var knob:MovieClip;
        private var stage:Stage;
        private var groove:MovieClip;
        private var knobRectangle:Rectangle;
        private var grooveRectangle:Rectangle;
        private var _isVisible:Boolean;
        private var offsetY:int;
        private var top:int;
        private var bottom:int;
        private var visible:uint;
        private var count:uint;
        private var scalar:Number;
        private var tween:GTween;
        private var position:Number;
        private var _reposition:Signal;

        private static const DURATION:Number = 0.3;

        public function VScrollBar(_arg1:MovieClip, _arg2:MovieClip){
            this.knob = _arg1;
            this.groove = _arg2;
            this.knobRectangle = _arg1.getRect(_arg1);
            this.grooveRectangle = _arg2.getRect(_arg2);
            this.tween = new GTween(_arg1, DURATION, null, {onChange:this.onChange});
            this._reposition = new Signal(Number);
            this._isVisible = false;
            _arg1.visible = false;
            _arg2.visible = false;
        }
        public function get reposition():ISignal{
            return (this._reposition);
        }
        public function setup(_arg1:uint, _arg2:uint, _arg3:Boolean=false):void{
            var _local4:Number;
            this.visible = _arg1;
            this.count = _arg2;
            _local4 = (_arg1 / _arg2);
            this.knob.scaleY = _local4;
            this.top = ((this.groove.y + this.grooveRectangle.top) - (this.knobRectangle.top * _local4));
            if (!_arg3){
                this.knob.y = this.top;
            };
            this.bottom = ((this.groove.y + this.grooveRectangle.bottom) - (this.knobRectangle.bottom * _local4));
            this.scalar = ((_arg2 - _arg1) / (this.bottom - this.top));
            if (isNaN(this.position)){
                this.position = 0;
            };
            if (_arg3){
                while ((((_arg2 > _arg1)) && ((_arg2 < (this.position + _arg1))))) {
                    this.position--;
                };
                this.knob.y = ((this.position / this.scalar) + this.top);
            } else {
                this.position = ((this.knob.y - this.top) * this.scalar);
            };
            this._reposition.dispatch(this.position);
        }
        public function get isVisible():Boolean{
            return (this._isVisible);
        }
        public function set isVisible(_arg1:Boolean):void{
            if (this._isVisible == _arg1){
                return;
            };
            this._isVisible = _arg1;
            this.knob.visible = _arg1;
            this.groove.visible = _arg1;
            if (_arg1){
                this.addListeners();
            } else {
                this.removeListeners();
            };
        }
        private function addListeners():void{
            this.knob.useHandCursor = true;
            this.knob.buttonMode = true;
            this.stage = this.knob.stage;
            if (this.stage){
                this.knob.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            };
        }
        private function removeListeners():void{
            this.knob.useHandCursor = false;
            this.knob.buttonMode = false;
            this.knob.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            this.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
        private function onMouseDown(_arg1:MouseEvent):void{
            this.offsetY = (this.knob.y - this.stage.mouseY);
            this.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            this.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
        private function onMouseMove(_arg1:MouseEvent):void{
            var _local2:int = (this.stage.mouseY + this.offsetY);
            _local2 = ((_local2 < this.top)) ? this.top : ((_local2 > this.bottom)) ? this.bottom : _local2;
            this.knob.y = _local2;
            this.position = ((this.knob.y - this.top) * this.scalar);
            this._reposition.dispatch(this.position);
        }
        private function onMouseUp(_arg1:MouseEvent):void{
            this.knob.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            this.knob.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            var _local2:int = ((Math.round((this.position - 0.2)) / this.scalar) + this.top);
            this.tween.setValue("y", _local2);
        }
        private function onChange(_arg1:GTween):void{
            this.position = ((this.knob.y - this.top) * this.scalar);
            this._reposition.dispatch(this.position);
        }

    }
}//package gaia.lib.ui 
