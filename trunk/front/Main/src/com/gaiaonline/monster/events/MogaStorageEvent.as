//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.events {
    import flash.events.*;

    public class MogaStorageEvent extends Event {

        public var data:Object;

        public static const CLOSE_STORAGE:String = "MogaStorageEvent.CLOSE_STORAGE";
        public static const UPDATE:String = "MogaStorageEvent.UPDATE";
        public static const ADD_DRAG_MONSTER:String = "MogaStorageEvent.ADD_DRAG_MONSTER";
        public static const MONSTER_STORAGE_DROP:String = "MogaStorageEvent.MONSTER_STORAGE_DROP";
        public static const STORAGE_CELL_DRAG:String = "MogaStorageEvent.STORAGE_CELL_DRAG";
        public static const STORE_TEAM_MONSTER:String = "MogaStorageEvent.STORE_TEAM_MONSTER";
        public static const SET_MONSTER_STORE_STATE:String = "MogaStorageEvent.SET_MONSTER_STORE_STATE";

        public function MogaStorageEvent(_arg1:String, _arg2:Object=null){
            super(_arg1);
            this.data = _arg2;
        }
        override public function clone():Event{
            var _local1:MogaStorageEvent = new MogaStorageEvent(type, this.data);
            return (_local1);
        }

    }
}//package com.gaiaonline.monster.events 
