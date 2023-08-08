//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.battle.action {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import org.robotlegs.mvcs.*;

    public class RunAwayCommand extends Command {

		[Inject]
        public var text:TextService;

        private static const RUN_AWAY_CONFIRM:String = "RUN_AWAY_CONFIRM";

        override public function execute():void{
            var _local1:String = this.text.getText(RUN_AWAY_CONFIRM);
            var _local2:DialogVO = new DialogVO(_local1, DialogVO.YES_NO);
            _local2.yes = RunAwayConfirmedCommand;
            _local2.no = RunAwayCancelledCommand;
            dispatch(new DialogEvent(DialogEvent.SHOW_DIALOG, _local2));
        }

    }
}//package com.gaiaonline.monster.controller.battle.action 
