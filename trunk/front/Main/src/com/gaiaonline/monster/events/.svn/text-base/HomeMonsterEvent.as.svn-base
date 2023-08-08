//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.events {
    import flash.events.*;
    import com.gaiaonline.monster.view.components.home.*;

    public class HomeMonsterEvent extends Event {

        public var monster:HomeMonster;

        public static const START_DRAG:String = "HomeMonsterEvent.START_DRAG";
        public static const END_DRAG:String = "HomeMonsterEvent.END_DRAG";
        public static const ROLL_OVER:String = "HomeMonsterEvent.ROLL_OVER";
        public static const ROLL_OUT:String = "HomeMonsterEvent.ROLL_OUT";

        public function HomeMonsterEvent(_arg1:String, _arg2:HomeMonster){
            super(_arg1);
            this.monster = _arg2;
        }
        override public function clone():Event{
            return (new HomeMonsterEvent(type, this.monster));
        }

    }
}//package com.gaiaonline.monster.events 
