//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.store {
    import flash.display.*;
    import flash.events.*;
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import flash.net.*;

    public class StoreTile extends Sprite {

        private var _assetPath:String;
        private var _asset:MovieClip;
        private var _buyButton:SimpleButton;
        private var _buy:Signal;
        private var _vo:StoreItemVO;
        private var _icon:Asset;
        private var _isSale:Boolean;
        private var qty:uint;

        public function StoreTile(_arg1:StoreItemVO, _arg2:String, _arg3:Asset){
            this._vo = _arg1;
            this._icon = _arg3;
            this._buy = new Signal();
            this._assetPath = _arg2;
            var _local4:Loader = new Loader();
            _local4.load(new URLRequest(_arg2));
            _local4.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoaded, false, 0, true);
        }
        private function onLoaded(_arg1:Event):void{
            this._asset = MovieClip(_arg1.currentTarget.content);
            addChild(this._asset);
            this._asset.itemCost.text = this._vo.premium_cost;
            this._asset.title.text = this._vo.name;
            this._asset.description.text = this._vo.description;
            this._asset.itemIcon.addChild(this._icon);
            this._asset.ribbon.visible = this._isSale;
            this._asset.buyBtn.addEventListener(MouseEvent.MOUSE_DOWN, this.onBuy, false, 0, true);
            this._asset.quantity.addEventListener(Event.CHANGE, this.onQtyChange, false, 0, true);
            this.setError("");
        }
        public function get buy():Signal{
            return (this._buy);
        }
        private function onBuy(_arg1:MouseEvent):void{
            this.setError("");
            if ((((this._asset.quantity.text == "")) || ((this._asset.quantity.text == "0")))){
                this._asset.quantity.text = 1;
                this.setError("Enter a number.");
                return;
            };
            this.qty = uint(this._asset.quantity.text);
            this._buy.dispatch(this, this.qty);
        }
        public function disable():void{
            alpha = 0.5;
            mouseEnabled = false;
            mouseChildren = false;
            buttonMode = false;
        }
        public function enable():void{
            alpha = 1;
            mouseEnabled = true;
            mouseChildren = true;
            buttonMode = true;
        }
        public function setError(_arg1:String):void{
            this._asset.error.text = _arg1;
        }
        public function setSale(_arg1:Boolean):void{
            this._isSale = _arg1;
        }
        private function onQtyChange(_arg1:Event):void{
            var _local5:String;
            var _local2:int = this._asset.quantity.text.length;
            var _local3:String = this._asset.quantity.text;
            var _local4:int;
            while (_local4 < _local2) {
                _local5 = _local3.charAt(_local4);
                if ((((_local5.charCodeAt() < 48)) || ((_local5.charCodeAt() > 57)))){
                    this._asset.quantity.text = "";
                    return;
                };
                _local4++;
            };
        }

    }
}//package com.gaiaonline.monster.view.components.store 
