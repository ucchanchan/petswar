//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.widget {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import __AS3__.vec.*;
    import alecmce.geom3D.*;
    import com.gskinner.motion.easing.*;

    public class Carousel extends Sprite {

        private var points:Vector.<Point3D>;
        private var list:Vector.<DisplayObject>;
        private var viewpoint:Viewpoint3D;
        private var radius:Number;
        private var _needsUpdate:Boolean;// = false
        public var angle:Number;
        private var dAngle:Number;
        private var dA:Number;
        private var tween:GTween;

        private static const PI:Number = 3.14159265358979;
        private static const TWO_PI:Number = 6.28318530717959;
        private static const HALF_PI:Number = 1.5707963267949;

        public function Carousel(_arg1:Viewpoint3D, _arg2:Number){
            this.points = new Vector.<Point3D>();
            this.list = new Vector.<DisplayObject>();
            this.viewpoint = _arg1;
            this.radius = _arg2;
            this.angle = HALF_PI;
        }
        public function rotate(_arg1:Number):void{
            if (this.dAngle == _arg1){
                return;
            };
            this.dAngle = _arg1;
            if (_arg1 != 0){
                addEventListener(Event.ENTER_FRAME, this.iterate);
            } else {
                removeEventListener(Event.ENTER_FRAME, this.iterate);
            };
        }
        public function bringToFront(_arg1:DisplayObject):Boolean{
            var _local2:int = this.list.indexOf(_arg1);
            if (_local2 == -1){
                return (false);
            };
            this.dAngle = 0;
            removeEventListener(Event.ENTER_FRAME, this.iterate);
            if (this.tween){
                this.tween.paused = true;
            };
            var _local3:Number = ((TWO_PI + HALF_PI) - (this.dA * _local2));
            if ((_local3 - this.angle) > PI){
                _local3 = (_local3 - TWO_PI);
            } else {
                if ((_local3 - this.angle) < -(PI)){
                    _local3 = (_local3 + TWO_PI);
                };
            };
            this.tween = new GTween(this, 1, {angle:_local3}, {ease:Quadratic.easeInOut, onChange:this.redraw, onComplete:this.onComplete});
            return (true);
        }
        private function onComplete(_arg1:GTween):void{
            if (this.angle > TWO_PI){
                this.angle = (this.angle - TWO_PI);
            } else {
                if (this.angle < 0){
                    this.angle = (this.angle + TWO_PI);
                };
            };
        }
        private function iterate(_arg1:Event):void{
            this.angle = (this.angle + this.dAngle);
            if (this.angle > TWO_PI){
                this.angle = (this.angle - TWO_PI);
            } else {
                if (this.angle < 0){
                    this.angle = (this.angle + TWO_PI);
                };
            };
            if (this._needsUpdate){
                this.update();
            };
            this.redraw();
        }
        public function clearItems():void{
            if (this.tween){
                this.tween.paused = true;
            };
            var _local1:int = numChildren;
            while (_local1--) {
                removeChildAt(0);
            };
            this.list = new Vector.<DisplayObject>();
            this.update();
        }
        public function addItem(_arg1:DisplayObject):void{
            this.list.push(_arg1);
            addChild(_arg1);
            this._needsUpdate = true;
            this.invalidate();
        }
        public function invalidate():void{
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame, false, 100);
        }
        private function onEnterFrame(_arg1:Event):void{
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            if (this._needsUpdate){
                this.update();
            };
            this.redraw();
        }
        private function update():void{
            var _local3:Number;
            var _local4:Number;
            var _local5:Number;
            var _local6:int;
            this._needsUpdate = false;
            var _local1:int = this.list.length;
            this.dA = ((Math.PI * 2) / _local1);
            this.points = new Vector.<Point3D>((_local1 << 1), 3);
            var _local2:int = this.list.length;
            while (_local2--) {
                _local3 = (this.angle + (this.dA * _local2));
                _local4 = (Math.cos(_local3) * this.radius);
                _local5 = (Math.sin(_local3) * this.radius);
                _local6 = (_local2 << 1);
                this.points[_local6] = new Point3D(_local4, 0, _local5);
                this.points[(_local6 | 1)] = new Point3D(_local4, 1, _local5);
            };
        }
        private function redraw(_arg1=null):void{
            var _local3:int;
            var _local4:int;
            var _local7:Number;
            var _local8:Number;
            var _local9:Number;
            var _local10:DisplayObject;
            var _local11:ViewpointResolved;
            var _local2:uint = this.list.length;
            _local3 = _local2;
            while (_local3--) {
                _local4 = (_local3 << 1);
                _local7 = (this.angle + (this.dA * _local3));
                _local8 = (Math.cos(_local7) * this.radius);
                _local9 = (Math.sin(_local7) * this.radius);
                this.points[_local4].x = _local8;
                this.points[_local4].z = _local9;
                this.points[(_local4 | 1)].x = _local8;
                this.points[(_local4 | 1)].z = _local9;
            };
            var _local5:Vector.<ViewpointResolved> = this.viewpoint.transformPoints(this.points);
            _local3 = _local2;
            while (_local3--) {
                _local4 = (_local3 << 1);
                _local10 = this.list[_local3];
                _local11 = _local5[_local4];
                _local10.x = _local11.x;
                _local10.y = _local11.y;
                _local10.scaleX = (_local10.scaleY = ((_local11.y - _local5[(_local4 | 1)].y) * 0.1));
            };
            var _local6:Vector.<DisplayObject> = this.list.concat();
            _local6.sort(this.compare);
            _local3 = _local2;
            while (_local3--) {
                setChildIndex(_local6[_local3], _local3);
            };
        }
        private function compare(_arg1:DisplayObject, _arg2:DisplayObject):int{
            var _local3:Number = _arg1.y;
            var _local4:Number = _arg2.y;
            return (((_local3 > _local4)) ? 1 : ((_local3 < _local4)) ? -1 : 0);
        }

    }
}//package alecmce.ui.widget 
