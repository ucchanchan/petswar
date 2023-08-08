//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.sound.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.components.store.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.model.tracking.*;

    public class StoreMediator extends Mediator {

		[Inject]
        public var view:Store;
		[Inject]
        public var model:StoreModel;
		[Inject]
        public var playerModel:PlayerModel;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var tracking:OmnitureService;
		[Inject]
        public var music:MusicService;

        override public function onRegister():void{
            this.model.open = true;
            this.view.close.add(this.onCloseShop);
            this.view.storeReady.add(this.onStoreReady);
            this.view.buyItem.add(this.onBuyItem);
            this.view.buyPremiumCurrency.add(this.onBuyPremiumCurrency);
            this.view.purchaseConfirmed.add(this.purchaseConfirmed);
            this.playerModel.premiumCurrencyUpdated.add(this.updatePremiumCurrency);
            eventDispatcher.addEventListener(StoreEvent.BUY_ITEM_SUCCESS, this.onSuccess, false, 0, true);
            eventDispatcher.addEventListener(StoreEvent.BUY_ITEM_FAIL, this.onFail, false, 0, true);
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.OPEN_SHOP));
        }
        override public function onRemove():void{
            this.model.open = false;
            this.view.close.removeAll();
            this.view.storeReady.removeAll();
            this.view.buyItem.removeAll();
            this.view.storeReady.removeAll();
            this.view.purchaseConfirmed.removeAll();
            this.view.dispose();
            this.playerModel.premiumCurrencyUpdated.remove(this.updatePremiumCurrency);
        }
        private function onCloseShop():void{
            dispatch(new TrackingEvent(TrackingEvent.TRACK, TrackingType.CLOSE_SHOP));
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }
        private function onStoreReady():void{
            this.updatePremiumCurrency();
            var _local1:Vector.<StoreItemVO> = Vector.<StoreItemVO>(this.vectorToArray(this.model.items).sortOn("premium_cost", Array.NUMERIC));
            _local1.reverse();
            var _local2:int;
            while (_local2 < _local1.length) {
                if (_local1[_local2].type == 2){
                    this.view.addStoreItem(_local1[_local2], this.assets.itemIcon(_local1[_local2].id));
                };
                _local2++;
            };
            this.updateTiles();
            this.view.enablePagination();
            if (this.playerModel.premiumCurrency == 0){
                dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_PREMIUM_BUNDLE));
            };
        }
        private function vectorToArray(_arg1):Array{
            var _local2:int = _arg1.length;
            var _local3:Array = new Array();
            var _local4:int;
            while (_local4 < _local2) {
                _local3[_local4] = _arg1[_local4];
                _local4++;
            };
            return (_local3);
        }
        private function updatePremiumCurrency():void{
            this.view.updatePremiumCurrency(this.playerModel.premiumCurrency);
            this.view.enableAllTiles();
        }
        private function updateTiles():void{
            this.view.enableAllTiles();
        }
        private function onBuyItem(_arg1:StoreItemVO, _arg2:uint):void{
            if (this.canBuy(_arg1, _arg2)){
                this.view.showConfirm(_arg1, _arg2);
            };
        }
        private function canBuy(_arg1:StoreItemVO, _arg2:uint):Boolean{
            if ((((this.playerModel.premiumCurrency == 0)) || ((this.playerModel.premiumCurrency < _arg1.premium_cost)))){
                dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_PREMIUM_BUNDLE));
                return (false);
            };
            if ((_arg1.premium_cost * _arg2) > this.playerModel.premiumCurrency){
                this.view.showQuantityError(_arg1);
                return (false);
            };
            return (true);
        }
        private function purchaseConfirmed(_arg1:StoreItemVO, _arg2:uint):void{
            this.view.disableAllTiles();
            dispatch(new StoreEvent(StoreEvent.BUY_ITEM, _arg1.id, _arg2));
        }
        private function onSuccess(_arg1:StoreEvent):void{
            this.updateTiles();
        }
        private function onBuyPremiumCurrency():void{
            dispatch(new ApplicationEvent(ApplicationEvent.INVOKE_PREMIUM_BUNDLE));
        }
        private function onFail(_arg1:StoreEvent):void{
        }

    }
}//package com.gaiaonline.monster.view 
