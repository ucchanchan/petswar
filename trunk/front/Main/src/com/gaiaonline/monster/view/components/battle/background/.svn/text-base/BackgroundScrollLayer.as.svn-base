//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.background {
    import flash.display.*;
    import flash.filters.*;

    public class BackgroundScrollLayer {

        private var _target:DisplayObject;
        private var _left:Number;
        private var _right:Number;
        private var _useBlur:Boolean;
        private var dX:Number;
        private var current:Number;
        private var prevX:Number;
        private var blur:BlurFilter;
        private var _filters:Array;
        private var _inMotion:Boolean;

        public function BackgroundScrollLayer(_arg1:DisplayObject, _arg2:Number, _arg3:Number, _arg4:Boolean=false){
            this._target = _arg1;
            this._left = _arg2;
            this._right = _arg3;
            this.current = 0;
            this.dX = -((this._right + this._left));
            this.prevX = this._target.x;
            this.useBlur = _arg4;
        }
        public function get target():DisplayObject{
            return (this._target);
        }
        public function get useBlur():Boolean{
            return (this._useBlur);
        }
        public function set useBlur(_arg1:Boolean):void{
            if (this._useBlur == _arg1){
                return;
            };
            this._useBlur = _arg1;
            if (this._useBlur){
                this._filters = (this._target.filters) ? this._target.filters : [];
                this._filters.push((this.blur = new BlurFilter(0, 0)));
                this._target.filters = this._filters;
            } else {
                this._filters.pop();
                this.blur = null;
                this._target.filters = (this._filters.length) ? this._filters : null;
            };
        }
        public function update(_arg1:Number, _arg2:Boolean=true):void{
            this._inMotion = _arg2;
            this.current = _arg1;
            var _local3:Number = (this._left + (this.dX * _arg1));
            this._target.x = _local3;
            if (this._useBlur){
                this.blur.blurX = (_arg2) ? ((_local3 < this.prevX)) ? (this.prevX - _local3) : (_local3 - this.prevX) : 0;
                this._target.filters = this._filters;
            };
            this.prevX = _local3;
        }
        public function updateBound(_arg1:DisplayObject, _arg2:Number, _arg3:Boolean):void{
            _arg1.x = (this._target.x + _arg2);
            if (!_arg3){
                return;
            };
            if (((this._useBlur) && (this._inMotion))){
                _arg1.filters = this._filters;
            } else {
                _arg1.filters = null;
            };
        }
        public function get left():Number{
            return (this._left);
        }
        public function get right():Number{
            return (this._right);
        }
        public function setRange(_arg1:Number, _arg2:Number):void{
            this._left = _arg1;
            this._right = _arg2;
            this.dX = -((this._right + this._left));
            this.update(this.current, false);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.background 
