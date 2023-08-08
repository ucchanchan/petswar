﻿//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.feed {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.friendlist.model.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import org.robotlegs.mvcs.*;

    public class PostLevelUpToStreamCommand extends Command {

		[Inject]
        public var event:PostToStreamEvent;
		[Inject]
        public var fb:FBService;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var text:TextService;
		[Inject]
        public var friendsModel:FriendsModel;
		[Inject]
        public var timer:TimerService;

        override public function execute():void{
            var _local1:FeedStoryVO = this.event.data;
            var _local2:String = this.assets.levelupIconString(_local1.id, _local1.level);
            var _local3:String = this.text.getLevelUpFeedMainMessage(_local1.name, _local1.id, this.friendsModel.me.firstName);
            var _local4:String = this.text.getLevelUpFeedSecondaryMessage(_local1.name, _local1.id, _local1.level, this.friendsModel.me.firstName);
            var _local5:CreateUGCEventVO = new CreateUGCEventVO();
            _local5.timestamp = String(this.timer.currentTime);
            _local5.eventId = UGCEventType.OPEN_WHISTLE;
            dispatch(new UGCEvent(UGCEvent.CREATE_EVENT, _local5));
            this.fb.publishLevelUp(_local2, _local1.id, _local1.name, _local3, _local4, _local5, _local1.instanceId, _local1.level);
        }

    }
}//package com.gaiaonline.monster.controller.feed 
