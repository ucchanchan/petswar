//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.team {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import org.robotlegs.mvcs.*;

    public class AwakenMonsterCommand extends Command {

		[Inject]
        public var event:TeamEvent;
		[Inject]
        public var text:TextService;

        private static const AWAKEN_CONFIRM:String = "AWAKEN_CONFIRM";

        override public function execute():void{
            var _local1:MonsterModel = this.event.data;
            var _local2:String = this.text.getText(AWAKEN_CONFIRM);
            var _local3:DialogVO = new DialogVO(_local2, DialogVO.YES_NO);
            _local3.yes = AwakenMonsterConfirmedCommand;
            _local3.no = AwakenMonsterCancelledCommand;
            _local3.data = {target:_local1};
            dispatch(new DialogEvent(DialogEvent.SHOW_DIALOG, _local3));
        }

    }
}//package com.gaiaonline.monster.controller.team 
