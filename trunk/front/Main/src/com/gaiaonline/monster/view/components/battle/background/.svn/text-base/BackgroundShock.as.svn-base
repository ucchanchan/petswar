//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.background {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;

    public class BackgroundShock {

        private var _complete:Signal;
        private var shockPool:Vector.<Vector.<Vector.<Number>>>;
        private var layers:Vector.<DisplayObject>;
        private var magnitudes:Vector.<Number>;
        private var positions:Vector.<Vector.<Number>>;
        private var theShock:Vector.<Vector.<Number>>;
        private var count:uint;
        private var _isShocking:Boolean;
        private var position:uint;
        private var length:uint;

        private static const PI:Number = 3.14159265358979;
        private static const TWO_PI:Number = 6.28318530717959;
        private static const VARIATION:Number = 0.314159265358979;
        private static const HALF_VARIATION:Number = 0.15707963267949;
        private static const DURATIONS:Vector.<uint> = Vector.<uint>([1, 1, 1, 2, 2, 3, 4]);
        private static const MAGNITUDES:Vector.<Number> = Vector.<Number>([0.63, 1, 0.71, 0.51, 0.34, 0.22, 0.1]);
        private static const SHOCKS:uint = 10;

        public function BackgroundShock(){
            this._complete = new Signal();
            this.shockPool = this.createShocks();
            this.layers = new Vector.<DisplayObject>();
            this.magnitudes = new Vector.<Number>();
            this.positions = new Vector.<Vector.<Number>>();
            this.count = 0;
            this.length = this.shockPool[0].length;
            this.position = 0;
        }
        public function addLayer(_arg1:DisplayObject, _arg2:Number):void{
            this.layers[this.count] = _arg1;
            var _local3 = this.count++;
            this.magnitudes[_local3] = _arg2;
        }
        public function shock():void{
            if (this._isShocking){
                return;
            };
            var _local1:DisplayObject = this.layers[0];
            if (!_local1){
                return;
            };
            _local1.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            var _local2:int;
            while (_local2 < this.count) {
                _local1 = this.layers[_local2];
                this.positions[_local2] = Vector.<Number>([_local1.x, _local1.y]);
                _local2++;
            };
            this.theShock = this.shockPool[((Math.random() * SHOCKS) | 0)];
            this.position = 0;
            this._isShocking = true;
        }
        private function onEnterFrame(_arg1:Event):void{
            var _local2:DisplayObject;
            var _local3:int;
            while (_local3 < this.count) {
                _local2 = this.layers[_local3];
                _local2.x = (_local2.x + (this.theShock[this.position][0] * this.magnitudes[_local3]));
                _local2.y = (_local2.y + (this.theShock[this.position][1] * this.magnitudes[_local3]));
                _local3++;
            };
            if (++this.position == this.length){
                _local2 = this.layers[0];
                _local2.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                this._isShocking = false;
                this._complete.dispatch(this);
            };
        }
        public function get isShocking():Boolean{
            return (this._isShocking);
        }
        private function createShocks():Vector.<Vector.<Vector.<Number>>>{
            var _local1:Vector.<Vector.<Vector.<Number>>> = new Vector.<Vector.<Vector.<Number>>>(SHOCKS, true);
            var _local2:int;
            while (_local2 < SHOCKS) {
                _local1[_local2] = this.createShock();
                _local2++;
            };
            return (_local1);
        }
        private function createShock():Vector.<Vector.<Number>>{
            var _local5:Number;
            var _local6:Number;
            var _local9:Number;
            var _local10:Number;
            var _local11:int;
            var _local12:Number;
            var _local1:Number = (Math.random() * TWO_PI);
            var _local2:Vector.<Vector.<Number>> = new Vector.<Vector.<Number>>();
            var _local3:Number = 0;
            var _local4:Number = 0;
            var _local7:uint = DURATIONS.length;
            var _local8:int;
            while (_local8 < _local7) {
                _local9 = DURATIONS[_local8];
                if (_local8 < (_local7 - 1)){
                    _local12 = MAGNITUDES[_local8];
                    _local10 = (_local12 / _local9);
                    _local5 = (Math.cos(_local1) * _local10);
                    _local6 = (Math.sin(_local1) * _local10);
                } else {
                    _local10 = (1 / _local9);
                    _local5 = (-(_local3) * _local10);
                    _local6 = (-(_local4) * _local10);
                };
                _local11 = 0;
                while (_local11 < DURATIONS[_local8]) {
                    _local3 = (_local3 + _local5);
                    _local4 = (_local4 + _local6);
                    _local2.push(Vector.<Number>([_local5, _local6]));
                    _local11++;
                };
                _local1 = (_local1 + ((PI - HALF_VARIATION) + (Math.random() * VARIATION)));
                _local8++;
            };
            return (_local2);
        }
        public function get complete():Signal{
            return (this._complete);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.background 
