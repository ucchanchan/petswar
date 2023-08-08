//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.model {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import gaia.moga.friendlist.model.*;
    import flash.geom.*;
    import com.gaiaonline.monster.service.*;
    import alecmce.list.*;

    public class FriendWithSeedEntry implements ListDatum {

        private var _friend:Friend;
        private var _friendGraphic:Bitmap;
        private var _mc:MovieClip;
        private var _postOnWallClick:Signal;

        public function FriendWithSeedEntry(_arg1:Friend){
            this._friend = _arg1;
            this._postOnWallClick = new Signal();
        }
        public function get postOnWallClick():Signal{
            return (this._postOnWallClick);
        }
        public function clear(_arg1:MovieClip):void{
            _arg1.nameField.text = "";
            this._mc = null;
            if (this._friendGraphic){
                _arg1.friendImageHolder.removeChild(this._friendGraphic);
            };
            _arg1.postOnWallButton.removeEventListener(MouseEvent.CLICK, this.onPostOnWallClick, false);
            this._friend.picture.complete.remove(this.addFriendPicture);
        }
        public function apply(_arg1:MovieClip):void{
            this._mc = _arg1;
            _arg1.friendPlacementHelper.visible = false;
            _arg1.nameField.text = this._friend.name;
            this.setupFriendPicture();
            _arg1.postOnWallButton.addEventListener(MouseEvent.CLICK, this.onPostOnWallClick, false, 0, true);
        }
        private function setupFriendPicture():void{
            if (this._friend.picture.isComplete){
                this.addFriendPicture(this._friend.picture);
            } else {
                this._friend.picture.complete.addOnce(this.addFriendPicture);
            };
        }
        private function addFriendPicture(_arg1:Asset):void{
            var _local2:Rectangle = this._mc.friendPlacementHelper.getBounds(this._mc.friendImageHolder);
            if (this._friendGraphic == null){
                this._friendGraphic = Utils.createBitmapFromDisplayObject(_arg1.self, _local2.width, _local2.height);
            };
            this._friendGraphic.x = _local2.x;
            this._friendGraphic.y = _local2.y;
            this._mc.friendImageHolder.addChild(this._friendGraphic);
        }
        private function onPostOnWallClick(_arg1:MouseEvent):void{
            this._postOnWallClick.dispatch(this._friend);
        }
        public function toString():String{
            return (this._friend.name);
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.model 
