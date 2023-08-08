//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import org.robotlegs.mvcs.*;

    public class SetApplicationStateCommand extends Command {

		[Inject]
        public var event:ApplicationEvent;
		[Inject]
        public var model:ApplicationModel;

        override public function execute():void{
            this.model.state = this.event.state;
        }

    }
}//package com.gaiaonline.monster.controller.application 
