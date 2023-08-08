//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.action {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.monster.model.actions.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;

    public class AttackActionCommand extends Command {

		[Inject]
        public var event:BattleActionEvent;
		[Inject]
        public var model:BattleModel;
		[Inject]
        public var gateway:GSIDataService;

        override public function execute():void{
            this.model.state = BattleState.ATTACK_PENDING;
            var _local1:String = this.model.id;
            var _local2:Action = this.event.data;
            var _local3:MonsterModel = this.model.playerMonster;
            switch (_local2.type){
                case ActionType.PHYSICAL:
                case ActionType.ZODIAC:
                case ActionType.BUFF:
                case ActionType.DEBUFF:
                    this.gateway.attack(_local1, _local3.id, _local2.id);
                    break;
                default:
                    throw (new Error("MoveType not yet supported in AttackActionCommand"));
            };
            dispatch(new FightEvent(FightEvent.INITIATE_PLAYER_ATTACK, _local2.id));
        }

    }
}//package com.gaiaonline.monster.controller.battle.action 
