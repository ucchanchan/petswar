//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service {
    import flash.events.*;

    public class GSIResponseEvent extends Event {

        private var _data:Object;

        public static const GET_USER_DATA_RESPONSE:String = "GSIResponseEvent.GET_USER_DATA_RESPONSE";
        public static const GET_WORLD_DATA_RESPONSE:String = "GSIResponseEvent.GET_WORLD_DATA_RESPONSE";
        public static const TRAVEL_TO_LOCATION_RESPONSE:String = "GSIResponseEvent.TRAVEL_TO_LOCATION_RESPONSE";
        public static const GET_STORE_RESPONSE:String = "GSIResponseEvent.GET_STORE_RESPONSE";
        public static const HANDLE_BATTLE_RESPONSE:String = "GSIResponseEvent.HANDLE_BATTLE_RESPONSE";
        public static const HANDLE_USER_ACTION_RESPONSE:String = "GSIResponseEvent.HANDLE_USER_ACTION_RESPONSE";
        public static const HANDLE_MONSTER_ACTION_RESPONSE:String = "GSIResponseEvent.HANDLE_MONSTER_ACTION_RESPONSE";
        public static const INIT_USER_ACTION_RESPONSE:String = "GSIResponseEvent.INIT_USER_ACTION_RESPONSE";
        public static const GET_MONSTER_DEX_RESPONSE:String = "GSIResponseEvent.GET_MONSTER_DEX_RESPONSE";
        public static const MAKE_PURCHASE_RESPONSE:String = "GSIResponseEvent.MAKE_PURCHASE_RESPONSE";
        public static const GET_UGCEVENT_RESPONSE:String = "GSIResponseEvent.GET_UGCEVENT_RESPONSE";
        public static const CREATE_UGCEVENT_RESPONSE:String = "GSIResponseEvent.CREATE_UGCEVENT_RESPONSE";
        public static const ATTEND_UGCEVENT_RESPONSE:String = "GSIResponseEvent.ATTEND_UGCEVENT_RESPONSE";

        public function GSIResponseEvent(_arg1:String, _arg2:Object){
            this._data = _arg2;
            super(_arg1);
        }
        public function get data():Object{
            return (this._data);
        }

    }
}//package com.gaiaonline.monster.service 
