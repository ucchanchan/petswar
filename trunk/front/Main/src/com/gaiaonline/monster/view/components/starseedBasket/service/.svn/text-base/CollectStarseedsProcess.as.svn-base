//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.service {
    import flash.events.*;
    import com.gaiaonline.monster.events.*;
    import com.gaiaonline.monster.view.components.starseedBasket.model.*;
    import com.gaiaonline.monster.service.process.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;
    import gaia.moga.*;

    public class CollectStarseedsProcess extends GSIProcess {

        public var inventoryModel:InventoryModel;
        public var dispatcher:IEventDispatcher;
        public var basketModel:StarseedBasketModel;
        public var outputData:Object;

        public function CollectStarseedsProcess(){
            super("CollectStarseedsProcess");
        }
        override protected function parse(_arg1:Object):Boolean{
            if (_arg1.error){
                this.dispatcher.dispatchEvent(new CatastrophicErrorEvent(CatastrophicErrorEvent.ERROR, Errors.SERVER_REPORTED_ERROR_WHILE_COLLECTING_STARSEEDS_FROM_BASKET));
                return (false);
            };
            this.updateStarseedCount();
            return (true);
        }
        private function updateStarseedCount():void{
            var _local1:InventoryItem = this.inventoryModel.getItem(ItemEnum.SEED);
            _local1.quantity = (_local1.quantity + this.getAddedSeedCount());
            this.basketModel.markCollected(this.outputData);
        }
        private function getAddedSeedCount():uint{
            var _local2:uint;
            var _local1:uint;
            for each (_local2 in this.outputData) {
                _local1 = (_local1 + _local2);
            };
            return (_local1);
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.service 
