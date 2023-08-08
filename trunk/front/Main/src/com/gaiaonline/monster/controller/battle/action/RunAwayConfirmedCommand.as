//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.action {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;

    public class RunAwayConfirmedCommand extends Command {

		[Inject]
        public var gateway:GSIDataService;
		[Inject]
        public var model:BattleModel;

        override public function execute():void{
            var _local1:MonsterModel = this.model.playerMonster;
            this.model.state = BattleState.RUN_AWAY_PENDING;
            this.gateway.runAway(this.model.id, _local1.id);
        }

    }
}//package com.gaiaonline.monster.controller.battle.action 
