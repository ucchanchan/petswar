//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.events {
    import flash.events.*;
    import com.gaiaonline.monster.model.*;

    public class NapEvent extends Event {

        public var targetModel:MonsterModel;

        public static const RECHARGE_MONSTER:String = "NewUserEvent.RECHARGE_MONSTER";
        public static const AWAKEN_MONSTER:String = "NewUserEvent.AWAKEN_MONSTER";
        public static const START_NAP:String = "NewUserEvent.START_NAP";

        public function NapEvent(_arg1:String, _arg2:MonsterModel){
            super(_arg1);
            this.targetModel = _arg2;
        }
    }
}//package com.gaiaonline.monster.events 
