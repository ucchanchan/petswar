//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.friendlist.model.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.view.components.home.*;
    import gaia.moga.assets.bundle.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.autoHarvester.view.*;
    import com.gaiaonline.monster.model.quests.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.view.components.starseedBasket.event.*;
    import com.gaiaonline.monster.controller.async.*;
    import gaia.moga.*;

    public class InvokeHomeCommand extends AsyncCommand {

		[Inject]
        public var bundle:HomeAssetsBundle;
		[Inject]
        public var travelHome:TravelHome;
		[Inject]
        public var questData:QuestDataProcess;
		[Inject]
        public var questModel:QuestModel;
		[Inject]
        public var whistleReportModel:WhistleReportModel;
		[Inject]
        public var player:PlayerModel;
		[Inject]
        public var home:HomeRanchModel;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var appModel:ApplicationModel;
		[Inject]
        public var asyncService:AsyncService;
		[Inject]
        public var friends:FriendsModel;
		[Inject]
        public var worldModel:WorldModel;
		[Inject]
        public var storyModel:StoryModel;

        private static const START_RANCH_HARVESTER:int = 3;

        override public function execute():void{
            var _local1:ParallelAsyncs = new ParallelAsyncs("InvokeHomeCommand-Parallel");
            _local1.add(this.questData);
            _local1.add(this.bundle);
            _local1.add(this.travelHome);
            hook(_local1, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local3:String;
            var _local4:Asset;
            var _local5:AutoHarvester;
            var _local2:Home = new Home(this.bundle, false);
            this.asyncService.push(new AsyncDispatchEvent(eventDispatcher, new PanelsEvent(PanelsEvent.SET_PANEL, _local2)));
            if (this.canShowHarvester()){
                _local4 = this.assets.autoHarvester();
                _local5 = new AutoHarvester(_local4);
                _local2.addAutoHarvester(_local5);
            };
            dispatch(new ApplicationEvent(ApplicationEvent.PUSH_QUEST_PANELS));
            if (((!(this.player.hasCompletedTutorial(PlayerModel.NAP))) || (!(this.player.hasCompletedTutorial(PlayerModel.WHISTLE))))){
                _local3 = ApplicationEvent.INVOKE_TUTORIAL;
            } else {
                if (this.whistleReportModel.friends.length > 0){
                    _local3 = ApplicationEvent.INVOKE_WHISTLE_REPORT;
                } else {
                    if (this.player.hasCompletedAllTutorials()){
                        _local3 = ApplicationEvent.INVOKE_DISPLAY_AD;
                    };
                };
            };
            if (_local3){
                this.asyncService.push(new AsyncDispatchEvent(eventDispatcher, new ApplicationEvent(_local3)));
            };
            if (this.appModel.showBasketPanel){
                dispatch(new StarseedBasketEvent(StarseedBasketEvent.OPEN_REQUESTOR_UI));
                this.appModel.showBasketPanel = false;
            };
            this.checkAnnouncement();
        }
        private function checkAnnouncement():void{
            var _local1:Vector.<Location> = this.worldModel.currentZone.locations;
            if (((((this.appModel.oneTimeAnnouncements) && ((this.questModel.newQuests.length == 0)))) && (_local1[10].hasWon))){
                dispatch(new AnnouncementEvent(AnnouncementEvent.SHOW_ANNOUNCEMENT));
            };
        }
        private function canShowHarvester():Boolean{
            var _local1:Vector.<Location> = this.worldModel.currentZone.locations;
            if ((((this.friends.whistleCount > 0)) && (_local1[START_RANCH_HARVESTER].hasWon))){
                return (true);
            };
            return (false);
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.UNABLE_TO_LOAD_HOME_ASSETS));
        }

    }
}//package com.gaiaonline.monster.controller.application 
