//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.ugcEvent {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class CreateUGCEventCommand extends Command {

		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var event:UGCEvent;

        override public function execute():void{
            var _local1:CreateUGCEventVO = CreateUGCEventVO(this.event.data);
            this.server.createEvent(_local1.eventId, _local1.timestamp, _local1.invitees);
        }

    }
}//package com.gaiaonline.monster.controller.ugcEvent 
