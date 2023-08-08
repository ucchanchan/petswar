//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.inventory.model {
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import gaia.moga.items.model.*;
    import org.robotlegs.mvcs.*;

    public class InventoryModel extends Actor {

		[Inject]
        public var factory:ItemFactory;
        private var _items:Vector.<InventoryItem>;
        private var itemMap:Object;
        private var _added:Signal;

        public function InventoryModel():void{
            this._items = new Vector.<InventoryItem>();
            this.itemMap = {};
            this._added = new Signal(InventoryItem);
        }
        public function get items():Vector.<InventoryItem>{
            return (this._items);
        }
        public function get actualItems():Vector.<InventoryItem>{
            var _local1:Vector.<InventoryItem> = new Vector.<InventoryItem>();
            var _local2:uint = this._items.length;
            var _local3:int;
            while (_local3 < _local2) {
                if (this._items[_local3].quantity > 0){
                    _local1.push(this._items[_local3]);
                };
                _local3++;
            };
            return (_local1);
        }
        public function getItem(_arg1:uint):InventoryItem{
            var _local3:Item;
            var _local2:InventoryItem = this.itemMap[_arg1];
            if (!_local2){
                _local3 = this.factory.read(_arg1);
                _local2 = new InventoryItem(_local3, 0);
                this.itemMap[_arg1] = _local2;
                this._items.push(_local2);
                this._added.dispatch(_local2);
            };
            return (_local2);
        }
        public function setItem(_arg1:uint, _arg2:uint):void{
            var _local3:InventoryItem = this.getItem(_arg1);
            _local3.quantity = _arg2;
        }
        public function hasItem(_arg1:uint):Boolean{
            return (((this.getItem(_arg1)) && ((this.getItem(_arg1).quantity > 0))));
        }
        public function get added():ISignal{
            return (this._added);
        }

    }
}//package gaia.moga.inventory.model 
