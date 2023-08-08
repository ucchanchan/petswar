//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.model {

    public class ExperienceVO {

        private var _absolute:int;
        private var _value:int;
        private var _max:int;
        private var _level:int;
        private var _priorAbsolute:int;
        private var _priorValue:int;
        private var _priorMax:int;
        private var _priorLevel:int;

        public function ExperienceVO(_arg1:int, _arg2:int, _arg3:int, _arg4:int){
            this._absolute = _arg1;
            this._value = _arg2;
            this._max = _arg3;
            this._level = _arg4;
        }
        public function update(_arg1:uint, _arg2:uint, _arg3:uint=1, _arg4:int=-1):void{
            var _local5:Boolean = ((((!((this._value == _arg2))) || (((!((_arg3 == -1))) && (!((this._max == _arg3))))))) || (((!((_arg4 == -1))) && (!((this._level == _arg4))))));
            if (!_local5){
                return;
            };
            this._priorAbsolute = this._absolute;
            this._absolute = _arg1;
            this._priorValue = this._value;
            this._value = _arg2;
            if (_arg3 != -1){
                this._priorMax = this._max;
                this._max = _arg3;
            };
            if (this._level != -1){
                this._priorLevel = this._level;
                this._level = _arg4;
            };
        }
        public function get value():int{
            return (this._value);
        }
        public function get max():int{
            return (this._max);
        }
        public function get level():int{
            return (this._level);
        }
        public function get change():int{
            return ((this._absolute - this._priorAbsolute));
        }
        public function get priorValue():int{
            return (this._priorValue);
        }
        public function get priorMax():int{
            return (this._priorMax);
        }
        public function get priorLevel():int{
            return (this._priorLevel);
        }

    }
}//package com.gaiaonline.monster.model 
