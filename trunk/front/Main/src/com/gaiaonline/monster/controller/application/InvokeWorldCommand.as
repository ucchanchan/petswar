//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.view.components.starseedBasket.service.*;
    import gaia.moga.assets.bundle.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.components.world.*;
    import com.gaiaonline.monster.model.quests.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.view.components.starseedBasket.event.*;
    import com.gaiaonline.monster.controller.async.*;

    public class InvokeWorldCommand extends AsyncCommand {

		[Inject]
        public var app:ApplicationModel;
		[Inject]
        public var bundle:WorldAssetsBundle;
		[Inject]
        public var updateUserData:UpdateUserData;
		[Inject]
        public var model:WorldModel;
		[Inject]
        public var questData:QuestDataProcess;
		[Inject]
        public var questModel:QuestModel;
		[Inject]
        public var whistleReportModel:WhistleReportModel;
		[Inject]
        public var asyncService:AsyncService;
		[Inject]
        public var getBasketData:GetFriendBasketData;

        override public function execute():void{
            var _local1:ParallelAsyncs = new ParallelAsyncs("InvokeWorldCommandParallel");
            if (this.app.showBasketPanel){
                this.getBasketData.friendID = this.app.friendRanchID;
                _local1.add(this.getBasketData);
            };
            _local1.add(this.updateUserData);
            var _local2:AsyncStack = new AsyncStack("InvokeWorldCommandSubStack");
            _local2.push(this.questData);
            _local2.push(this.bundle);
            _local1.add(_local2);
            hook(_local1, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local3:Boolean;
            var _local2:World2D = new World2D(this.bundle);
            _local2.locations = this.model.currentZone.locations;
            dispatch(new ApplicationEvent(ApplicationEvent.PUSH_QUEST_PANELS));
            this.asyncService.push(new AsyncDispatchEvent(eventDispatcher, new PanelsEvent(PanelsEvent.SET_PANEL, _local2)));
            if (this.whistleReportModel.friends.length > 0){
                this.asyncService.push(new AsyncDispatchEvent(eventDispatcher, new ApplicationEvent(ApplicationEvent.INVOKE_WHISTLE_REPORT)));
            };
            this.asyncService.push(new AsyncDispatchEvent(eventDispatcher, new ApplicationEvent(ApplicationEvent.INVOKE_DISPLAY_AD)));
            if (this.app.showBasketPanel){
                _local3 = (this.app.friendRanchID == this.app.userID);
                dispatch(new StarseedBasketEvent((_local3) ? StarseedBasketEvent.OPEN_REQUESTOR_UI : StarseedBasketEvent.OPEN_GIVER_UI));
                this.app.showBasketPanel = false;
            };
            this.checkAnnouncement();
        }
        private function checkAnnouncement():void{
            var _local1:Vector.<Location> = this.model.currentZone.locations;
            if (((((this.app.oneTimeAnnouncements) && ((this.questModel.newQuests.length == 0)))) && (_local1[10].hasWon))){
                dispatch(new AnnouncementEvent(AnnouncementEvent.SHOW_ANNOUNCEMENT));
            };
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 138));
        }

    }
}//package com.gaiaonline.monster.controller.application 
