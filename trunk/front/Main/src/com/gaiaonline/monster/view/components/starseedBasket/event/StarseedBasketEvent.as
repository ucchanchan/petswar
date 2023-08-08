//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.event {
    import flash.events.*;

    public class StarseedBasketEvent extends Event {

        public var data:Object;

        public static const OPEN_REQUESTOR_UI:String = "StarseedBasketEvent.OPEN_REQUESTOR_UI";
        public static const OPEN_GIVER_UI:String = "StarseedBasketEvent.OPEN_GIVER_UI";
        public static const COLLECT_STARSEEDS:String = "StarseedBasketEvent.COLLECT_STARSEEDS";
        public static const GIVE_STARSEED:String = "StarseedBasketEvent.GIVE_STARSEED";

        public function StarseedBasketEvent(_arg1:String, _arg2:Object=null){
            super(_arg1);
            this.data = _arg2;
        }
        override public function clone():Event{
            var _local1:StarseedBasketEvent = new StarseedBasketEvent(type);
            _local1.data = this.data;
            return (_local1);
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.event 
