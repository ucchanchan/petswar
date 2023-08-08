//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.gsi {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.battle.*;
    import com.gaiaonline.monster.model.quests.*;
    import org.robotlegs.mvcs.*;

    public class HandleOneBattleResponseCommand extends Command {

		[Inject]
        public var event:BattleResponseEvent;
		[Inject]
        public var model:BattleModel;
		[Inject]
        public var roster:HomeRanchModel;
		[Inject]
        public var text:TextService;
		[Inject]
        public var quests:QuestModel;

        override public function execute():void{
            var _local1:Object = this.event.data;
            var _local2:BattleState = this.model.state;
            var _local3:Boolean = _local1.quests;
            if (_local3){
                this.quests.init(_local1.quests);
            };
            if (_local1.battle_result.estimates){
                this.model.updateMoveEstimates(_local1.battle_result.estimates);
            };
            switch (_local2){
                case BattleState.START_PENDING:
                    if (((_local1.battle_result) && (!((_local1.battle_result.npc_monster == null))))){
                        dispatch(new BattleResponseEvent(BattleResponseEvent.INITIAL_ATTACK, _local1));
                    } else {
                        dispatch(new BattleResponseEvent(BattleResponseEvent.START_BATTLE, _local1));
                    };
                    break;
                case BattleState.SET_FIRST_MONSTER:
                case BattleState.SET_FIRST_MONSTER_PENDING:
                    dispatch(new BattleResponseEvent(BattleResponseEvent.START_BATTLE, _local1));
                    break;
                case BattleState.CHOOSE_NEXT_MONSTER_PENDING:
                    dispatch(new BattleResponseEvent(BattleResponseEvent.CHOOSE_NEXT_MONSTER, _local1));
                    break;
                case BattleState.CAPTURE_MONSTER_PENDING:
                    dispatch(new BattleResponseEvent(BattleResponseEvent.CAPTURE_MONSTER, _local1));
                    break;
                case BattleState.SWAP_MONSTER_PENDING:
                    dispatch(new BattleResponseEvent(BattleResponseEvent.SWAP_MONSTER, _local1));
                    break;
                case BattleState.REQUEST_HELP_PENDING:
                    dispatch(new BattleResponseEvent(BattleResponseEvent.REQUEST_HELP, _local1));
                    break;
                case BattleState.ATTACK_PENDING:
                case BattleState.RUN_AWAY_PENDING:
                case BattleState.RECHARGE_MONSTER_PENDING:
                    dispatch(new BattleResponseEvent(BattleResponseEvent.PLAYER_MOVE, _local1));
                    break;
                default:
                    throw (new Error(("Unexpected battle state: " + _local2)));
            };
        }

    }
}//package com.gaiaonline.monster.controller.gsi 
