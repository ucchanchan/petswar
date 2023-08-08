//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class WhistleTreeReminderCommand extends Command {

        public var event:HomeEvent;
        public var text:TextService;
        public var fb:FBService;

        override public function execute():void{
            var _local1:String = String(this.event.data.friendName);
            var _local2:String = String(this.event.data.friendId);
            var _local3:Object = {};
            _local3.popupTitle = (("Remind " + _local1) + " to water their tree");
            _local3.friendId = _local2;
            this.fb.showWhistleTreeReminderPopup(_local3);
        }

    }
}//package com.gaiaonline.monster.controller.application 
