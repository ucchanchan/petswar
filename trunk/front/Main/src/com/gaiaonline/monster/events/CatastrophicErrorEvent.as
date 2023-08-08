//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.events {
    import flash.events.*;

    public class CatastrophicErrorEvent extends Event {

        public var id:uint;

        public static const ERROR:String = "CatastrophicErrorEvent.ERROR";

        public function CatastrophicErrorEvent(_arg1:String, _arg2:uint){
            super(_arg1);
            this.id = _arg2;
        }
    }
}//package com.gaiaonline.monster.events 
