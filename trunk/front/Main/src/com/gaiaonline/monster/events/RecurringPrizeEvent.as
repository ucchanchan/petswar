//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.events {
    import flash.events.*;

    public class RecurringPrizeEvent extends Event {

        public static const CLAIM_PRIZE:String = "PrizeTimerEvent.CLAIM_PRIZE";
        public static const CLOSE_PROMPT:String = "PrizeTimerEvent.CLOSE_PROMPT";

        public function RecurringPrizeEvent(_arg1:String){
            super(_arg1);
        }
    }
}//package com.gaiaonline.monster.events 
