//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.service.process {
    import com.gaiaonline.monster.model.vo.*;
    import com.gaiaonline.monster.model.*;
    import gaia.moga.monster.model.*;
    import com.gaiaonline.monster.service.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;

    public class RetrieveRIGItemProcess extends GSIProcess {

        public var server:GSIDataService;
        public var model:ApplicationModel;
        public var inventoryModel:InventoryModel;
        public var grantModel:ItemGrantModel;
        public var ranch:HomeRanchModel;
        public var mogas:MogaFactory;

        public function RetrieveRIGItemProcess(){
            super("RetrieveRIGItemProcess");
        }
        override protected function onInit():void{
            this.server.openRIG(this, ItemEnum.DAILY_PRIZE);
        }
        override protected function parse(_arg1:Object):Boolean{
            var _local3:String;
            var _local4:Object;
            var _local5:InventoryItem;
            var _local6:MonsterModel;
            var _local2 = !((_arg1.success == null));
            if (_local2){
                for (_local3 in _arg1.success) {
                    if (_local3 != "quantity"){
                        _local4 = _arg1.success[_local3];
                    };
                };
                if ((((((_local4.type == "1")) || ((_local4.type == "2")))) || ((_local4.type == "3")))){
                    this.grantModel.type = ItemGrantType.BASIC_ITEM;
                    this.grantModel.id = _local4.id;
                    _local5 = this.inventoryModel.getItem(_local4.id);
                    this.inventoryModel.getItem(_local4.id).quantity = (_local5.quantity + int(_arg1.success.quantity));
                } else {
                    this.grantModel.type = ItemGrantType.MONSTER;
                    _local6 = this.mogas.create(_local4);
                    this.ranch.addMonster(_local6);
                    this.grantModel.id = _local4.monster_id;
                };
                this.grantModel.name = _local4.name;
                if (_arg1.success.quantity){
                    this.grantModel.quantity = int(_arg1.success.quantity);
                } else {
                    this.grantModel.quantity = 1;
                };
            };
            return (true);
        }

    }
}//package com.gaiaonline.monster.service.process 
