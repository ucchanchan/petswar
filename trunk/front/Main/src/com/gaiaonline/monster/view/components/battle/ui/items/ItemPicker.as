//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui.items {
    import flash.display.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import alecmce.ui.button.*;
    import gaia.moga.inventory.model.*;

    public class ItemPicker extends MovieClipButton {

        private var _assets:Vector.<ItemPickerElement>;
        private var _items:Vector.<InventoryItem>;
        private var _selected:Signal;
        private var _count:uint;

        private static const MAX:uint = 6;

        public function ItemPicker(_arg1:MovieClip){
            var _local2:int;
            super(_arg1);
            _arg1.mouseChildren = true;
            this._selected = new Signal();
            this._assets = new Vector.<ItemPickerElement>(MAX, true);
            var _local3:MovieClip = _ui.list;
            _local2 = 0;
            while (_local2 < MAX) {
                this._assets[_local2] = new ItemPickerElement(_local3[("item" + _local2)]);
                _local2++;
            };
        }
        public function set items(_arg1:Vector.<InventoryItem>):void{
            var _local3:int;
            var _local4:ItemPickerElement;
            var _local6:InventoryItem;
            if (this._items == _arg1){
                return;
            };
            this._items = _arg1;
            this._count = 0;
            var _local2:int = _arg1.length;
            _local3 = 0;
            while (_local3 < _local2) {
                _local6 = _arg1[_local3];
                if ((((((_local6.quantity == 0)) || (!(_local6.type)))) || ((_local6.type.context.indexOf("battle") == -1)))){
                } else {
                    _local4 = this._assets[this._count++];
                    _local4.setItem(this._items[_local3]);
                    _local4.clicked.add(this.onItemClicked);
                    _local4.zero.add(this.onItemZero);
                };
                _local3++;
            };
            var _local5:uint = this._count;
            while (_local5 < MAX) {
                _local4 = this._assets[_local5];
                _local4.clear();
                _local4.clicked.removeAll();
                _local5++;
            };
        }
        public function addItem(_arg1:InventoryItem):void{
            var _local2:ItemPickerElement = this._assets[this._count++];
            if (((!(_arg1.type)) || ((_arg1.type.context.indexOf("battle") == -1)))){
                return;
            };
            _local2.setItem(_arg1);
            _local2.clicked.add(this.onItemClicked);
        }
        private function onItemClicked(_arg1:ItemPickerElement):void{
            this._selected.dispatch(_arg1.item);
        }
        private function onItemZero(_arg1:ItemPickerElement):void{
            var _local4:ItemPickerElement;
            var _local2:int = this._assets.indexOf(_arg1);
            var _local3:ItemPickerElement = this._assets[_local2];
            while ((((++_local2 < this._count)) && (!((_local3.item == null))))) {
                _local4 = this._assets[_local2];
                _local3.clear();
                _local3 = _local4;
            };
            _local3.clear();
            _local3.clicked.remove(this.onItemClicked);
        }
        public function get selected():ISignal{
            return (this._selected);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui.items 
