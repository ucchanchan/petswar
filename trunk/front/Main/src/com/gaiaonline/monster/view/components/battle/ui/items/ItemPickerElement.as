//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.ui.items {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.button.*;
    import flash.geom.*;
    import flash.text.*;
    import gaia.moga.inventory.model.*;
    import gaia.moga.items.model.*;

    public class ItemPickerElement extends MovieClipButton {

        private var _label:TextField;
        private var _count:MovieClip;
        private var _countLabel:TextField;
        private var icon:Bitmap;
        private var container:MovieClip;
        private var _item:InventoryItem;
        public var zero:Signal;
        private var _isUseable:Boolean;

        private static const ORIGIN:Point = new Point();

        public function ItemPickerElement(_arg1:MovieClip){
            super(_arg1);
            this.zero = new Signal(ItemPickerElement);
            _ui.useHandCursor = true;
            _ui.buttonMode = true;
            this._label = TextField(_ui.wrapper.label);
            this._count = _ui.count;
            this._countLabel = TextField(this._count.label);
            this.container = _ui.container.container;
            this.icon = (this.container.getChildByName("bitmap") as Bitmap);
            if (!this.icon){
                this.icon = new Bitmap(new BitmapData(60, 60, true, 0));
                this.icon.name = "bitmap";
                this.container.addChild(this.icon);
            };
            isEnabled = false;
            if (this._item){
                this.populateUI();
            } else {
                this.clearUI();
            };
        }
        public function setItem(_arg1:InventoryItem):void{
            if (this._item == _arg1){
                return;
            };
            if (this._item){
                this._item.changed.remove(this.onItemCountUpdate);
            };
            this._item = _arg1;
            this._isUseable = false;
            if (((this._item) && (this._item.type))){
                this._item.changed.add(this.onItemCountUpdate);
                this._isUseable = this._item.type.isUseable;
                this.populateUI();
            };
        }
        public function get item():InventoryItem{
            return (this._item);
        }
        public function clear():void{
            this.setItem(null);
            this.clearUI();
            isEnabled = false;
        }
        private function populateUI():void{
            var _local1:Item = this._item.type;
            this.clearUI();
            isEnabled = ((((this._isUseable) && (this._item))) && ((this._item.quantity > 0)));
            if (!isEnabled){
                return;
            };
            this._label.text = _local1.name;
            this._count.visible = true;
            this._countLabel.text = this._item.quantity.toString();
            if (_local1.isComplete){
                this.displayIcon(_local1);
            } else {
                if (_local1.isError){
                    this.cancelIcon(_local1);
                } else {
                    _local1.complete.addOnce(this.displayIcon);
                    _local1.error.addOnce(this.cancelIcon);
                    _local1.init();
                };
            };
        }
        private function displayIcon(_arg1:Item):void{
            this._item.type.error.remove(this.cancelIcon);
            this.container.visible = true;
            var _local2:BitmapData = this.icon.bitmapData;
            var _local3:BitmapData = this._item.type.icon;
            _local2.fillRect(_local2.rect, 0);
            _local2.copyPixels(_local3, _local3.rect, ORIGIN, null, null, true);
        }
        private function cancelIcon(_arg1:Item, _arg2:String=""):void{
            this._item.type.complete.remove(this.displayIcon);
            this.clearUI();
        }
        private function clearUI():void{
            this._label.text = "";
            this._count.visible = false;
            this.container.visible = false;
            var _local1:BitmapData = this.icon.bitmapData;
            _local1.lock();
            _local1.fillRect(_local1.rect, 0);
            _local1.unlock();
        }
        private function onItemCountUpdate(_arg1:InventoryItem):void{
            var _local2:int;
            _local2 = this._item.quantity;
            this._count.visible = (_local2 > 1);
            this._countLabel.text = _local2.toString();
            isEnabled = (_local2 > 0);
            if (_local2 == 0){
                this.zero.dispatch(this);
            };
        }

    }
}//package com.gaiaonline.monster.view.components.battle.ui.items 
