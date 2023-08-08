//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.model {
    import flash.display.*;
    import alecmce.ui.*;
    import gaia.moga.friendlist.model.*;
    import flash.geom.*;
    import com.gaiaonline.monster.service.*;
    import alecmce.list.*;

    public class FriendGiftEntry implements ListDatum {

        private var _friend:Friend;
        private var _count:uint;
        private var _secondsSinceGift:uint;
        private var _mc:MovieClip;
        private var _mcLinks:FriendGiftMCLinks;

        private static const MINUTE:uint = 60;
        private static const HOUR:uint = 3600;
        private static const DAY:uint = 86400;

        public static var textService:TextService;

        public function FriendGiftEntry(_arg1:Friend, _arg2:uint, _arg3:uint){
            this._friend = _arg1;
            this._count = _arg2;
            this._secondsSinceGift = _arg3;
        }
        public function apply(_arg1:MovieClip):void{
            this.cleanupMC(_arg1);
            this.registerMC(_arg1);
            this.setupFriendPicture();
            this.setupDescriptionText();
        }
        public function clear(_arg1:MovieClip):void{
        }
        private function registerMC(_arg1:MovieClip):void{
            _arg1.__giftEntry = this;
            this._mc = _arg1;
            this._mc.friendPlacementHelper.visible = false;
            this._mcLinks = new FriendGiftMCLinks();
        }
        private function setupFriendPicture():void{
            if (this._friend.picture.isComplete){
                this.addFriendPicture(this._friend.picture);
            } else {
                this._friend.picture.complete.addOnce(this.addFriendPicture);
            };
        }
        private function setupDescriptionText():void{
            this._mc.detailField.text = (((this._friend.firstName + " left a starseed ") + this.getTimeSinceUpdate(this._secondsSinceGift)) + " ago");
        }
        private function cleanupMC(_arg1:MovieClip):void{
            var _local2:FriendGiftEntry;
            _arg1.detailField.text = "";
            if (_arg1.__giftEntry){
                _local2 = _arg1.__giftEntry;
                if (_local2._mc == _arg1){
                    _local2._mc = null;
                };
                if (_local2._mcLinks){
                    if (_local2._mcLinks.friendGraphic){
                        _arg1.friendImageHolder.removeChild(_local2._mcLinks.friendGraphic);
                    };
                };
            };
        }
        private function addFriendPicture(_arg1:Asset):void{
            var _local2:Rectangle = this._mc.friendPlacementHelper.getBounds(this._mc.friendImageHolder);
            var _local3:Bitmap = Utils.createBitmapFromDisplayObject(_arg1.self, _local2.width, _local2.height);
            _local3.x = _local2.x;
            _local3.y = _local2.y;
            this._mc.friendImageHolder.addChild(_local3);
        }
        public function toString():String{
            return (this._friend.firstName);
        }
        public function compareToOtherEntry(_arg1:FriendGiftEntry):int{
            if (this._secondsSinceGift < _arg1._secondsSinceGift){
                return (-1);
            };
            if (this._secondsSinceGift == _arg1._secondsSinceGift){
                return (0);
            };
            return (1);
        }
        private function getTimeSinceUpdate(_arg1:uint):String{
            var _local2:int = this._secondsSinceGift;
            var _local3:int = Math.floor((_local2 / DAY));
            if (_local3 == 0){
                _local3 = -1;
            };
            _local2 = (_local2 % DAY);
            var _local4:int = Math.floor((_local2 / HOUR));
            if ((((0 < _local3)) || ((_local4 == 0)))){
                _local4 = -1;
            };
            _local2 = (_local2 % HOUR);
            var _local5:int = Math.floor((_local2 / MINUTE));
            if ((((0 < _local3)) || ((1 < _local4)))){
                _local5 = -1;
            };
            if ((((((0 < _local3)) || ((0 < _local4)))) || ((9 < _local5)))){
                _local2 = -1;
            } else {
                _local2 = (_local2 % MINUTE);
            };
            return (textService.describeTime(_local3, _local4, _local5, _local2, true));
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.model 

import flash.display.*;

class FriendGiftMCLinks {

    public var friendGraphic:Bitmap;

    public function FriendGiftMCLinks(){
    }
}
