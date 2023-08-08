//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.swap {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;

    public class SwapUserConfirmedCommand extends Command {

		[Inject]
        public var event:DialogEvent;
		[Inject]
        public var model:BattleModel;
		[Inject]
        public var service:GSIDataService;

        override public function execute():void{
            var _local1:MonsterModel = this.event.data;
            var _local2:String = this.model.id;
            var _local3:String = _local1.id.toString();
            if (this.model.state == BattleState.CHOOSE_NEXT_MONSTER){
                this.model.state = BattleState.CHOOSE_NEXT_MONSTER_PENDING;
            } else {
                this.model.state = BattleState.SWAP_MONSTER_PENDING;
            };
            this.model.playerMonster = _local1;
            this.service.tapOut(_local2, _local3);
        }

    }
}//package com.gaiaonline.monster.controller.battle.swap 
