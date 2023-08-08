//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.error {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import org.robotlegs.mvcs.*;

    public class BattleTimeoutErrorReportCommand extends Command {

        public var text:TextService;

        private static const BATTLE_TIMEOUT_ERROR:String = "BATTLE_TIMEOUT_ERROR";

        override public function execute():void{
            var _local1:DialogVO = new DialogVO(this.text.getText(BATTLE_TIMEOUT_ERROR), DialogVO.OK_ONLY);
            _local1.ok = BattleTimeoutErrorNotedCommand;
            dispatch(new DialogEvent(DialogEvent.SHOW_DIALOG, _local1));
        }

    }
}//package com.gaiaonline.monster.controller.error 
