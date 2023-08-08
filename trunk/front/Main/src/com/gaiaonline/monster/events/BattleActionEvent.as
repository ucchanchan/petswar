//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.events {
    import flash.events.*;

    public class BattleActionEvent extends Event {

        private var _data;

        public static const START_BATTLE:String = "BattleActionEvent.START_BATTLE";
        public static const ATTACK:String = "BattleActionEvent.ATTACK";
        public static const USE_WHISTLE:String = "BattleActionEvent.USE_WHISTLE";
        public static const RUN_AWAY:String = "BattleActionEvent.RUN_AWAY";
        public static const TRY_TO_CAPTURE:String = "BattleActionEvent.TRY_TO_CAPTURE";
        public static const COMPLETE_ROUND:String = "BattleActionEvent.COMPLETE_ROUND";

        public function BattleActionEvent(_arg1:String, _arg2=null){
            this._data = _arg2;
            super(_arg1);
        }
        public function get data(){
            return (this._data);
        }

    }
}//package com.gaiaonline.monster.events 
