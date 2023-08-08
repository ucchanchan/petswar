//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.view.ui.giver {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import com.gaiaonline.monster.view.components.starseedBasket.model.*;
    import alecmce.list.*;
    import gaia.lib.ui.*;

    public class StarseedBasketGiverPanel extends Panel {

        private var asset:Asset;
        private var _friendName:String;
        private var _closeClick:Signal;
        private var _postGiveInterstitial:PostGiveInterstitial;
        private var _preGiveInterstitial:PreGiveInterstitial;
        private var _giveStarseedButton:SimpleButton;
        private var _disabledGiveStarseedState:MovieClip;
        private var _giveStarseedClick:Signal;
        private var _giveSeedResponse:Signal;
        private var _shareResponse:Signal;
        private var _history:List;
        private var _historyData:Vector.<ListDatum>;
        private var _scrollbar:VScrollBar;
        private var _canGiftFriend:Boolean;// = false
        private var _canReceive:Boolean;// = false
        private var _seedsAvailable:uint;// = 0
        private var _grantLimit:uint;// = 0

        private static const VIEWABLE_HISTORY_COUNT:uint = 3;
        private static const REACHED_LIMIT_TEMPLATE:String = "%friendName% has reached the limit of how many free Starseeds they can receive right now. Give yours to other friends!";
        private static const OUT_OF_SEEDS_TEMPLATE:String = "You've already given out your free Starseed today. Come back tomorrow to give more.";
        private static const OUT_OF_MULTI_SEEDS_TEMPLATE:String = "You've already given out your %grantLimit% free Starseeds today. Come back tomorrow to give more.";
        private static const ALREADY_SHARED_TEMPLATE:String = "You've already shared a Starseed with %friendName% today.";
        private static const CAN_GIFT_TEMPLATE:String = "Would you like to give %friendName% a free Starseed? This Starseed will NOT come out of your inventory--it's totally free!";

        public function StarseedBasketGiverPanel(_arg1:Asset){
            this.asset = _arg1;
            this._closeClick = new Signal();
            this._giveStarseedClick = new Signal();
            this._giveSeedResponse = new Signal();
            this._shareResponse = new Signal();
        }
        public function get giveSeedResponse():Signal{
            return (this._giveSeedResponse);
        }
        public function set canGiftFriend(_arg1:Boolean):void{
            this._canGiftFriend = _arg1;
            this.updateTextFields();
            this.updateButtonState();
        }
        public function set canReceive(_arg1:Boolean):void{
            this._canReceive = _arg1;
            this.updateTextFields();
            this.updateButtonState();
        }
        public function set seedsAvailable(_arg1:uint):void{
            this._seedsAvailable = _arg1;
            this.updateTextFields();
            this.updateButtonState();
        }
        public function get shareResponse():Signal{
            return (this._shareResponse);
        }
        public function get giveStarseedClick():Signal{
            return (this._giveStarseedClick);
        }
        public function get closeClick():Signal{
            return (this._closeClick);
        }
        public function setHistory(_arg1:Vector.<ListDatum>):void{
            _arg1.sort(this.sortHistory);
            if (this._history){
                this._history.data = _arg1;
            };
            this._historyData = _arg1;
            if (this._scrollbar){
                this._scrollbar.setup(VIEWABLE_HISTORY_COUNT, _arg1.length);
                this._scrollbar.isVisible = (VIEWABLE_HISTORY_COUNT < _arg1.length);
            };
        }
        private function sortHistory(_arg1:FriendGiftEntry, _arg2:FriendGiftEntry):int{
            return (_arg1.compareToOtherEntry(_arg2));
        }
        public function setGrantLimit(_arg1:uint):void{
            this._grantLimit = _arg1;
            if (this._preGiveInterstitial){
                this._preGiveInterstitial.setGrantLimit(_arg1);
            };
        }
        override public function setup():void{
            addChild(this.asset.self);
            var _local1:SimpleButton = this.asset.content["closeButton"];
            _local1.addEventListener(MouseEvent.CLICK, this.onCloseButtonClick, false, 0, true);
            this._disabledGiveStarseedState = this.asset.content["disabledGiveStarseedState"];
            this._giveStarseedButton = this.asset.content["giveStarseedButton"];
            this._giveStarseedButton.addEventListener(MouseEvent.CLICK, this.onGiveStarseedClick, false, 0, true);
            this.updateButtonState();
            this._preGiveInterstitial = new PreGiveInterstitial(this.asset.content["preGiveInterstitial"]);
            this._preGiveInterstitial.noClick.add(this.onPreGiveNoClick);
            this._preGiveInterstitial.yesClick.add(this.onPreGiveYesClick);
            this._preGiveInterstitial.visible = false;
            this._preGiveInterstitial.setFriendName(this._friendName);
            this._preGiveInterstitial.setGrantLimit(this._grantLimit);
            this._postGiveInterstitial = new PostGiveInterstitial(this.asset.content["postGiveInterstitial"]);
            this._postGiveInterstitial.closeClick.add(this.onShareCloseClick);
            this._postGiveInterstitial.tellClick.add(this.onShareTellClick);
            this._postGiveInterstitial.visible = false;
            this._postGiveInterstitial.setFriendName(this._friendName);
            this._scrollbar = new VScrollBar(this.asset.content["scrollbar"].thumb, this.asset.content["scrollbar"].track);
            this._scrollbar.reposition.add(this.onScrollReposition);
            this._history = new List(this.asset.content["historyCells"]);
            if (this._historyData){
                this.setHistory(this._historyData);
            };
        }
        private function onScrollReposition(_arg1:Number):void{
            this._history.position = _arg1;
        }
        private function onShareCloseClick():void{
            this._shareResponse.dispatch(false);
        }
        private function onShareTellClick():void{
            this._shareResponse.dispatch(true);
        }
        private function onPreGiveNoClick():void{
            this._giveSeedResponse.dispatch(false);
        }
        private function onPreGiveYesClick():void{
            this._giveSeedResponse.dispatch(true);
        }
        override public function dispose(_arg1:Boolean=true):void{
            var _local2:SimpleButton = this.asset.content["closeButton"];
            _local2.removeEventListener(MouseEvent.CLICK, this.onCloseButtonClick, false);
            this._closeClick.removeAll();
            this._giveStarseedClick.removeAll();
            this._preGiveInterstitial.dispose(_arg1);
            this._postGiveInterstitial.dispose(_arg1);
            this._historyData = null;
            this._history = null;
            removeChild(this.asset.self);
        }
        public function set friendName(_arg1:String):void{
            this._friendName = _arg1;
            this.updateTextFields();
            if (this._postGiveInterstitial){
                this._postGiveInterstitial.setFriendName(_arg1);
            };
            if (this._preGiveInterstitial){
                this._preGiveInterstitial.setFriendName(_arg1);
            };
        }
        private function updateTextFields():void{
            if (this.asset.content.hasOwnProperty("basketOwnerField")){
                this.asset.content["basketOwnerField"].text = (this._friendName + "'s");
            };
            if (this.asset.content.hasOwnProperty("mainHeadingField")){
                this.asset.content["mainHeadingField"].text = (("Help " + this._friendName) + " catch more Mogas!");
            };
            if (this.asset.content.hasOwnProperty("mainBodyField")){
                this.asset.content["mainBodyField"].text = this.getMainBodyText();
            };
            if (this.asset.content.hasOwnProperty("listHeadingField")){
                this.asset.content["listHeadingField"].text = (this._friendName + "'s Starseed Basket History");
            };
        }
        private function getMainBodyText():String{
            var _local1:String;
            if (this._seedsAvailable == 0){
                _local1 = ((1 < this._grantLimit)) ? OUT_OF_MULTI_SEEDS_TEMPLATE : OUT_OF_SEEDS_TEMPLATE;
                _local1 = _local1.replace("%grantLimit%", this._grantLimit.toString(10));
            } else {
                if (this._canGiftFriend){
                    _local1 = CAN_GIFT_TEMPLATE;
                } else {
                    if (!this._canReceive){
                        _local1 = REACHED_LIMIT_TEMPLATE;
                    } else {
                        _local1 = ALREADY_SHARED_TEMPLATE;
                    };
                };
            };
            return (_local1.replace("%friendName%", this._friendName));
        }
        private function updateButtonState():void{
            var _local1:Boolean = ((this._canGiftFriend) && ((0 < this._seedsAvailable)));
            if (this._giveStarseedButton){
                this._giveStarseedButton.enabled = _local1;
                this._giveStarseedButton.visible = _local1;
                this._disabledGiveStarseedState.visible = !(_local1);
            };
        }
        public function showGiveMessage(_arg1:Boolean):void{
            this._preGiveInterstitial.visible = _arg1;
        }
        public function showShareMessage(_arg1:Boolean):void{
            this._postGiveInterstitial.visible = _arg1;
        }
        private function onCloseButtonClick(_arg1:MouseEvent):void{
            this._closeClick.dispatch();
        }
        private function onGiveStarseedClick(_arg1:MouseEvent):void{
            this._giveStarseedClick.dispatch();
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.view.ui.giver 
