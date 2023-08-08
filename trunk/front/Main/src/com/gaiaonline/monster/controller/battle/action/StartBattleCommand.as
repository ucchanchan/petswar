//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.action {
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;

    public class StartBattleCommand extends Command {

		[Inject]
        public var battle:BattleModel;
		[Inject]
        public var server:GSIDataService;

        override public function execute():void{
            var _local1:String = this.battle.id;
            var _local2:String = this.battle.playerMonster.id;
            this.server.startBattle(_local1, _local2);
            this.battle.state = BattleState.START_PENDING;
        }

    }
}//package com.gaiaonline.monster.controller.battle.action 
