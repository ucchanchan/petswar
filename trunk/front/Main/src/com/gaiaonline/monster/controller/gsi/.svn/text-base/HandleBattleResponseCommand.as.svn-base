//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.gsi {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;

    public class HandleBattleResponseCommand extends Command {

		[Inject]
        public var event:GSIResponseEvent;
		[Inject]
        public var responses:BattleResponsesModel;

        override public function execute():void{
            var _local1:Object = this.event.data;
            this.responses.init(_local1);
            var _local2:Object = this.responses.responses.shift();
            dispatch(new BattleResponseEvent(BattleResponseEvent.HANDLE_ONE_BATTLE_RESPONSE, _local2));
        }

    }
}//package com.gaiaonline.monster.controller.gsi 
