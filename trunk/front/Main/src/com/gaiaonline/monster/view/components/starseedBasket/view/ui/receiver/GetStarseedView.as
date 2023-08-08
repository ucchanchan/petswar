//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.view.ui.receiver {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import alecmce.list.*;
    import com.gaiaonline.monster.view.components.starseedBasket.view.ui.*;
    import gaia.lib.ui.*;

    public class GetStarseedView extends InnerPanel {

        private var _noFriends:MovieClip;
        private var _withFriends:MovieClip;
        private var _friendsList:List;
        private var _scrollBar:VScrollBar;
        private var _inviteClick:Signal;
        private var _visitSkyShopClick:Signal;

        private static const MAX_VIEWABLE_FRIENDS:uint = 4;

        public function GetStarseedView(_arg1:MovieClip, _arg2:MovieClip){
            this._inviteClick = new Signal();
            this._visitSkyShopClick = new Signal();
            this.setupNoFriendsView(_arg1);
            this.setupWithFriendsView(_arg2);
            super(_arg1);
        }
        public function get inviteClick():Signal{
            return (this._inviteClick);
        }
        public function get visitSkyShopClick():Signal{
            return (this._visitSkyShopClick);
        }
        public function setFriendsWithSeeds(_arg1:Vector.<ListDatum>, _arg2:int):void{
            this._noFriends.visible = (((0 == _arg1.length)) && (visible));
            this._withFriends.visible = (((0 < _arg1.length)) && (visible));
            if (0 < _arg1.length){
                _arg1.sort(Array.CASEINSENSITIVE);
                this._friendsList.data = _arg1;
                this._scrollBar.setup(MAX_VIEWABLE_FRIENDS, _arg1.length);
                this._scrollBar.isVisible = (MAX_VIEWABLE_FRIENDS < _arg1.length);
                _asset = this._withFriends;
                _asset.subHeadingField.text = (((("Each of your friends can give out " + _arg2) + " free Starseed") + ((1 < _arg2)) ? "s" : "") + " per day. These friends have seeds available:");
            } else {
                _asset = this._noFriends;
            };
        }
        override public function dispose(_arg1:Boolean=true):void{
            this._scrollBar.reposition.remove(this.onScrollbarReposition);
            this._withFriends = null;
            this._noFriends.visitSkyShopButton.removeEventListener(MouseEvent.CLICK, this.onVisitSkyShopClick, false);
            this._noFriends.inviteFriendsButton.removeEventListener(MouseEvent.CLICK, this.onInviteFriendsClick, false);
            this._noFriends = null;
            this._inviteClick.removeAll();
            this._inviteClick = null;
            this._visitSkyShopClick.removeAll();
            this._visitSkyShopClick = null;
        }
        private function setupNoFriendsView(_arg1:MovieClip):void{
            this._noFriends = _arg1;
            this._noFriends.visitSkyShopButton.addEventListener(MouseEvent.CLICK, this.onVisitSkyShopClick, false, 0, true);
            this._noFriends.inviteFriendsButton.addEventListener(MouseEvent.CLICK, this.onInviteFriendsClick, false, 0, true);
        }
        private function onVisitSkyShopClick(_arg1:MouseEvent):void{
            this._visitSkyShopClick.dispatch();
        }
        private function onInviteFriendsClick(_arg1:MouseEvent):void{
            this._inviteClick.dispatch();
        }
        private function setupWithFriendsView(_arg1:MovieClip):void{
            this._withFriends = _arg1;
            this._withFriends.visible = false;
            this.setupList();
        }
        private function setupList():void{
            this._friendsList = new List(this._withFriends.friendCells);
            this._scrollBar = new VScrollBar(this._withFriends.scrollThumb, this._withFriends.scrollTrack);
            this._scrollBar.reposition.add(this.onScrollbarReposition);
            this._scrollBar.isVisible = false;
        }
        private function onScrollbarReposition(_arg1:Number):void{
            this._friendsList.position = _arg1;
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.view.ui.receiver 
