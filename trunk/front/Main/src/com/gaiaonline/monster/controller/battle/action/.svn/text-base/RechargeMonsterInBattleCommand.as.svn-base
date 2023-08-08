//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.action {
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.battle.*;
    import com.gaiaonline.monster.controller.team.*;

    public class RechargeMonsterInBattleCommand extends RechargeMonsterConfirmedCommand {

		[Inject]
        public var model:BattleModel;
        private var priorState:BattleState;

        override public function execute():void{
            this.priorState = this.model.state;
            this.model.state = BattleState.RECHARGE_MONSTER_PENDING;
            super.execute();
        }
        override protected function onComplete(_arg1:Async):void{
            super.onComplete(_arg1);
            if (((this.model.playerMonster) && ((target.id == this.model.playerMonster.id)))){
                dispatch(new FightEvent(FightEvent.RECHARGE_MONSTER));
            };
            this.model.state = this.priorState;
        }
        override protected function onError(_arg1:Async, _arg2:String=""):void{
            super.onError(_arg1, _arg2);
            this.model.state = this.priorState;
        }

    }
}//package com.gaiaonline.monster.controller.battle.action 
