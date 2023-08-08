//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class TrackingCommand extends Command {

		[Inject]
        public var event:TrackingEvent;
		[Inject]
        public var omniture:OmnitureService;
		[Inject]
        public var kontagent:KontagentService;

        override public function execute():void{
            this.omniture.track(this.event);
            this.kontagent.track(this.event);
        }

    }
}//package com.gaiaonline.monster.controller.application 
