//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.team {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import org.robotlegs.mvcs.*;

    public class EmptyTeamMessageCommand extends Command {

        public var text:TextService;

        private static const EMPTY_TEAM_MESSAGE:String = "EMPTY_TEAM_MESSAGE";

        override public function execute():void{
            var _local1:String = this.text.getText(EMPTY_TEAM_MESSAGE);
            var _local2:DialogVO = new DialogVO(_local1, DialogVO.OK_ONLY);
            dispatch(new DialogEvent(DialogEvent.SHOW_DIALOG, _local2));
        }

    }
}//package com.gaiaonline.monster.controller.team 
