//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.error {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.dialog.vo.*;
    import org.robotlegs.mvcs.*;

    public class CatastrophicErrorReportCommand extends Command {

		[Inject]
        public var event:CatastrophicErrorEvent;
		[Inject]
        public var text:TextService;
		[Inject]
        public var data:GSIDataService;

        private static const CATASTROPHIC_ERROR:String = "CATASTROPHIC_ERROR";

        override public function execute():void{
            var _local1 = (((this.text.getText(CATASTROPHIC_ERROR) + " (") + this.event.id) + ")");
            var _local2:DialogVO = new DialogVO(_local1, DialogVO.OK_ONLY);
            _local2.ok = CatastrophicErrorNotedCommand;
            dispatch(new DialogEvent(DialogEvent.SHOW_DIALOG, _local2));
            dispatch(new ApplicationEvent(ApplicationEvent.NOT_LOADING));
            dispatch(new TrackingEvent(TrackingEvent.TRACK, ("moga_error_" + this.event.id)));
        }

    }
}//package com.gaiaonline.monster.controller.error 
