//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.vo {

    public class BuffType {

        private var _id:uint;

        public static const BUFF:BuffType = new BuffType(1);
;
        public static const DEBUFF:BuffType = new BuffType(2);
;

        private static var map:Object;

        public function BuffType(_arg1:uint){
            (map = ((map) || ({})))[_arg1] = this;
            this._id = _arg1;
        }
        public function get id():uint{
            return (this._id);
        }

        public static function parse(_arg1:uint):BuffType{
            return (map[_arg1]);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.vo 
