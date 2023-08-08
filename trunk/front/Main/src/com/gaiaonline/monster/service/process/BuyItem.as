//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.service.*;

    public class BuyItem extends GSIProcess {

        public var server:GSIDataService;
        public var id:uint;
        public var quantity:uint;
        public var cost:int;

        public function BuyItem(){
            super("BuyItem");
        }
        override protected function onInit():void{
            this.server.makePremiumCurrencyPurchase(this, this.id, this.quantity);
        }
        override protected function parse(_arg1:Object):Boolean{
            var data = _arg1;
            var isSuccess:Boolean;
            try {
                this.id = data.success.id;
                this.quantity = int(data.success.quantity);
                this.cost = data.success.cost;
            } catch(error:Error) {
                isSuccess = false;
            } finally {
                var _local5:* = isSuccess;
                //unresolved jump
                1;
                return (_local5);
            };
        }

    }
}//package com.gaiaonline.monster.service.process 
