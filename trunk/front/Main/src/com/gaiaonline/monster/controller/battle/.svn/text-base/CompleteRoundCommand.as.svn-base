//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;

    public class CompleteRoundCommand extends Command {

		[Inject]
        public var event:BattleActionEvent;
		[Inject]
        public var responses:BattleResponsesModel;

        override public function execute():void{
            var _local1:Object = this.responses.responses.shift();
            if (_local1){
                dispatch(new BattleResponseEvent(BattleResponseEvent.HANDLE_ONE_BATTLE_RESPONSE, _local1));
            } else {
                dispatch(new FightEvent(FightEvent.ROUND_COMPLETE));
            };
        }

    }
}//package com.gaiaonline.monster.controller.battle 
