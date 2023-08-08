//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.response {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.view.components.battle.vo.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;

    public class InitialAttackResponseCommand extends Command {

		[Inject]
        public var event:BattleResponseEvent;
		[Inject]
        public var model:BattleModel;
		[Inject]
        public var roster:HomeRanchModel;

        override public function execute():void{
            var _local1:Object = this.event.data;
            var _local2:Object = _local1.battle_state;
            var _local3:Object = _local1.battle_result;
            if (((!((_local3.error == null))) || ((_local2 == null)))){
                dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 134));
                return;
            };
            var _local4:MonsterModel = this.model.playerMonster;
            var _local5:MonsterModel = this.model.npcMonster;
            this.model.update(_local2);
            this.model.attack = new AttackResponseVO(_local3, _local4, _local5, this.roster.team);
            dispatch(new FightEvent(FightEvent.NPC_INITIAL_ATTACK));
        }

    }
}//package com.gaiaonline.monster.controller.battle.response 
