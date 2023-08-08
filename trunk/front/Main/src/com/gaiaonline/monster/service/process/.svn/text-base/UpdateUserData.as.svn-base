//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.model.world.*;
    import com.gaiaonline.monster.view.components.starseedBasket.model.*;
    import com.gaiaonline.monster.model.zodiac.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.lib.*;
    import com.gaiaonline.monster.model.quests.*;

    public class UpdateUserData extends GSIProcess {

        public var isNewUser:Boolean;
		[Inject]
        public var player:PlayerModel;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var basketModel:StarseedBasketModel;
		[Inject]
        public var application:ApplicationModel;
		[Inject]
        public var timer:TimerService;
		[Inject]
        public var zodiacs:ZodiacModel;
		[Inject]
        public var world:WorldModel;
		[Inject]
        public var settings:SettingsModel;
		[Inject]
        public var recurringPrize:RecurringPrizeModel;
		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var whistleReportModel:WhistleReportModel;
		[Inject]
        public var cookie:Cookie;
		[Inject]
        public var videoAdModel:VideoAdModel;
		[Inject]
        public var quests:QuestModel;

        private static const ERR_NO_SUCH_USER:int = 1;
        private static const COLLECTION_ITEM_TYPE:int = 7;

        public function UpdateUserData(){
            super("UpdateUserData");
        }
        override protected function onInit():void{
            this.server.getUserData(this);
        }
        override protected function parse(_arg1:Object):Boolean{
            this.isNewUser = ((!((_arg1.error == null))) && ((_arg1.error_code == ERR_NO_SUCH_USER)));
            if (this.isNewUser){
                return (true);
            };
            this.application.currentTime = _arg1.time_now;
            this.timer.init(this.application.currentTime);
            this.updateInventory(_arg1.inventory);
            this.updatePlayer(_arg1.user);
            this.ranch.update(_arg1.ranch);
            this.zodiacs.init(_arg1.zodiacs);
            this.videoAdModel.init(_arg1.orders);
            this.settings.update(_arg1.user.preferences);
            this.recurringPrize.update(_arg1.recurring_grants);
            this.basketModel.init(_arg1.seed_basket);
            this.world.openZones = _arg1.open_zones;
            if (_arg1.whistle_level_up){
                _arg1.whistle_assists.whistle_level_up = _arg1.whistle_level_up;
            };
            this.whistleReportModel.update(_arg1.whistle_assists);
            this.setCurrentLocation(_arg1.user.current_location);
            this.updateWorldVisitHistory(_arg1.location_log);
            this.updateWorldVictoryHistory(_arg1.battle_log);
            this.onQuestsUpdated();
            return (true);
        }
        private function updateInventory(_arg1:Object):void{
            var _local2:String;
            var _local3:uint;
            var _local4:Object;
            var _local5:int;
            var _local6:uint;
            var _local7:InventoryItem;
            for (_local2 in _arg1) {
                _local3 = uint(_local2);
                _local4 = _arg1[_local2];
                _local5 = int(_local4.props.type);
                if (_local5 != COLLECTION_ITEM_TYPE){
                    _local6 = _local4.quantity;
                    _local7 = this.inventory.getItem(_local3);
                    _local7.quantity = _local6;
                    if (_local7.type == null){
                    };
                };
            };
        }
        private function updatePlayer(_arg1:Object):void{
            var _local2:String;
            this.player.id = _arg1.user_id;
            this.player.basicCurrency = _arg1.basic_currency;
            this.player.premiumCurrency = _arg1.premium_currency;
            this.player.zodiac = _arg1.zodiac;
            this.player.hasShared = _arg1.has_shared;
            _arg1 = _arg1.completed_tutorials;
            for (_local2 in _arg1) {
                this.player.completeTutorial(_local2);
            };
        }
        private function updateWorldVisitHistory(_arg1:Object):void{
            var _local2:Array;
            var _local3:int;
            var _local4:Location;
            for each (_local2 in _arg1) {
                _local3 = _local2.length;
                while (_local3--) {
                    _local4 = this.world.getLocation(_local2[_local3]);
                    _local4.hasVisited = true;
                };
            };
        }
        private function updateWorldVictoryHistory(_arg1:Object):void{
            var _local2:Array;
            var _local3:int;
            var _local4:Location;
            for each (_local2 in _arg1) {
                _local3 = _local2.length;
                while (_local3--) {
                    _local4 = this.world.getLocation(_local2[_local3]);
                    _local4.hasWon = true;
                };
            };
        }
        private function setCurrentLocation(_arg1:uint):void{
            var _local2:Location = this.world.getLocation(_arg1);
            this.world.currentLocation = _local2;
        }
        public function onQuestsUpdated():void{
            var _local1:Location;
            var _local2:Vector.<QuestVO>;
            var _local3:QuestVO;
            var _local4:QuestVO;
            for each (_local1 in this.world.getAllLocations()) {
                if (((_local1.requiredQuests) && ((_local1.requiredQuests.length > 0)))){
                    _local2 = new Vector.<QuestVO>();
                    for each (_local3 in _local1.requiredQuests) {
                        _local4 = this.quests.getQuestById(_local3.id);
                        if (!_local4){
                            _local4 = new QuestVO();
                            _local4.isComplete = false;
                            _local4.id = _local3.id;
                        };
                        _local2.push(_local4);
                    };
                    _local1.requiredQuests = _local2;
                };
            };
        }

    }
}//package com.gaiaonline.monster.service.process 
