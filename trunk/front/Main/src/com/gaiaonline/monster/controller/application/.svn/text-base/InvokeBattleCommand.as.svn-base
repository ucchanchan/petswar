//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.process.*;
    import com.gaiaonline.monster.view.components.starseedBasket.service.*;
    import com.gaiaonline.monster.view.components.whistleReport.*;
    import gaia.moga.assets.bundle.*;
    import com.gaiaonline.monster.view.components.battle.ui.*;
    import gaia.lib.*;
    import com.gaiaonline.monster.model.battle.*;
    import com.gaiaonline.monster.controller.*;
    import com.gaiaonline.monster.view.components.starseedBasket.event.*;

    public class InvokeBattleCommand extends AsyncCommand {

		[Inject]
        public var app:ApplicationModel;
		[Inject]
        public var bundle:BattleAssetsBundle;
		[Inject]
        public var model:BattleModel;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var questData:QuestDataProcess;
		[Inject]
        public var whistleReportModel:WhistleReportModel;
		[Inject]
        public var getBasketData:GetFriendBasketData;
		[Inject]
        public var cookie:Cookie;

        override public function execute():void{
            var _local2:MonsterModel;
            this.checkForButtBattle();
            if (!this.app.openBattleID){
                _local2 = this.ranch.team.firstEligibleMonster;
                if (!_local2){
                    this.unableToStartBattle();
                    return;
                };
                if (this.app.assumeFirstMonsterEntersBattle){
                    this.model.playerMonster = _local2;
                };
            };
            this.app.openBattleID = null;
            var _local1:ParallelAsyncs = new ParallelAsyncs("InvokeBattleCommandParallel");
            if (((this.app.showBasketPanel) && (!((this.app.friendRanchID == this.app.userID))))){
                this.getBasketData.friendID = this.app.friendRanchID;
                _local1.add(this.getBasketData);
            };
            _local1.add(this.bundle);
            _local1.add(this.questData);
            hook(_local1, this.onComplete, this.onError);
        }
        private function checkForButtBattle():void{
            var _local1:String;
            var _local2:Number;
            this.model.isButtBattle = false;
            if (this.app.hasSpecial(ApplicationModel.BUTT_FIGHT)){
                _local1 = this.cookie.getValue("aprilFooled");
                _local2 = Math.random();
                if (((!((_local1 == this.model.id))) && (((!(_local1)) || ((_local2 < 0.3)))))){
                    this.cookie.setValue("aprilFooled", this.model.id);
                    this.model.isButtBattle = true;
                };
            };
        }
        private function unableToStartBattle():void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 139));
        }
        private function onComplete(_arg1:Async):void{
            var _local3:Boolean;
            var _local2:Battle = new Battle(this.bundle);
            dispatch(new PanelsEvent(PanelsEvent.SET_PANEL, _local2));
            if (this.whistleReportModel.friends.length > 0){
                eventDispatcher.addEventListener(PanelsEvent.REMOVE_OVERLAY, this.onOverlayComplete);
                dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_WHISTLE_REPORT));
            };
            if (this.app.showBasketPanel){
                _local3 = (this.app.friendRanchID == this.app.userID);
                dispatch(new StarseedBasketEvent((_local3) ? StarseedBasketEvent.OPEN_REQUESTOR_UI : StarseedBasketEvent.OPEN_GIVER_UI));
                this.app.showBasketPanel = false;
            };
        }
        private function onOverlayComplete(_arg1:PanelsEvent):void{
            if ((_arg1.panel is WhistleReport)){
                eventDispatcher.removeEventListener(PanelsEvent.REMOVE_OVERLAY, this.onOverlayComplete);
            };
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, 141));
        }

    }
}//package com.gaiaonline.monster.controller.application 
