//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.dialog {
    import com.gaiaonline.monster.events.*;
    import org.robotlegs.mvcs.*;

    public class ProcessDialogCommand extends Command {

		[Inject]
        public var event:DialogInterimEvent;

        override public function execute():void{
            commandMap.mapEvent(DialogEvent.ACTION, this.event.commandClass);
            dispatch(new DialogEvent(DialogEvent.ACTION, this.event.data));
            commandMap.unmapEvent(DialogEvent.ACTION, this.event.commandClass);
        }

    }
}//package com.gaiaonline.monster.controller.dialog 
