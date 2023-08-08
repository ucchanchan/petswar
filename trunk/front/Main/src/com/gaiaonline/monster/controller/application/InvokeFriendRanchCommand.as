//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.friendlist.view.ui.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.view.components.home.*;
    import gaia.moga.assets.bundle.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.model.quests.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.view.components.starseedBasket.event.*;

    public class InvokeFriendRanchCommand extends AsyncCommand {

		[Inject]
        public var bundle:HomeAssetsBundle;
		[Inject]
        public var travelToFriend:TravelToFriend;
		[Inject]
        public var questData:QuestDataProcess;
		[Inject]
        public var questModel:QuestModel;
		[Inject]
        public var text:TextService;
		[Inject]
        public var friendRanch:FriendRanchModel;
		[Inject]
        public var appModel:ApplicationModel;

        private static const UNABLE_TO_LAUNCH_HOME:String = "UNABLE_TO_LAUNCH_HOME";

        override public function execute():void{
            var _local1:ParallelAsyncs = new ParallelAsyncs("InvokeFriendRanch-Parallel");
            if (!this.questModel.isInitialized){
                _local1.add(this.questData);
            };
            _local1.add(this.bundle);
            _local1.add(this.travelToFriend);
            hook(_local1, this.onComplete, this.onError);
        }
        protected function onComplete(_arg1:Async):void{
            var _local2:FriendList = this.bundle.friends;
            _local2.isSelected = this.friendRanch.friendID;
            var _local3:Home = new Home(this.bundle, true);
            dispatch(new PanelsEvent(PanelsEvent.SET_PANEL, _local3));
            if (this.appModel.showBasketPanel){
                dispatch(new StarseedBasketEvent(StarseedBasketEvent.OPEN_GIVER_UI));
                this.appModel.showBasketPanel = false;
            };
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            _arg2 = this.text.getText(UNABLE_TO_LAUNCH_HOME);
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 101));
        }

    }
}//package com.gaiaonline.monster.controller.application 
