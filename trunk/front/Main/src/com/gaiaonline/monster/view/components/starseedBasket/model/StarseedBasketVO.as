//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.model {
    import org.osflash.signals.*;
    import org.robotlegs.mvcs.*;

    public class StarseedBasketVO extends Actor {

        private var _grantLimit:uint;
        protected var _canGift:Boolean;
        protected var _canGiftOn:String;
        protected var _availableGifts:uint;
        protected var _received:Object;
        protected var _currentGifts:Array;
        protected var _updated:Signal;
        protected var _canReceive:Boolean;
        protected var _receiveLimit:uint;

        public function StarseedBasketVO(){
            this._updated = new Signal();
        }
        public function get updated():Signal{
            return (this._updated);
        }
        public function get grantLimit():uint{
            return (this._grantLimit);
        }
        public function get canGift():Boolean{
            return (this._canGift);
        }
        public function get canGiftOn():String{
            return (this._canGiftOn);
        }
        public function get availableGifts():uint{
            return (this._availableGifts);
        }
        public function get canReceive():Boolean{
            return (this._canReceive);
        }
        public function get receiveLimit():uint{
            return (this._receiveLimit);
        }
        public function get currentGifts():Array{
            if (this._currentGifts == null){
                this._currentGifts = [];
            };
            return (this._currentGifts.slice());
        }
        public function get received():Object{
            if (this._received == null){
                this._received = {};
            };
            return (this._received);
        }
        public function get receivedCount():uint{
            var _local2:String;
            var _local1:uint;
            for (_local2 in this.received) {
                _local1 = (_local1 + uint(this.received[_local2].activity_bundle.avail));
            };
            return (_local1);
        }
        public function addGiftFromFriend(_arg1:String, _arg2:uint):void{
            if (this.received[_arg1] == null){
                this.received[_arg1] = {};
                this.received[_arg1].activity_bundle = {};
                this.received[_arg1].activity_bundle.avail = 0;
            };
            this.received[_arg1].activity_bundle.avail++;
            this.received[_arg1].last_updated = _arg2.toString(10);
            this._updated.dispatch();
        }
        public function markCollected(_arg1:Object):void{
            var _local2:String;
            var _local3:Object;
            for (_local2 in _arg1) {
                _local3 = this.received[_local2];
                _local3.activity_bundle.avail = (_local3.activity_bundle.avail - uint(_arg1[_local2]));
            };
            this._updated.dispatch();
        }
        public function init(_arg1:Object):void{
            this._grantLimit = _arg1.grant_limit;
            this._canGift = Boolean(_arg1.can_gift);
            this._canGiftOn = _arg1.can_gift_on;
            this._availableGifts = _arg1.avail_gifts;
            this._received = _arg1.available;
            this._currentGifts = _arg1.current_gifts;
            if (_arg1.can_receive){
                this._canReceive = _arg1.can_receive;
            };
            if (_arg1.receive_limit){
                this._receiveLimit = _arg1.receive_limit;
            };
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.model 
