//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.store {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import flash.utils.*;
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;

    public class Store extends Panel {

        private var _content:MovieClip;
        private var _storeTilePath:String;
        private var _close:Signal;
        private var _buyItem:Signal;
        private var _purchaseConfirmed:Signal;
        private var _purchaseCancelled:Signal;
        private var _buyPremiumCurrency:Signal;
        private var _storeReady:Signal;
        private var _tileDataMap:Dictionary;
        private var _dataTileMap:Dictionary;
        private var _premiumCurrencyBalance:uint;
        private var _pendingPurchase:StoreItemVO;
        private var _pendingQty:uint;
        private var _pageUp:SimpleButton;
        private var _pageDown:SimpleButton;
        private var confirmScreen:MovieClip;
        private var _yPos:int;// = 0
        private var _itemsInTab:int;// = 0
        private var _pageCtr:int;// = 1
        private var _storeAsset:DisplayObject;

        private static const CLOSE_BTN:String = "closeBtn";
        private static const RECHARGE_BTN:String = "rechargeBtn";
        private static const CONFIRM_SCREEN:String = "confirmScreen";
        private static const COIN_VALUE:uint = 10;
        private static const STORE_MC:String = "storeMC";
        private static const CLOSE_SHOP:String = "closeShop";
        private static const CLOSE_SHOP_ANIM_COMPLETE:String = "closeShopComplete";
        private static const OPEN_SHOP_ANIM_COMPLETE:String = "openShopComplete";
        private static const PREMIUM_BALANCE:String = "";
        private static const TILE_BUFFER:uint = 110;
        private static const X_POS:uint = 0;
        private static const ITEMS_PER_PAGE:uint = 2;

        public function Store(_arg1:Asset, _arg2:String){
            this._storeAsset = _arg1.self;
            this._buyItem = new Signal();
            this._close = new Signal();
            this._purchaseConfirmed = new Signal();
            this._purchaseCancelled = new Signal();
            this._storeReady = new Signal();
            this._buyPremiumCurrency = new Signal();
            this._tileDataMap = new Dictionary();
            this._dataTileMap = new Dictionary();
            addChild(this._storeAsset);
            this._content = MovieClip(_arg1.content);
            this._storeTilePath = _arg2;
            this._content.signal.add(this.onSignal);
        }
        private function onSignal(_arg1:Object):void{
            if (_arg1 == CLOSE_SHOP_ANIM_COMPLETE){
                this._close.dispatch();
            } else {
                if (_arg1 == OPEN_SHOP_ANIM_COMPLETE){
                    this._content.getChildByName(CLOSE_BTN).addEventListener(MouseEvent.CLICK, this.onCloseStore, false, 0, true);
                    this._content.getChildByName(RECHARGE_BTN).addEventListener(MouseEvent.CLICK, this.onRechargePremiumCurrency, false, 0, true);
                    this._storeReady.dispatch();
                    this.confirmScreen = MovieClip(this._content.getChildByName(CONFIRM_SCREEN));
                    this.confirmScreen.visible = false;
                };
            };
        }
        public function updatePremiumCurrency(_arg1:uint):void{
            this._premiumCurrencyBalance = _arg1;
            this._content.premiumCurrencyBalance.text = (PREMIUM_BALANCE + this._premiumCurrencyBalance);
        }
        public function enablePagination():void{
            this._pageUp = this._content.pageUp;
            this._pageDown = this._content.pageDown;
            this._pageUp.addEventListener(MouseEvent.CLICK, this.onPageUp, false, 0, true);
            this._pageDown.addEventListener(MouseEvent.CLICK, this.onPageDown, false, 0, true);
            this.updatePagination();
        }
        private function updatePagination():void{
            if (this._pageCtr == 1){
                this.disablePageButton(this._pageUp);
            } else {
                this.enablePageButton(this._pageUp);
            };
            if (this._pageCtr == this._itemsInTab){
                this.disablePageButton(this._pageDown);
            } else {
                this.enablePageButton(this._pageDown);
            };
            if (this._itemsInTab <= ITEMS_PER_PAGE){
                this.disablePageButton(this._pageDown);
                this.disablePageButton(this._pageUp);
            };
        }
        private function enablePageButton(_arg1:SimpleButton):void{
            _arg1.alpha = 1;
            _arg1.mouseEnabled = true;
        }
        private function disablePageButton(_arg1:SimpleButton):void{
            _arg1.alpha = 0.2;
            _arg1.mouseEnabled = false;
        }
        private function onPageUp(_arg1:MouseEvent):void{
            this._pageCtr = (this._pageCtr - ITEMS_PER_PAGE);
            new GTween(this._content.tileMc.container, 0.25, {y:(this._content.tileMc.container.y + 105)});
            this.updatePagination();
        }
        private function onPageDown(_arg1:MouseEvent):void{
            this._pageCtr = (this._pageCtr + ITEMS_PER_PAGE);
            new GTween(this._content.tileMc.container, 0.25, {y:(this._content.tileMc.container.y - 105)});
            this.updatePagination();
        }
        public function addStoreItem(_arg1:StoreItemVO, _arg2:Asset):void{
            var _local3:StoreTile = new StoreTile(_arg1, this._storeTilePath, _arg2);
            this._tileDataMap[_local3] = _arg1;
            this._dataTileMap[_arg1] = _local3;
            _local3.buy.add(this.onBuyItem);
            this._content.tileMc.container.addChild(_local3);
            _local3.x = X_POS;
            _local3.y = this._yPos;
            this._yPos = (this._yPos + TILE_BUFFER);
            if (_arg1.onSale){
                _local3.setSale(true);
            } else {
                _local3.setSale(false);
            };
            this._itemsInTab++;
        }
        public function disableAllTiles():void{
            var _local1:Object;
            for (_local1 in this._tileDataMap) {
                _local1.disable();
            };
        }
        public function enableAllTiles():void{
            var _local1:Object;
            for (_local1 in this._tileDataMap) {
                _local1.enable();
            };
        }
        private function onRechargePremiumCurrency(_arg1:MouseEvent):void{
            this._buyPremiumCurrency.dispatch();
        }
        private function onBuyItem(_arg1:StoreTile, _arg2:uint):void{
            this._buyItem.dispatch(this._tileDataMap[_arg1], _arg2);
        }
        public function showConfirm(_arg1:StoreItemVO, _arg2:uint):void{
            this.confirmScreen.message.text = ((("Are you sure you want to purchase " + _arg2) + " ") + _arg1.name);
            if (_arg2 > 1){
                this.confirmScreen.message.text = (this.confirmScreen.message.text + "s");
            };
            this.confirmScreen.message.text = (this.confirmScreen.message.text + ((" for " + (_arg2 * _arg1.premium_cost)) + " Star Coins?"));
            this._content.confirmScreen.visible = true;
            this.confirmScreen.confirmButton.addEventListener(MouseEvent.CLICK, this.onConfirmPurchase, false, 0, true);
            this.confirmScreen.closeButton.addEventListener(MouseEvent.CLICK, this.onConfirmCancelled, false, 0, true);
            this._pendingPurchase = _arg1;
            this._pendingQty = _arg2;
        }
        private function onConfirmPurchase(_arg1:MouseEvent):void{
            this._purchaseConfirmed.dispatch(this._pendingPurchase, this._pendingQty);
            this._pendingPurchase = null;
            this._pendingQty = 0;
            this._content.confirmScreen.visible = false;
        }
        public function showQuantityError(_arg1:StoreItemVO):void{
            this._dataTileMap[_arg1].setError("Not enough currency for this quantity.");
        }
        private function onConfirmCancelled(_arg1:MouseEvent):void{
            this._pendingPurchase = null;
            this._content.confirmScreen.visible = false;
        }
        override public function dispose(_arg1:Boolean=true):void{
            this.removeChild(this._storeAsset);
        }
        private function onCloseStore(_arg1:MouseEvent):void{
            this._content.gotoAndPlay(CLOSE_SHOP);
        }
        public function get storeReady():Signal{
            return (this._storeReady);
        }
        public function get purchaseConfirmed():Signal{
            return (this._purchaseConfirmed);
        }
        public function get close():Signal{
            return (this._close);
        }
        public function get buyPremiumCurrency():Signal{
            return (this._buyPremiumCurrency);
        }
        public function get buyItem():Signal{
            return (this._buyItem);
        }

    }
}//package com.gaiaonline.monster.view.components.store 
