//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import flash.events.*;

    public class NPCTeamEvent extends Event {

        private var _data;

        public static const UPDATE_TEAM:String = "UPDATE_TEAM";
        public static const UPDATE_MONSTER:String = "UPDATE_MONSTER";

        public function NPCTeamEvent(_arg1:String, _arg2=null){
            super(_arg1);
            this._data = _arg2;
        }
        public function get data(){
            return (this._data);
        }

    }
}//package com.gaiaonline.monster.view 
