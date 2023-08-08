//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.events {
    import flash.events.*;

    public class StoreEvent extends Event {

        public var id:uint;
        public var qty:uint;

        public static const BUY_ITEM:String = "StoreEvent.BUY_ITEM";
        public static const BUY_ITEM_SUCCESS:String = "StoreEvent.BUY_ITEM_SUCCESS";
        public static const BUY_ITEM_FAIL:String = "StoreEvent.BUY_ITEM_FAIL";

        public function StoreEvent(_arg1:String, _arg2=null, _arg3=null){
            super(_arg1);
            this.id = _arg2;
            this.qty = _arg3;
        }
    }
}//package com.gaiaonline.monster.events 
