//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.inventory.model {
    import org.osflash.signals.*;
    import gaia.moga.items.model.*;

    public class InventoryItem {

        private var _type:Item;
        private var _quantity:int;
        private var _changed:Signal;

        public function InventoryItem(_arg1:Item, _arg2:uint){
            this._type = _arg1;
            this._quantity = _arg2;
			//未解决的错误
            this._changed = new Signal(InventoryItem);
        }
        public function get type():Item{
            return (this._type);
        }
        public function get quantity():int{
            return (this._quantity);
        }
        public function set quantity(_arg1:int):void{
            if (_arg1 < 0){
                _arg1 = 0;
            };
            if (this._quantity == _arg1){
                return;
            };
            this._quantity = _arg1;
            this._changed.dispatch(this);
        }
        public function get changed():ISignal{
            return (this._changed);
        }

    }
}//package gaia.moga.inventory.model 
