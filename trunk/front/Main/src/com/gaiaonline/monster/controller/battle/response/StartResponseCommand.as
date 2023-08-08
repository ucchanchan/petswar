//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.response {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import com.gaiaonline.monster.model.battle.*;
    import org.robotlegs.mvcs.*;

    public class StartResponseCommand extends Command {

		[Inject]
        public var event:BattleResponseEvent;
		[Inject]
        public var model:BattleModel;
		[Inject]
        public var text:TextService;

        private static const UNABLE_TO_START_BATTLE:String = "UNABLE_TO_START_BATTLE";

        override public function execute():void{
            var _local4:DialogVO;
            var _local1:Object = this.event.data;
            var _local2:Object = _local1.battle_state;
            var _local3:Object = _local1.battle_result;
            if (_local3.error){
                _local4 = new DialogVO(this.text.getText(UNABLE_TO_START_BATTLE), DialogVO.OK_ONLY);
                _local4.ok = BattleStartFailedCommand;
                dispatch(new DialogEvent(DialogEvent.SHOW_DIALOG, _local4));
            };
            this.model.update(_local2);
            this.model.state = BattleState.INPUT;
        }

    }
}//package com.gaiaonline.monster.controller.battle.response 
