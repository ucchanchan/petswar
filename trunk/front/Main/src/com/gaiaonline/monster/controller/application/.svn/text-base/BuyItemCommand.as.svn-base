//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.controller.application {
    import com.gaiaonline.monster.model.*;
    import alecmce.async.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.inventory.model.*;
    import com.gaiaonline.monster.controller.*;

    public class BuyItemCommand extends AsyncCommand {

        public var event:StoreEvent;
        public var process:BuyItem;
        public var inventory:InventoryModel;
        public var player:PlayerModel;

        override public function execute():void{
            this.process.id = this.event.id;
            this.process.quantity = this.event.qty;
            hook(this.process, this.onComplete, this.onError);
        }
        private function onComplete(_arg1:Async):void{
            var _local2:uint = this.process.id;
            var _local3:uint = this.process.quantity;
            var _local4:uint = this.process.cost;
            var _local5:InventoryItem = this.inventory.getItem(_local2);
            this.inventory.getItem(_local2).quantity = (_local5.quantity + _local3);
            this.player.premiumCurrency = (this.player.premiumCurrency - _local4);
            dispatch(new StoreEvent(StoreEvent.BUY_ITEM_SUCCESS));
        }
        private function onError(_arg1:Async, _arg2:String=""):void{
            dispatch(new StoreEvent(StoreEvent.BUY_ITEM_FAIL));
        }

    }
}//package com.gaiaonline.monster.controller.application 
