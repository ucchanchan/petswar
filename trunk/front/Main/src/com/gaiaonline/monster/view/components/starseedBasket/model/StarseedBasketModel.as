//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.model {
    import com.gaiaonline.monster.model.*;
    import com.gaiaonline.monster.service.*;

    public class StarseedBasketModel extends StarseedBasketVO {

        public var timer:TimerService;
        public var playerModel:PlayerModel;
        private var _currentFriend:StarseedBasketVO;

        private static const DELAY_TO_NEXT_GIFT:int = 72000;

        public function StarseedBasketModel(){
            this._currentFriend = new StarseedBasketVO();
            this._currentFriend.updated.add(this.onFriendBasketUpdated);
        }
        public function get friendBasket():StarseedBasketVO{
            return (this._currentFriend);
        }
        public function initFriend(_arg1:Object):void{
            this._currentFriend.init(_arg1);
        }
        public function canGiftFriend():Boolean{
            var _local1:String;
            var _local2:int;
            var _local3:int;
            if (!this.friendBasket.canReceive){
                return (false);
            };
            for (_local1 in this._currentFriend.received) {
                if (_local1 == this.playerModel.id){
                    _local2 = (this.timer.currentTime - DELAY_TO_NEXT_GIFT);
                    _local3 = this._currentFriend.received[_local1].last_updated;
                    return ((_local3 < _local2));
                };
            };
            return (true);
        }
        public function giveFriendSeed(_arg1:String):void{
            _currentGifts.push(_arg1);
            this._currentFriend.updated.remove(this.onFriendBasketUpdated);
            this._currentFriend.addGiftFromFriend(this.playerModel.id, this.timer.currentTime);
            this._currentFriend.updated.add(this.onFriendBasketUpdated);
            if (--_availableGifts == 0){
                _canGift = false;
                _canGiftOn = uint((this.timer.currentTime + TimerService.DAY)).toString(10);
            };
            _updated.dispatch();
        }
        private function onFriendBasketUpdated():void{
            _updated.dispatch();
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.model 
