//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.inventory.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import flash.text.*;
    import gaia.moga.inventory.model.*;
    import alecmce.list.*;
    import alecmce.ui.radio.*;

    public class InventoryUIDatum implements ListDatum {

        public var item:InventoryItem;
        private var tf:TextField;
        private var _context:String;
        private var _selected:Signal;
        public var button:RadioButton;
        private var mc:MovieClip;

        public function InventoryUIDatum(_arg1:InventoryItem){
            this.item = _arg1;
            this.tf = new TextField();
            this.tf.defaultTextFormat = new TextFormat("_sans", 30, 0xFFFFFF);
            this.tf.selectable = false;
            this.tf.autoSize = TextFieldAutoSize.LEFT;
            this.tf.text = _arg1.type.id.toString();
            this._selected = new Signal(InventoryItem);
        }
        public function clear(_arg1:MovieClip):void{
            var _local3:DisplayObject;
            if (this.button){
                this.button.selected.remove(this.onSelected);
                this.button.isEnabled = false;
                this.button = null;
            };
            this.item.changed.remove(this.onItemChanged);
            var _local2:MovieClip = _arg1.container;
            while (_local2.numChildren) {
                _local3 = _local2.removeChildAt(0);
                _local3.x = (_local3.y = 0);
                _local3.scaleX = (_local3.scaleY = 1);
            };
            _arg1.total_items.visible = false;
            this.mc = null;
        }
        public function apply(_arg1:MovieClip):void{
            this.mc = _arg1;
            this.button = new RadioButton(_arg1, 1, 2, 2, 4, 3);
            this.button.isEnabled = this.item.type.isInContext(this._context);
            this.button.selected.add(this.onSelected);
            var _local2:DisplayObject = this.item.type.asset.self;
            _local2.x = (_local2.y = 30);
            _local2.scaleX = (_local2.scaleY = this.item.type.inventory.scale);
            var _local3:MovieClip = _arg1.container;
            _local3.addChild(this.item.type.asset.self);
            this.item.changed.add(this.onItemChanged);
            this.onItemChanged(this.item);
        }
        private function onItemChanged(_arg1:InventoryItem):void{
            this.mc.total_items.visible = (_arg1.quantity > 0);
            this.mc.total_items.num_items.text = _arg1.quantity.toString();
        }
        private function onSelected(_arg1:RadioButton):void{
            this._selected.dispatch(this.item);
        }
        public function get selected():ISignal{
            return (this._selected);
        }
        public function toString():String{
            return (this.item.type.name);
        }
        public function get context():String{
            return (this._context);
        }
        public function set context(_arg1:String):void{
            if (this._context == _arg1){
                return;
            };
            this._context = _arg1;
            if (this.button){
                this.button.isEnabled = (((this._context == "")) || (this.item.type.isInContext(this._context)));
            };
        }

    }
}//package gaia.moga.inventory.view.ui 
