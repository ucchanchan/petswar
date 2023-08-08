//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.error {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import org.robotlegs.mvcs.*;

    public class MinorErrorReportCommand extends Command {

        public var event:MinorErrorEvent;
        public var text:TextService;

        override public function execute():void{
            var _local1:String = ("Minor Error: " + this.event.log);
            var _local2:DialogVO = new DialogVO(_local1, DialogVO.OK_ONLY);
            dispatch(new DialogEvent(DialogEvent.SHOW_DIALOG, _local2));
        }

    }
}//package com.gaiaonline.monster.controller.error 
