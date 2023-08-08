//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.view {
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import com.gaiaonline.monster.events.*;
    import gaia.moga.friendlist.model.*;
    import com.gaiaonline.monster.view.components.starseedBasket.model.*;
    import gaia.moga.assets.*;
    import com.gaiaonline.monster.service.*;
    import alecmce.list.*;
    import org.robotlegs.mvcs.*;
    import com.gaiaonline.monster.view.components.starseedBasket.event.*;
    import com.gaiaonline.monster.view.components.starseedBasket.view.ui.giver.*;

    public class StarseedBasketGiverMediator extends Mediator {

        public var view:StarseedBasketGiverPanel;
        public var ranchModel:FriendRanchModel;
        public var friends:FriendsModel;
        public var fb:FBService;
        public var assetService:AssetService;
        public var textService:TextService;
        public var basketModel:StarseedBasketModel;
        public var timer:TimerService;
        private var _friend:Friend;

        override public function onRegister():void{
            this._friend = this.friends.getFriendByID(this.ranchModel.friendID);
            this.view.closeClick.addOnce(this.onCloseClick);
            this.view.giveStarseedClick.add(this.onGiveSeedClick);
            this.view.giveSeedResponse.add(this.onGiveSeedResponse);
            this.view.shareResponse.add(this.onShareResponse);
            this.view.friendName = this._friend.firstName;
            this.view.setGrantLimit(this.basketModel.grantLimit);
            this.view.canReceive = this.basketModel.friendBasket.canReceive;
            this.setHistory();
            this.setGiveable();
            this.basketModel.updated.add(this.onBasketUpdated);
            addContextListener(ApplicationEvent.SET_STATE, this.onApplicationStateChange, ApplicationEvent, false, 0, true);
        }
        private function onBasketUpdated():void{
            this.setHistory();
            this.setGiveable();
        }
        private function onApplicationStateChange(_arg1:ApplicationEvent):void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }
        private function setHistory():void{
            var _local3:String;
            var _local4:Friend;
            var _local5:uint;
            var _local6:uint;
            var _local7:FriendGiftEntry;
            var _local1:Object = this.basketModel.friendBasket.received;
            var _local2:Vector.<ListDatum> = new Vector.<ListDatum>();
            FriendGiftEntry.textService = this.textService;
            for (_local3 in _local1) {
                if (_local3 == this.friends.me.id){
                    _local4 = this.friends.me;
                } else {
                    _local4 = this.friends.getFriendByID(_local3);
                };
                if (_local4){
                    _local5 = uint(_local1[_local3].activity_bundle.avail);
                    _local6 = (this.timer.currentTime - uint(_local1[_local3].last_updated));
                    _local7 = new FriendGiftEntry(_local4, _local5, _local6);
                    _local2.push(_local7);
                };
            };
            this.view.setHistory(_local2);
        }
        private function setGiveable():void{
            this.view.canGiftFriend = this.basketModel.canGiftFriend();
            this.view.seedsAvailable = this.basketModel.availableGifts;
        }
        override public function onRemove():void{
            this.basketModel.updated.remove(this.onBasketUpdated);
            this.view.dispose();
            eventDispatcher.removeEventListener(ApplicationEvent.SET_STATE, this.onApplicationStateChange, false);
        }
        private function onCloseClick():void{
            dispatch(new PanelsEvent(PanelsEvent.REMOVE_OVERLAY, this.view));
        }
        private function onGiveSeedClick():void{
            this.view.showGiveMessage(true);
        }
        private function onGiveSeedResponse(_arg1:Boolean):void{
            var _local2:StarseedBasketEvent;
            this.view.showGiveMessage(false);
            if (_arg1){
                _local2 = new StarseedBasketEvent(StarseedBasketEvent.GIVE_STARSEED);
                _local2.data = this._friend.id;
                dispatch(_local2);
                this.view.showShareMessage(true);
            };
        }
        private function onShareResponse(_arg1:Boolean):void{
            this.view.showShareMessage(false);
            if (_arg1){
                this.publishSharePost();
            };
        }
        private function publishSharePost():void{
            var _local1:String = this.textService.getStarseedGiftMainMessage(this.friends.me.firstName, this._friend.firstName);
            var _local2:String = this.textService.getStarseedGiftSecondaryMessage(this.friends.me.firstName, this._friend.firstName);
            var _local3:String = this.assetService.starseedRequestIconString;
            this.fb.publishStarseedGiftNotice(this._friend.id, _local3, _local1, _local2);
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.view 
