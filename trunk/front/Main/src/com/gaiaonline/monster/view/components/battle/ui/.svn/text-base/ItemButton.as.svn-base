//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui {
    import flash.display.*;
    import gaia.moga.inventory.model.*;

    public class ItemButton extends IconButton {

        private var _item:InventoryItem;

        public function ItemButton(_arg1:MovieClip){
            super(_arg1);
            if (_arg1.toolTip){
                _arg1.toolTip.mouseEnabled = false;
                _arg1.toolTip.mouseChildren = false;
            };
        }
        public function get item():InventoryItem{
            return (this._item);
        }
        public function set item(_arg1:InventoryItem):void{
            if (this._item == _arg1){
                return;
            };
            this._item = _arg1;
            if (this._item){
                this._item.changed.add(this.updateQuantity);
            };
            this.updateQuantity(this._item);
        }
        protected function updateQuantity(_arg1:InventoryItem):void{
            points = (_arg1) ? _arg1.quantity.toString() : "0";
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui 
