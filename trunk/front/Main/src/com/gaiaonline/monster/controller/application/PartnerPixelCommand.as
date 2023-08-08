//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class PartnerPixelCommand extends Command {

		[Inject]
        public var event:TrackingEvent;
		[Inject]
        public var service:PartnerPixelService;

        override public function execute():void{
            this.service.track(this.event);
        }

    }
}//package com.gaiaonline.monster.controller.application 
