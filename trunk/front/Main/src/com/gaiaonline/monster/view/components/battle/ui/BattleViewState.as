//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {

    public class BattleViewState {

        private var _debug:String;

        public static const BEFORE_BATTLE_STARTS:BattleViewState = new BattleViewState("before battle starts");
;
        public static const PENDING:BattleViewState = new BattleViewState("pending");
;
        public static const CHOOSE_NEXT_MONSTER:BattleViewState = new BattleViewState("choose next monster");
;
        public static const BLANK:BattleViewState = new BattleViewState("blank");
;
        public static const PLAYER_TURN:BattleViewState = new BattleViewState("player turn");
;
        public static const PLAYER_ANIM:BattleViewState = new BattleViewState("player anim");
;
        public static const ENEMY_TURN:BattleViewState = new BattleViewState("enemy turn");
;

        public function BattleViewState(_arg1:String){
            this._debug = _arg1;
        }
        public function toString():String{
            return (this._debug);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
