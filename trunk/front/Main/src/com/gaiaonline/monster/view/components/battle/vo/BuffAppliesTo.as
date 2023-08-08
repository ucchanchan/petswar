//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.vo {

    public class BuffAppliesTo {

        private var _id:uint;

        public static const PLAYER:BuffAppliesTo = new BuffAppliesTo(1);
;
        public static const NPC:BuffAppliesTo = new BuffAppliesTo(2);
;

        private static var map:Object;

        public function BuffAppliesTo(_arg1:uint){
            (map = ((map) || ({})))[_arg1] = this;
            this._id = _arg1;
        }
        public function get id():uint{
            return (this._id);
        }

        public static function parse(_arg1:uint):BuffAppliesTo{
            return (map[_arg1]);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.vo 
