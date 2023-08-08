//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;

    public class RecurringPrizeClaimProcess extends GSIProcess {

		[Inject]
        public var server:GSIDataService;
		[Inject]
        public var model:InventoryModel;

        public function RecurringPrizeClaimProcess(){
            super("RecurringPrizeClaimProcess");
        }
        override protected function onInit():void{
            this.server.claimRecurringPrize(this);
        }
        override protected function parse(_arg1:Object):Boolean{
            var _local3:String;
            var _local4:InventoryItem;
            var _local5:uint;
            var _local2:Object = _arg1.success;
            for (_local3 in _local2) {
                _local4 = this.model.getItem(uint(_local3));
                _local5 = _local2[_local3].quantity;
                _local4.quantity = (_local4.quantity + _local5);
            };
            return (true);
        }

    }
}//package com.gaiaonline.monster.service.process 
