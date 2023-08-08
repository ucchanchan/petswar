//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.vo {

    public class BuffAction {

        private var _id:uint;

        public static const DAMAGE:BuffAction = new BuffAction(1);
;
        public static const ATTACK:BuffAction = new BuffAction(2);
;
        public static const GET_PROPERTY:BuffAction = new BuffAction(3);
;
        public static const EACH_ROUND:BuffAction = new BuffAction(4);
;

        private static var map:Object;

        public function BuffAction(_arg1:uint){
            (map = ((map) || ({})))[_arg1] = this;
            this._id = _arg1;
        }
        public function get id():uint{
            return (this._id);
        }

        public static function parse(_arg1:uint):BuffAction{
            return (map[_arg1]);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.vo 
