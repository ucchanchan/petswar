//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.vo {

    public class BuffResult {

        private var _id:uint;

        public static const DAMAGE:BuffResult = new BuffResult(1);
;
        public static const HP:BuffResult = new BuffResult(2);
;
        public static const PROPERTY_MODIFIER:BuffResult = new BuffResult(3);
;
        public static const APPLY_BUFF:BuffResult = new BuffResult(4);
;
        public static const TURN:BuffResult = new BuffResult(5);
;

        private static var map:Object;

        public function BuffResult(_arg1:uint){
            (map = ((map) || ({})))[_arg1] = this;
            this._id = _arg1;
        }
        public function get id():uint{
            return (this._id);
        }

        public static function parse(_arg1:uint):BuffResult{
            return (map[_arg1]);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.vo 
