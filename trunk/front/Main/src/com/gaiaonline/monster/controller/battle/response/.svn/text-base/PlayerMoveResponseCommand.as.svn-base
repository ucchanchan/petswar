//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.response {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.collections.model.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;
    import gaia.moga.*;

    public class PlayerMoveResponseCommand extends Command {

		[Inject]
        public var event:BattleResponseEvent;
		[Inject]
        public var model:BattleModel;
		[Inject]
        public var collectionModel:MogaCollectionsModel;
		[Inject]
        public var text:TextService;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var roster:HomeRanchModel;

        override public function execute():void{
            var _local1:Object = this.event.data;
            var _local2:Object = _local1.battle_result;
            var _local3:Object = _local1.battle_state;
            if (((!((_local2.error == null))) || ((_local3 == null)))){
                dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.SERVER_REPORTED_ERROR_OR_DIDNT_REPORT_BATTLE_STATE_AFTER_A_PLAYER_MOVE));
                return;
            };
            var _local4:MonsterModel = this.model.playerMonster;
            var _local5:MonsterModel = this.model.npcMonster;
            if (((_local2.collection_props) && (_local2.collection_inventory))){
                this.collectionModel.initDropData(_local2.collection_props, _local2.collection_inventory);
            };
            this.model.update(_local3);
            this.model.attack = new AttackResponseVO(_local2, _local4, _local5, this.roster.team);
            switch (this.model.state){
                case BattleState.ATTACK_PENDING:
                    this.playerAttacks();
                    break;
                case BattleState.RUN_AWAY_PENDING:
                    if (this.playerRunsAway()){
                        return;
                    };
                    break;
                case BattleState.RECHARGE_MONSTER_PENDING:
                    this.playerRecharges();
                    break;
            };
            dispatch(new FightEvent(FightEvent.ATTACK_RESPONSE));
        }
        private function playerAttacks():void{
            dispatch(new FightEvent(FightEvent.PLAYER_ATTACK));
        }
        private function playerRunsAway():Boolean{
            var _local1:Object = this.event.data;
            var _local2:Boolean = ((_local1.battle_result.user_monster) && ((_local1.battle_result.user_monster.ran_away == 1)));
            if (_local2){
                dispatch(new FightEvent(FightEvent.RUN_AWAY));
            } else {
                dispatch(new FightEvent(FightEvent.RUN_AWAY_FAILED));
            };
            return (_local2);
        }
        private function playerRecharges():void{
            dispatch(new FightEvent(FightEvent.RECHARGE_MONSTER));
        }

    }
}//package com.gaiaonline.monster.controller.battle.response 
