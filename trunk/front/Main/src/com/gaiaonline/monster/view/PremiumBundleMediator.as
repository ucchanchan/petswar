//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view {
    import com.gaiaonline.monster.model.vo.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import com.gaiaonline.monster.view.components.store.*;
    import org.robotlegs.mvcs.*;

    public class PremiumBundleMediator extends Mediator {

		[Inject]
        public var view:PremiumBundle;
		[Inject]
        public var model:StoreModel;
		[Inject]
        public var assets:AssetService;
		[Inject]
        public var userModel:PlayerModel;
		[Inject]
        public var fb:FBService;
        private var currentItem:StoreItemVO;

        private static const BUNDLE_ITEM_ASSET:String = "assets/ui/premiumBundleItem.swf";
        private static const PREMIUM_TYPE:int = 3;

        override public function onRegister():void{
            this.model.premiumStoreOpen = true;
            this.view.closeWindow.addOnce(this.onClose);
            this.view.continuePurchase.add(this.onContinuePurchase);
            this.view.itemSelected.add(this.onItemSelected);
            this.userModel.premiumCurrencyUpdated.add(this.updatePremiumCurrency);
            this.updatePremiumCurrency();
            this.updateState();
        }
        override public function onRemove():void{
            this.model.premiumStoreOpen = false;
            this.view.closeWindow.removeAll();
            this.view.continuePurchase.removeAll();
            this.view.itemSelected.removeAll();
            this.view.dispose();
            this.userModel.premiumCurrencyUpdated.remove(this.updatePremiumCurrency);
        }
        private function updateState():void{
            var _local4:Asset;
            var _local1:Array = [];
            var _local2:int;
            while (_local2 < this.model.items.length) {
                if (this.model.items[_local2].type == PREMIUM_TYPE){
                    _local1.push(this.model.items[_local2]);
                };
                _local2++;
            };
            _local1.sortOn("premium_cost", Array.NUMERIC);
            _local1.reverse();
            var _local3:int;
            while (_local3 < _local1.length) {
                _local4 = this.assets.createWrapper(BUNDLE_ITEM_ASSET);
                this.view.addItem(_local4, _local1[_local3]);
                _local3++;
            };
        }
        private function updatePremiumCurrency():void{
            this.view.updatePremiumCurrency(this.userModel.premiumCurrency);
        }
        private function onItemSelected(_arg1:StoreItemVO):void{
            this.currentItem = _arg1;
        }
        private function onContinuePurchase(_arg1:String):void{
            if (_arg1 == "fb"){
                dispatch(new PremiumPurchaseEvent(PremiumPurchaseEvent.PURCHASE_VIA_FB, this.currentItem));
            } else {
                if (_arg1 == "offer"){
                    dispatch(new PremiumPurchaseEvent(PremiumPurchaseEvent.PURCHASE_VIA_OFFER, this.currentItem));
                };
            };
            this.fb.unpause.add(this.onUnpause);
        }
        private function onUnpause():void{
            this.view.enable();
        }
        private function onClose():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }

    }
}//package com.gaiaonline.monster.view 
