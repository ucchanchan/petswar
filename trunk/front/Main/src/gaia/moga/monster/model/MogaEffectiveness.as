//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.monster.model {
    import flash.utils.*;
    import __AS3__.vec.*;

    public class MogaEffectiveness {

        private var map:Dictionary;

        public function MogaEffectiveness(){
            this.map = new Dictionary();
        }
        public function addZodiac(_arg1:String, _arg2:uint):void{
            var _local3:Vector.<uint> = (this.map[_arg1] = ((this.map[_arg1]) || (new Vector.<uint>())));
            _local3.push(_arg2);
        }
        public function setZodiacs(_arg1:String, _arg2:Vector.<uint>):void{
            this.map[_arg1] = _arg2;
        }
        public function getZodiacs(_arg1:String):Vector.<uint>{
            return ((this.map[_arg1] = ((this.map[_arg1]) || (new Vector.<uint>()))));
        }

    }
}//package gaia.moga.monster.model 
