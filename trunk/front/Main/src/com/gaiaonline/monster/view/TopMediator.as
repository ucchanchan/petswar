//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import flash.display.*;
    import flash.events.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.model.world.*;
    import gaia.moga.friendlist.model.*;
    import com.gaiaonline.monster.service.sound.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.dailyPrize.*;
    import com.gaiaonline.monster.view.components.top.*;

    public class TopMediator extends Mediator {

		[Inject]
        public var view:Top;
		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var worldModel:WorldModel;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var monsters:MonsterAssetsFactory;
		[Inject]
        public var ranch:HomeRanchModel;
		[Inject]
        public var playerModel:PlayerModel;
		[Inject]
        public var inventory:InventoryModel;
		[Inject]
        public var text:TextService;
		[Inject]
        public var sound:SoundService;
		[Inject]
        public var model:SettingsModel;
		[Inject]
        public var appModel:ApplicationModel;
		[Inject]
        public var friends:FriendsModel;
		[Inject]
        public var friendRanch:FriendRanchModel;
		[Inject]
        public var fb:FBService;
        private var storeIsOpen:Boolean;

        private static const MIN_WHISTLE_ALERT_NODE:uint = 2;

        override public function onRegister():void{
            var _local1:InventoryItem;
            _local1 = this.inventory.getItem(ItemEnum.COFFEE);
            _local1.changed.add(this.onRechargesChanged);
            this.onRechargesChanged(_local1);
            _local1 = this.inventory.getItem(ItemEnum.WHISTLE);
            _local1.changed.add(this.onWhistleChanged);
            this.onWhistleChanged(_local1);
            _local1 = this.inventory.getItem(ItemEnum.SEED);
            _local1.changed.add(this.onSeedChanged);
            this.onSeedChanged(_local1);
            this.enableStore();
            this.setTips();
            this.playerModel.premiumCurrencyUpdated.add(this.onPremiumCurrencyUpdated);
            this.onPremiumCurrencyUpdated();
            eventDispatcher.addEventListener(PanelsEvent.REMOVE_OVERLAY, this.onEnableStore);
            if (this.canShowWhistleAlert()){
                this.view.whistleClicked.add(this.onWhistleClicked);
            };
            if (((!(this.model.enablePrize)) && ((this.appModel.state == ApplicationState.HOME)))){
                this.onShowDailyPrize();
            };
            this.setWhistleAlert();
            this.setFriendRanchInfo();
        }
        override public function onRemove():void{
            var _local1:InventoryItem;
            _local1 = this.inventory.getItem(ItemEnum.COFFEE);
            _local1.changed.remove(this.onRechargesChanged);
            _local1 = this.inventory.getItem(ItemEnum.WHISTLE);
            _local1.changed.remove(this.onWhistleChanged);
            _local1 = this.inventory.getItem(ItemEnum.SEED);
            _local1.changed.remove(this.onSeedChanged);
            this.disableStore();
            this.view.storeClicked.removeAll();
            this.view.whistleClicked.remove(this.onWhistleClicked);
            eventDispatcher.removeEventListener(PanelsEvent.REMOVE_OVERLAY, this.onEnableStore);
            this.clearTips();
            this.view.dispose();
        }
        private function setTips():void{
            var _local1:MovieClip = MovieClip(this.view.ui.content);
            dispatch(new ToolTipEvent(ToolTipEvent.ADD_TOOLTIP, _local1.whistles, this.text.getTip("TOP_WHISTLES")));
            dispatch(new ToolTipEvent(ToolTipEvent.ADD_TOOLTIP, _local1.recharges, this.text.getTip("TOP_RECHARGE")));
            dispatch(new ToolTipEvent(ToolTipEvent.ADD_TOOLTIP, _local1.seeds, this.text.getTip("TOP_SEEDS")));
            dispatch(new ToolTipEvent(ToolTipEvent.ADD_TOOLTIP, _local1.storeBtn, this.text.getTip("TOP_STORE")));
            dispatch(new ToolTipEvent(ToolTipEvent.ADD_TOOLTIP, _local1.premium, this.text.getTip("TOP_PREMIUM")));
        }
        private function clearTips():void{
            var _local1:MovieClip = MovieClip(this.view.ui.content);
            if (!_local1){
                return;
            };
            dispatch(new ToolTipEvent(ToolTipEvent.REMOVE_TOOLTIP, _local1.whistles));
            dispatch(new ToolTipEvent(ToolTipEvent.REMOVE_TOOLTIP, _local1.recharges));
            dispatch(new ToolTipEvent(ToolTipEvent.REMOVE_TOOLTIP, _local1.seeds));
            dispatch(new ToolTipEvent(ToolTipEvent.REMOVE_TOOLTIP, _local1.storeBtn));
            dispatch(new ToolTipEvent(ToolTipEvent.REMOVE_TOOLTIP, _local1.questBtn));
            dispatch(new ToolTipEvent(ToolTipEvent.REMOVE_TOOLTIP, _local1.premiumClicked));
        }
        private function onRechargesChanged(_arg1:InventoryItem):void{
            this.view.numRecharges = _arg1.quantity;
        }
        private function onWhistleChanged(_arg1:InventoryItem):void{
            this.view.numWhistles = _arg1.quantity;
        }
        private function onPremiumCurrencyUpdated():void{
            this.view.premiumCurrency = this.playerModel.premiumCurrency;
        }
        private function onSeedChanged(_arg1:InventoryItem):void{
            this.view.numSeeds = _arg1.quantity;
        }
        private function onStoreClicked(_arg1:MouseEvent):void{
            this.storeIsOpen = true;
            this.disableStore();
            dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_STORE));
        }
        private function onPremiumCurrencyClicked(_arg1:MouseEvent):void{
            this.storeIsOpen = true;
            this.disableStore();
            dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_PREMIUM_BUNDLE));
        }
        private function enableStore():void{
            this.view.storeClicked.add(this.onStoreClicked);
            this.view.rechargeClicked.add(this.onStoreClicked);
            this.view.premiumClicked.add(this.onPremiumCurrencyClicked);
            this.view.seedClicked.add(this.onStoreClicked);
            this.storeIsOpen = false;
        }
        private function disableStore():void{
            this.view.storeClicked.remove(this.onStoreClicked);
            this.view.rechargeClicked.remove(this.onStoreClicked);
            this.view.premiumClicked.remove(this.onPremiumCurrencyClicked);
            this.view.seedClicked.remove(this.onStoreClicked);
            this.storeIsOpen = true;
        }
        private function onEnableStore(_arg1:PanelsEvent):void{
            if (this.storeIsOpen){
                this.enableStore();
            };
        }
        private function onShowDailyPrize():void{
            this.view.enableDailyPrize();
            this.view.prizeClicked.addOnce(this.onDailyPrizeClicked);
        }
        private function onDailyPrizeClicked(_arg1:MouseEvent):void{
            var _local2:Asset = this.assets.dailyPrizeSwf;
            var _local3:DailyPrize = new DailyPrize(_local2);
            dispatch(new PanelsEvent(PanelsEvent.ADD_OVERLAY, _local3));
            this.view.disableDailyPrize();
        }
        private function showWhistleAlert(_arg1:Boolean):void{
            this.view.showWhistleAlert(this.assets.whistleAlert, _arg1);
        }
        private function canShowWhistleAlert():Boolean{
            var _local1:Vector.<Location> = this.worldModel.currentZone.locations;
            if ((((((this.appModel.state == ApplicationState.WORLD)) && ((this.friends.whistleCount > 0)))) && (_local1[MIN_WHISTLE_ALERT_NODE].hasWon))){
                return (true);
            };
            return (false);
        }
        private function onWhistleClicked(_arg1:MouseEvent):void{
            this.showWhistleAlert(true);
        }
        private function setWhistleAlert():void{
            if (this.canShowWhistleAlert()){
                this.showWhistleAlert(false);
            };
        }
        private function onCelebrateClicked(_arg1:MouseEvent):void{
            var _local2:Object = {};
            this.fb.showPromoPopup(_local2);
        }
        private function setFriendRanchInfo():void{
            var _local1:Friend;
            if (this.appModel.state == ApplicationState.FRIEND_RANCH){
                _local1 = this.friends.getFriendByID(this.friendRanch.friendID);
                this.view.showFriendInfo(_local1.picture, _local1.firstName);
            } else {
                this.view.hideFriendInfo();
            };
        }

    }
}//package com.gaiaonline.monster.view 
