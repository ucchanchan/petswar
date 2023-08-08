//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.view.ui.receiver {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import com.gaiaonline.monster.view.components.starseedBasket.model.*;
    import alecmce.ui.button.*;
    import alecmce.list.*;
    import com.gaiaonline.monster.view.components.starseedBasket.view.ui.*;
    import flash.desktop.*;

    public class StarseedBasketRequesterPanel extends Panel {

        private var _isSetup:Boolean;// = false
        private var _asset:Asset;
        private var _closeClick:Signal;
        private var _moreFriendsButton:MovieClipButton;
        private var _getStarseedsButton:MovieClipButton;
        private var _collectGiftsButton:MovieClipButton;
        private var _askForStarseedsButton:SimpleButton;
        private var _copyToClipboardButton:SimpleButton;
        private var _getStarseedsView:GetStarseedView;
        private var _collectStarseedsView:CollectStarseedsView;
        private var _moreFriendsView:MoreFriendsView;
        private var _moreFriendsClick:Signal;
        private var _getStarseedsClick:Signal;
        private var _collectGiftsClick:Signal;
        private var _inviteFriendsClick:Signal;
        private var _collectButtonClick:Signal;
        private var _askForStarseedsClick:Signal;
        private var _visitSkyShopClick:Signal;
        private var _historyData:Vector.<ListDatum>;
        private var _friendsWithSeeds:Vector.<ListDatum>;
        private var _showCollectFirst:Boolean;// = false
        private var _toCollectCount:uint;// = 0
        private var _toCollectText:String;// = ""
        private var _copyToClipboardClick:Signal;
        private var _linkText:String;
        private var _grantLimit:int;// = 0
        private var _isHome:Boolean;// = true

        public function StarseedBasketRequesterPanel(_arg1:Asset){
            this._asset = _arg1;
            this._closeClick = new Signal();
            this._moreFriendsClick = new Signal();
            this._getStarseedsClick = new Signal();
            this._collectGiftsClick = new Signal();
            this._inviteFriendsClick = new Signal();
            this._collectButtonClick = new Signal();
            this._askForStarseedsClick = new Signal();
            this._visitSkyShopClick = new Signal();
            this._copyToClipboardClick = new Signal();
        }
        public function get copyToClipboardClick():Signal{
            return (this._copyToClipboardClick);
        }
        public function get closeClick():Signal{
            return (this._closeClick);
        }
        public function get moreFriendsClick():Signal{
            return (this._moreFriendsClick);
        }
        public function get getStarseedsClick():Signal{
            return (this._getStarseedsClick);
        }
        public function get collectGiftsClick():Signal{
            return (this._collectGiftsClick);
        }
        public function get inviteFriendsClick():Signal{
            return (this._inviteFriendsClick);
        }
        public function get askForStarseedsClick():Signal{
            return (this._askForStarseedsClick);
        }
        public function get collectSeedsClick():Signal{
            return (this._collectButtonClick);
        }
        public function get visitSkyShopClick():Signal{
            return (this._visitSkyShopClick);
        }
        public function setToCollectCount(_arg1:uint, _arg2:String, _arg3:Boolean):void{
            this._toCollectCount = _arg1;
            this._toCollectText = _arg2;
            this._isHome = _arg3;
            if (this._collectStarseedsView){
                this._collectStarseedsView.setToCollectCount(_arg1, _arg2, _arg3);
            };
        }
        public function setHistory(_arg1:Vector.<ListDatum>):void{
            this._historyData = _arg1;
            if (this._collectStarseedsView){
                this._collectStarseedsView.setHistory(_arg1);
            };
        }
        public function setFriendsWithSeeds(_arg1:Vector.<ListDatum>, _arg2:int):void{
            this._friendsWithSeeds = _arg1;
            this._grantLimit = _arg2;
            if (this._getStarseedsView){
                this._getStarseedsView.setFriendsWithSeeds(_arg1, _arg2);
            };
        }
        public function showMoreFriendsView():void{
            this.selectTab(this._moreFriendsButton);
            this.showView(this._moreFriendsView);
        }
        public function showGetStarseedsView():void{
            this.selectTab(this._getStarseedsButton);
            this.showView(this._getStarseedsView);
        }
        public function showCollectGiftsView():void{
            if (this._collectGiftsButton){
                this.selectTab(this._collectGiftsButton);
                this.showView(this._collectStarseedsView);
            } else {
                this._showCollectFirst = true;
            };
        }
        private function selectTab(_arg1:MovieClipButton):void{
            this._moreFriendsButton.isEnabled = !((_arg1 == this._moreFriendsButton));
            this._getStarseedsButton.isEnabled = !((_arg1 == this._getStarseedsButton));
            this._collectGiftsButton.isEnabled = !((_arg1 == this._collectGiftsButton));
        }
        private function showView(_arg1:InnerPanel):void{
            this._getStarseedsView.visible = (_arg1 == this._getStarseedsView);
            this._collectStarseedsView.visible = (_arg1 == this._collectStarseedsView);
            this._moreFriendsView.visible = (_arg1 == this._moreFriendsView);
        }
        override public function setup():void{
            addChild(this._asset.self);
            var _local1:SimpleButton = this._asset.content["closeButton"];
            _local1.addEventListener(MouseEvent.CLICK, this.onCloseButtonClick, false, 0, true);
            this.setTabs();
            this._askForStarseedsButton = this._asset.content["askForStarseedsButton"];
            this._askForStarseedsButton.addEventListener(MouseEvent.CLICK, this.onAskForStarseedsButtonClick, false, 0, true);
            this._copyToClipboardButton = this._asset.content["copyToClipboardButton"];
            this._copyToClipboardButton.addEventListener(MouseEvent.CLICK, this.onCopyToClipboardClick, false, 0, true);
            this._getStarseedsView = new GetStarseedView(this._asset.content["getStarseedsNoFriendsView"], this._asset.content["getStarseedsWithFriendsView"]);
            this._getStarseedsView.inviteClick.add(this.onInviteFriendsClick);
            this._getStarseedsView.visitSkyShopClick.add(this.onVisitSkyShopClick);
            if (this._friendsWithSeeds){
                this._getStarseedsView.setFriendsWithSeeds(this._friendsWithSeeds, this._grantLimit);
            };
            this._collectStarseedsView = new CollectStarseedsView(this._asset.content["collectStarseedsView"]);
            this._collectStarseedsView.getStarseedClick.add(this.onGetStarseedsButtonClick);
            this._collectStarseedsView.collectClick.add(this.onCollectClick);
            this._collectStarseedsView.setToCollectCount(this._toCollectCount, this._toCollectText, this._isHome);
            if (this._historyData){
                this.setHistory(this._historyData);
            };
            this._moreFriendsView = new MoreFriendsView(this._asset.content["moreFriendsView"]);
            this._moreFriendsView.inviteFriendsClick.add(this.onInviteFriendsClick);
            if (this._showCollectFirst){
                this.showCollectGiftsView();
            } else {
                this.showGetStarseedsView();
            };
            if (this._linkText){
                this.setLinkText(this._linkText);
            } else {
                this._asset.content["shareLinkField"].text = "";
            };
            this._isSetup = true;
        }
        private function setTabs():void{
            this._moreFriendsButton = new MovieClipButton(this._asset.content["moreFriendsButton"], 1, 2, 2, 2);
            this._moreFriendsButton.clicked.add(this.onTabClick);
            this._getStarseedsButton = new MovieClipButton(this._asset.content["getStarseedsButton"], 1, 2, 2, 2);
            this._getStarseedsButton.clicked.add(this.onTabClick);
            this._collectGiftsButton = new MovieClipButton(this._asset.content["collectGiftsButton"], 1, 2, 2, 2);
            this._collectGiftsButton.clicked.add(this.onTabClick);
        }
        public function setLinkText(_arg1:String):void{
            this._linkText = _arg1;
            if (this._asset.content.hasOwnProperty("shareLinkField")){
                this._asset.content["shareLinkField"].text = this._linkText;
            };
        }
        private function onAskForStarseedsButtonClick(_arg1:MouseEvent):void{
            this._askForStarseedsClick.dispatch();
        }
        private function onCopyToClipboardClick(_arg1:MouseEvent):void{
            Clipboard.generalClipboard.clear();
            Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, this._asset.content["shareLinkField"].text, false);
            this._copyToClipboardClick.dispatch();
        }
        private function onInviteFriendsClick():void{
            this._inviteFriendsClick.dispatch();
        }
        private function onGetStarseedsButtonClick():void{
            this.showGetStarseedsView();
        }
        private function onCollectClick():void{
            this._collectButtonClick.dispatch();
        }
        private function onTabClick(_arg1:MovieClipButton):void{
            switch (_arg1){
                case this._moreFriendsButton:
                    this._moreFriendsClick.dispatch();
                    break;
                case this._getStarseedsButton:
                    this._getStarseedsClick.dispatch();
                    break;
                case this._collectGiftsButton:
                    this._collectGiftsClick.dispatch();
                    break;
            };
        }
        private function onVisitSkyShopClick():void{
            this._visitSkyShopClick.dispatch();
        }
        override public function dispose(_arg1:Boolean=true):void{
            var _local3:FriendWithSeedEntry;
            this._getStarseedsView.dispose();
            this._getStarseedsView = null;
            this._moreFriendsView.dispose();
            this._moreFriendsView = null;
            this._collectStarseedsView.dispose();
            this._collectStarseedsView = null;
            this._askForStarseedsButton.removeEventListener(MouseEvent.CLICK, this.onAskForStarseedsButtonClick, false);
            this._askForStarseedsButton = null;
            this._copyToClipboardClick.removeAll();
            this._copyToClipboardButton.removeEventListener(MouseEvent.CLICK, this.onCopyToClipboardClick, false);
            this._copyToClipboardButton = null;
            this._visitSkyShopClick.removeAll();
            var _local2:SimpleButton = this._asset.content["closeButton"];
            _local2.removeEventListener(MouseEvent.CLICK, this.onCloseButtonClick, false);
            this._closeClick.removeAll();
            for each (_local3 in this._friendsWithSeeds) {
                _local3.postOnWallClick.removeAll();
            };
            this._friendsWithSeeds = null;
            removeChild(this._asset.self);
            this._asset = null;
        }
        private function onCloseButtonClick(_arg1:MouseEvent):void{
            this._closeClick.dispatch();
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.view.ui.receiver 
