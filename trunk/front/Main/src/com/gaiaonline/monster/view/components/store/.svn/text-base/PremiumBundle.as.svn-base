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

    public class PremiumBundle extends Panel {

        private var _closeWindow:Signal;
        private var _itemSelected:Signal;
        private var _continuePurchase:Signal;
        private var _xPos:int=190;// = 190
        private var _yPos:int=170;// = 170
        private var content:MovieClip;
        private var itemMap:Dictionary;
        private var previousItem:PremiumBundleItem;
        private var _premiumCurrencyBalance:uint;
        private var paymentTypeClip:MovieClip;
        private var fbSelect:MovieClip;
        private var offerSelect:MovieClip;
        private var paymentType:Dictionary;

        public function PremiumBundle(_arg1:Asset){
            this._closeWindow = new Signal();
            this._itemSelected = new Signal();
            this._continuePurchase = new Signal();
            addChild((this.content = MovieClip(_arg1.content)));
            this.fbSelect = this.content.main.fb;
            this.offerSelect = this.content.main.offer;
            this.content.alpha = 0;
            this.tweenIn();
            this.content.main.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseWindow, false, 0, true);
            this.content.main.continueButton.addEventListener(MouseEvent.CLICK, this.onContinue, false, 0, true);
            this.itemMap = new Dictionary(true);
            this.paymentTypeClip = this.fbSelect;
            this.fbSelect.addEventListener(MouseEvent.MOUSE_DOWN, this.onPaymentSelected);
            this.fbSelect.addEventListener(MouseEvent.MOUSE_OVER, this.onPaymentRollOver);
            this.fbSelect.addEventListener(MouseEvent.MOUSE_OUT, this.onPaymentRollOut);
            this.offerSelect.addEventListener(MouseEvent.MOUSE_DOWN, this.onPaymentSelected);
            this.offerSelect.addEventListener(MouseEvent.MOUSE_OVER, this.onPaymentRollOver);
            this.offerSelect.addEventListener(MouseEvent.MOUSE_OUT, this.onPaymentRollOut);
            this.offerSelect.selected.visible = false;
            this.offerSelect.hover.visible = false;
            this.fbSelect.hover.visible = false;
            this.offerSelect.buttonMode = true;
            this.fbSelect.buttonMode = true;
            this.paymentType = new Dictionary();
            this.paymentType[this.fbSelect] = "fb";
            this.paymentType[this.offerSelect] = "offer";
        }
        private function tweenIn():void{
            var _local1:GTween = new GTween(this.content, 0.25, {alpha:1});
        }
        public function addItem(_arg1:Asset, _arg2:StoreItemVO):void{
            var _local3:PremiumBundleItem = new PremiumBundleItem(_arg1, _arg2);
            _local3.clicked.add(this.onSelected);
            this.itemMap[_local3] = _arg2;
            addChild(_local3);
            _local3.y = this._yPos;
            _local3.x = this._xPos;
            this._yPos = (this._yPos + 38);
            if (_arg2.detailBundle){
                this.setSpecialItem(_arg2.id);
            };
        }
        private function onSelected(_arg1:PremiumBundleItem):void{
            if (this.previousItem){
                this.previousItem.update(false);
            };
            this._itemSelected.dispatch(this.itemMap[_arg1]);
            _arg1.update(true);
            this.previousItem = _arg1;
        }
        public function setSpecialItem(_arg1:int):void{
            var _local2:Object;
            var _local3:PremiumBundleItem;
            for (_local2 in this.itemMap) {
                _local3 = PremiumBundleItem(_local2);
                if (this.itemMap[_local3].id == _arg1){
                    _local3.update(true);
                    _local3.makeSpecial(true);
                    this.previousItem = _local3;
                    this._itemSelected.dispatch(this.itemMap[_local3]);
                    return;
                };
            };
        }
        private function onPaymentRollOver(_arg1:MouseEvent):void{
            if (this.paymentTypeClip != MovieClip(_arg1.currentTarget)){
                _arg1.currentTarget.hover.visible = true;
            };
        }
        private function onPaymentRollOut(_arg1:MouseEvent):void{
            _arg1.currentTarget.hover.visible = false;
        }
        private function onPaymentSelected(_arg1:MouseEvent):void{
            this.paymentTypeClip.selected.visible = false;
            _arg1.currentTarget.selected.visible = true;
            _arg1.currentTarget.hover.visible = false;
            this.paymentTypeClip = MovieClip(_arg1.currentTarget);
        }
        public function updatePremiumCurrency(_arg1:uint):void{
            this._premiumCurrencyBalance = _arg1;
            this.content.main.premiumCurrencyBalance.text = this._premiumCurrencyBalance;
        }
        private function onContinue(_arg1:MouseEvent):void{
            this._continuePurchase.dispatch(this.paymentType[this.paymentTypeClip]);
        }
        public function enable():void{
            mouseChildren = true;
        }
        public function disable():void{
            mouseChildren = false;
        }
        public function get itemSelected():Signal{
            return (this._itemSelected);
        }
        public function get continuePurchase():Signal{
            return (this._continuePurchase);
        }
        private function onCloseWindow(_arg1:MouseEvent):void{
            this._closeWindow.dispatch();
        }
        public function get closeWindow():Signal{
            return (this._closeWindow);
        }

    }
}//package com.gaiaonline.monster.view.components.store 
