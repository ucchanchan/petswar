//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims {
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import gaia.moga.inventory.model.*;

    public class UpdateInventoryAnim extends BasicAnim {

        private var inventory:InventoryModel;
        private var id:uint;
        private var quantity:int;

        public function UpdateInventoryAnim(_arg1:InventoryModel, _arg2:uint, _arg3:int){
            this.inventory = _arg1;
            this.id = _arg2;
            this.quantity = _arg3;
        }
        override public function play():void{
            var _local1:InventoryItem = this.inventory.getItem(this.id);
            _local1.quantity = (_local1.quantity + this.quantity);
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims 
