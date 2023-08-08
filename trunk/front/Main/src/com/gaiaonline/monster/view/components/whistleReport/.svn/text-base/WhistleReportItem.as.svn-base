//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.whistleReport {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import com.gaiaonline.monster.model.vo.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import gaia.moga.friendlist.model.*;
    import flash.geom.*;
    import gaia.moga.assets.bundle.*;
    import flash.text.*;
    import com.gaiaonline.monster.service.*;
    import alecmce.list.*;
    import gaia.moga.ui.bar.*;

    public class WhistleReportItem implements ListDatum {

        private var content:MovieClip;
        private var _item:WhistleReportItemDataVO;
        private var _msg:String;
        private var _monster:MonsterModel;
        private var _fightMonster:Asset;
        private var _friendID:String;
        private var _friendPic:Asset;
        private var _friendName:String;
        private var _contentIsSet:Boolean;// = false
        private var _revealButtonClick:Signal;
        private var _friendCountRollover:Signal;
        private var _friendCountRollout:Signal;
        private var _friendThanked:Signal;
        private var _otherFriends:Sprite;
        private var _xpBar:MovieClipBar;
        private var _bundle:WhistleReportItemBundle;
        private var _levelUpAnim:WhistleReportLevelUpAsync;
        private var _bonusAsync:WhistleReportBonusAsync;
        private var _assetsInitialized:Boolean;// = false
        private var _mcLinksTable:Dictionary;
        private var _bonusRevealed:Boolean;// = false
        private var _removalRequested:Signal;

        private static const FRIEND_NAME_COLOR:String = "#33cccc";
        private static const OTHER_FRIENDS_COLOR:String = "#02B0DB";

        public function WhistleReportItem(_arg1:WhistleReportItemBundle, _arg2:WhistleReportItemDataVO, _arg3:String){
            this._item = _arg2;
            this._friendID = _arg3;
            this._revealButtonClick = new Signal();
            this._friendCountRollout = new Signal();
            this._friendCountRollover = new Signal();
            this._removalRequested = new Signal();
            this._friendThanked = new Signal();
            this._mcLinksTable = new Dictionary();
            this._bundle = _arg1;
            if (this._bundle.isComplete){
                this.init(this._bundle);
            } else {
                this._bundle.complete.addOnce(this.init);
            };
            this._bundle.init();
        }
        private function cleanupMCLinks(_arg1:MovieClip):void{
            var _local2:MCLinks = (this._mcLinksTable[_arg1] as MCLinks);
            if (_local2.linkHoverButton){
                _local2.linkHoverButton.removeEventListener(MouseEvent.ROLL_OVER, this.onFriendAnchorRollover, false);
                _local2.linkHoverButton.removeEventListener(MouseEvent.ROLL_OUT, this.onFriendAnchorRollout, false);
                if (_local2.linkHoverButton.parent == _arg1){
                    _arg1.removeChild(_local2.linkHoverButton);
                };
                _local2.linkHoverButton = null;
            };
            if (_local2.otherFriends){
                if (this._otherFriends == _local2.otherFriends){
                    this._otherFriends = null;
                };
                _arg1.removeChild(_local2.otherFriends);
                _local2.otherFriends = null;
            };
            if (_arg1.revealButton){
                _arg1.revealButton.removeEventListener(MouseEvent.CLICK, this.onRevealButtonClicked, false);
            };
            if (_arg1.sendGiftButton){
                _arg1.sendGiftButton.removeEventListener(MouseEvent.CLICK, this.onThankYouButtonClicked, false);
            };
            if (_arg1.__item == this){
                _arg1.__item = null;
            };
            delete this._mcLinksTable[_arg1];
        }
        public function apply(_arg1:MovieClip):void{
            var _local2:WhistleReportItem;
            if (_arg1.__item){
                _local2 = (_arg1.__item as WhistleReportItem);
                _local2.cleanupMCLinks(_arg1);
            };
            this.content = _arg1;
            this.content.__item = this;
            this._mcLinksTable[_arg1] = new MCLinks();
            if (((this._contentIsSet) && (this._assetsInitialized))){
                this.update();
            };
        }
        public function clear(_arg1:MovieClip):void{
        }
        public function toString():String{
            return (this._monster.name);
        }
        public function get item():WhistleReportItemDataVO{
            return (this._item);
        }
        public function get revealButtonClick():Signal{
            return (this._revealButtonClick);
        }
        public function get thankYouButtonClick():Signal{
            return (this._friendThanked);
        }
        public function get friendCountRollover():Signal{
            return (this._friendCountRollover);
        }
        public function get friendCountRollout():Signal{
            return (this._friendCountRollout);
        }
        public function get picturedFriendID():String{
            return (this._friendID);
        }
        public function get removalRequested():Signal{
            return (this._removalRequested);
        }
        public function dispose():void{
            var _local1:Object;
            this.content = null;
            this._bundle.dispose();
            this._fightMonster = null;
            this._friendPic = null;
            this._item = null;
            this._revealButtonClick.removeAll();
            this._revealButtonClick = null;
            this._friendCountRollout.removeAll();
            this._friendCountRollout = null;
            this._friendCountRollover.removeAll();
            this._friendCountRollover = null;
            this._friendThanked.removeAll();
            this._friendThanked = null;
            this._removalRequested.removeAll();
            this._removalRequested = null;
            for (_local1 in this._mcLinksTable) {
                this.cleanupMCLinks((_local1 as MovieClip));
            };
            this._mcLinksTable = null;
        }
        public function setContent(_arg1:MonsterModel, _arg2:Asset, _arg3:Friend, _arg4:String):void{
            this._monster = _arg1;
            this._fightMonster = _arg2;
            this._friendName = _arg3.name;
            this._friendPic = _arg3.picture;
            this._msg = _arg4;
            this._contentIsSet = true;
            if (((this.content) && (this._assetsInitialized))){
                this.update();
            };
        }
        public function showOtherFriends(_arg1:Vector.<Friend>):void{
            var _local2:Friend;
            if (!this._otherFriends){
                this._otherFriends = new Sprite();
                this.content.addChild(this._otherFriends);
                MCLinks(this._mcLinksTable[this.content]).otherFriends = this._otherFriends;
                this._otherFriends.x = (this.content.description.x + 125);
            };
            for each (_local2 in _arg1) {
                if (_local2.picture.isComplete){
                    this.onOtherFriendPictureReady((_local2.picture as AssetBase));
                } else {
                    _local2.picture.complete.addOnce(this.onOtherFriendPictureReady);
                };
            };
            this._otherFriends.visible = true;
        }
        private function onOtherFriendPictureReady(_arg1:AssetBase):void{
            var _local2:Bitmap = Utils.createBitmapFromDisplayObject(_arg1.self);
            _local2.scaleX = (_local2.scaleY = 0.5);
            _local2.x = ((this._otherFriends.numChildren == 0)) ? 0 : (this._otherFriends.width + 2);
            this._otherFriends.addChild(_local2);
        }
        public function hideOtherFriends():void{
            this._otherFriends.visible = false;
            while (this._otherFriends.numChildren) {
                this._otherFriends.removeChildAt(0);
            };
        }
        public function animateXPIncrease():void{
            var _local1:ExperienceVO = this._monster.xp;
            this._xpBar.value = (this.item.levelUp) ? _local1.max : _local1.value;
            this._bonusAsync.setBonusMultiplier((this.item.multiplier + "x"));
            var _local2:MovieClip = this._bonusAsync.currentAnim;
            this.content.monster.addChild(_local2);
            _local2.gotoAndPlay(1);
        }
        public function animateLevelUp():void{
            this._levelUpAnim.anim.scaleX = 0.5;
            this._levelUpAnim.anim.scaleY = 0.5;
            this.content.monster.addChild(this._levelUpAnim.anim).y = -20;
            this._levelUpAnim.play(this.item.levelUp.post);
        }
        public function showThankYouButton():void{
            this.content.revealButton.visible = false;
            var _local1:SimpleButton = (this.content.sendGiftButton as SimpleButton);
            _local1.useHandCursor = true;
            _local1.addEventListener(MouseEvent.CLICK, this.onThankYouButtonClicked, false, 0, true);
        }
        private function init(_arg1:Asset=null):void{
            this._levelUpAnim = new WhistleReportLevelUpAsync(this._bundle.levelUp);
            this._levelUpAnim.complete.addOnce(this.onLevelUpComplete);
            this._bonusAsync = new WhistleReportBonusAsync(this._bundle.bonusAnimsAsset);
            this._assetsInitialized = true;
            if (((this._contentIsSet) && (this.content))){
                this.update();
            };
        }
        private function onLevelUpComplete(_arg1:WhistleReportLevelUpAsync):void{
            if (this._levelUpAnim.anim.parent){
                this._levelUpAnim.anim.parent.removeChild(this._levelUpAnim.anim);
            };
        }
        private function update():void{
            this.updateDescriptionField();
            this.updateMonsterPic();
            this.updateFriendPic();
            this.updateActionButton();
            this.updateXPBar();
            this._bonusAsync.setData(this._monster.name, this.item.xp);
        }
        private function updateXPBar():void{
            var _local1:ExperienceVO = this._monster.xp;
            this._xpBar = new MovieClipBar(this.content.xpBarFill);
            var _local2:int = ((this.item.levelUp) ? _local1.max : _local1.value - this.item.xp);
            this._xpBar.setBounds(_local2, 0, _local1.max);
        }
        private function updateDescriptionField():void{
            this.content.description.styleSheet = this.getReportItemStylesheet();
            this.content.description.htmlText = this._msg;
            this.setupTextHoverClip();
        }
        private function updateMonsterPic():void{
            while (this.content.monster.numChildren > 0) {
                this.content.monster.removeChildAt(0);
            };
            this.content.monster.addChild(this._fightMonster.self);
            this._fightMonster.self.scaleX = (this._fightMonster.self.scaleY = 0.5);
            this._fightMonster.self.y = 10;
        }
        private function updateFriendPic():void{
            if (this._friendPic.isComplete){
                this.onFriendPicReady((this._friendPic as AssetBase));
            } else {
                this._friendPic.complete.addOnce(this.onFriendPicReady);
            };
        }
        private function onFriendPicReady(_arg1:AssetBase):void{
            this.content.friend.removeChildAt((this.content.friend.numChildren - 1));
            var _local2:DisplayObject = Utils.createBitmapFromDisplayObject(_arg1.self);
            this.content.friend.addChild(_local2);
        }
        private function updateActionButton():void{
            var _local1:SimpleButton;
            if (!this._bonusRevealed){
                _local1 = (this.content.revealButton as SimpleButton);
                _local1.useHandCursor = true;
                _local1.visible = true;
                _local1.addEventListener(MouseEvent.CLICK, this.onRevealButtonClicked, false, 0, true);
            } else {
                this.showThankYouButton();
            };
        }
        private function getReportItemStylesheet():StyleSheet{
            var _local1:StyleSheet = new StyleSheet();
            var _local2:Object = new Object();
            _local2.color = FRIEND_NAME_COLOR;
            var _local3:Object = new Object();
            _local3.color = OTHER_FRIENDS_COLOR;
            _local1.setStyle("a", _local3);
            _local1.setStyle(".friendName", _local2);
            return (_local1);
        }
        private function setupTextHoverClip():void{
            var _local1:String;
            var _local2:int;
            var _local3:int;
            var _local4:Sprite;
            this.content.description.selectable = false;
            if (this._msg.search("<a>") != -1){
                _local1 = this._msg.substring((this._msg.search("<a>") + 3), this._msg.search("</a>"));
                _local2 = this.content.description.text.indexOf(_local1);
                _local3 = (_local2 + _local1.length);
                _local4 = this.getCharacteRangeSprite(_local2, _local3);
                _local4.addEventListener(MouseEvent.ROLL_OVER, this.onFriendAnchorRollover, false, 0, true);
                _local4.addEventListener(MouseEvent.ROLL_OUT, this.onFriendAnchorRollout, false, 0, true);
                this.content.addChild(_local4);
                MCLinks(this._mcLinksTable[this.content]).linkHoverButton = _local4;
            };
        }
        private function getCharacteRangeSprite(_arg1:int, _arg2:int):Sprite{
            var _local5:Rectangle;
            var _local3:Sprite = new Sprite();
            _local3.graphics.beginFill(0xFF0000, 0);
            var _local4:int = _arg1;
            while (_local4 < _arg2) {
                _local5 = this.content.description.getCharBoundaries(_local4);
                _local3.graphics.drawRect((this.content.description.x + _local5.x), (this.content.description.y + _local5.y), _local5.width, _local5.height);
                _local4++;
            };
            _local3.graphics.endFill();
            _local3.useHandCursor = true;
            _local3.buttonMode = true;
            return (_local3);
        }
        private function onFriendAnchorRollover(_arg1:MouseEvent):void{
            this._friendCountRollover.dispatch(this._item.friends);
        }
        private function onFriendAnchorRollout(_arg1:MouseEvent):void{
            this._friendCountRollout.dispatch();
        }
        private function onRevealButtonClicked(_arg1:MouseEvent):void{
            this._bonusRevealed = true;
            this._revealButtonClick.dispatch();
        }
        private function onThankYouButtonClicked(_arg1:MouseEvent):void{
            var _local2:SimpleButton = (_arg1.currentTarget as SimpleButton);
            _local2.removeEventListener(MouseEvent.CLICK, this.onThankYouButtonClicked, false);
            this._friendThanked.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.whistleReport 

import flash.display.*;

class MCLinks {

    public var linkHoverButton:Sprite;
    public var otherFriends:Sprite;

    public function MCLinks(){
    }
}
