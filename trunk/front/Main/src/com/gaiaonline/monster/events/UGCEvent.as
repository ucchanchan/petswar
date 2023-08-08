//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.events {
    import flash.events.*;

    public class UGCEvent extends Event {

        public var data:Object;

        public static const ATTEND_EVENT:String = "ATTEND_EVENT";
        public static const CREATE_EVENT:String = "CREATE_EVENT";

        public function UGCEvent(_arg1:String, _arg2:Object=null){
            super(_arg1);
            this.data = _arg2;
        }
    }
}//package com.gaiaonline.monster.events 
