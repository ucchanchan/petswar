//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.lib.*;
    import org.robotlegs.mvcs.*;

    public class InvokeAnnouncementCommand extends Command {

        private const MIN_NODE_WON:int = 3;

        public var cookie:Cookie;
        public var event:AnnouncementEvent;
        public var story:StoryModel;
        public var worldModel:WorldModel;
        public var appModel:ApplicationModel;

        override public function execute():void{
            var _local5:String;
            var _local1:Array = this.appModel.oneTimeAnnouncements;
            var _local2:uint = _local1.length;
            var _local3:Vector.<Location> = this.worldModel.currentZone.locations;
            var _local4:int;
            while (_local4 < _local2) {
                _local5 = _local1[_local4];
                if (((!(this.cookie.getValue(_local5, 0))) && (_local3[this.MIN_NODE_WON].hasWon))){
                    this.story.id = _local5;
                    dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_NEW_ANNOUNCEMENT_STORY));
                    this.cookie.setValue(_local5, true);
                    break;
                };
                _local4++;
            };
        }

    }
}//package com.gaiaonline.monster.controller.application 
