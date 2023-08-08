//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process.battle {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.battle.*;
    import com.gaiaonline.monster.model.quests.*;

    public class RetrieveBattle extends GSIProcess {

        public var app:ApplicationModel;
        public var ranch:HomeRanchModel;
        public var battle:BattleModel;
        public var server:GSIDataService;
        public var player:PlayerModel;
        public var quests:QuestModel;
        public var mogas:MogaFactory;

        private static const START_BATTLE_TO_BEGIN:String = "Start battle to begin";

        public function RetrieveBattle(){
            super("RetrieveBattle");
        }
        override protected function onInit():void{
            this.server.retrieveStatus(this, this.app.openBattleID);
        }
        override protected function parse(_arg1:Object):Boolean{
            var _local6:MonsterModel;
            _arg1 = _arg1[0];
            if (((((!(_arg1)) || (!(_arg1.battle_result)))) || (!((_arg1.battle_result.error == null))))){
                return (false);
            };
            var _local2:Object = _arg1.battle_state;
            var _local3:Object = _arg1.battle_result;
            var _local4 = (_local3.success == START_BATTLE_TO_BEGIN);
            var _local5:Boolean = _arg1.quests;
            if (_local5){
                this.quests.init(_arg1.quests);
            };
            if (_local4){
                this.battle.isRetrievedBattle = false;
                this.battle.init(_local2, _local3.npc, _local3.estimates);
                if (this.app.assumeFirstMonsterEntersBattle){
                    this.battle.playerMonster = this.ranch.team.firstEligibleMonster;
                };
                this.battle.state = BattleState.BEFORE_BATTLE_HAS_STARTED;
            } else {
                this.updateMonsterData(_local2);
                _local6 = this.mogas.read(_local3.user_monster.id);
                this.battle.init(_local2, _local3.npc, _local3.estimates);
                this.battle.hasStarted = true;
                this.battle.playerMonster = _local6;
                this.battle.isRetrievedBattle = true;
                this.battle.state = (_local6) ? BattleState.INPUT : BattleState.CHOOSE_NEXT_MONSTER;
            };
            return (true);
        }
        private function updateMonsterData(_arg1:Object):void{
            var _local3:Object;
            var _local2:Array = _arg1.user_monster_roster;
            for each (_local3 in _local2) {
                this.mogas.update(_local3);
            };
        }

    }
}//package com.gaiaonline.monster.service.process.battle 
