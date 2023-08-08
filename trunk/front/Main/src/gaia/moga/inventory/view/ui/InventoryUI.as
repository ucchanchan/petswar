//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.inventory.view.ui {
    import flash.display.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.model.*;
    import __AS3__.vec.*;
    import alecmce.ui.button.*;
    import gaia.moga.inventory.model.*;
    import alecmce.list.*;
    import alecmce.grid.*;
    import alecmce.list.scrollbar.*;

    public class InventoryUI extends Sprite {

        private var asset:Asset;
        private var clip:MovieClip;
        private var grid:Grid;
        private var scrollbar:Scrollbar;
        private var _items:Vector.<InventoryItem>;
        private var _selected:InventoryItem;
        private var tabs:InventoryUITabs;
        private var getMoreButton:MovieClipButton;
        private var useItemButton:MovieClipButton;
        private var _getMore:Signal;
        private var _useItem:Signal;
        private var _context:String;
        private var _moga:MonsterModel;

        public static const HIDE_ITEMS_OUT_OF_CONTEXT:Boolean = true;

        public function InventoryUI(_arg1:Asset){
            this.asset = _arg1;
            _arg1.self.visible = false;
            addChild(_arg1.self);
            this._context = "";
            this.clip = (_arg1.content as MovieClip);
            this.init();
        }
        private function init():void{
            this.grid = new Grid(this.clip.grid, ListAxis.Y_AXIS);
            this.grid.itemCleared.add(this.onGridItemCleared);
            this.grid.itemDefined.add(this.onGridItemDefined);
            this.scrollbar = new VScrollbar(this.clip.scrollbar.handle, this.clip.scrollbar.container);
            this.tabs = new InventoryUITabs(this.clip.tabs);
            this.getMoreButton = new MovieClipButton(this.clip.get_more);
            this.getMoreButton.clicked.add(this.onGetMore);
            this.getMoreButton.isEnabled = false;
            this.useItemButton = new MovieClipButton(this.clip.use_button);
            this.useItemButton.clicked.add(this.onUseButton);
            this.useItemButton.isEnabled = false;
            this.clip.item_name.text = "";
            this.clip.item_description.text = "";
            this._getMore = new Signal(InventoryItem);
            this._useItem = new Signal(InventoryItem);
        }
        public function get isVisible():Boolean{
            return (this.asset.self.visible);
        }
        public function set isVisible(_arg1:Boolean):void{
            this.asset.self.visible = _arg1;
        }
        public function get getMore():Signal{
            return (this._getMore);
        }
        public function get useItem():Signal{
            return (this._useItem);
        }
        public function get items():Vector.<InventoryItem>{
            return (this._items);
        }
        public function set items(_arg1:Vector.<InventoryItem>):void{
            this._items = _arg1;
            this.grid.data = this.generateData(_arg1);
            this.scrollbar.setup(3, this.grid.max);
            this.scrollbar.isVisible = (this.grid.max > 3);
            if (this.scrollbar.isVisible){
                this.scrollbar.reposition.add(this.onReposition);
            } else {
                this.scrollbar.reposition.removeAll();
            };
        }
        public function get categories():Vector.<String>{
            return (this.tabs.categories);
        }
        public function set categories(_arg1:Vector.<String>):void{
            this.tabs.categories = _arg1;
        }
        public function get context():String{
            return (this._context);
        }
        public function set context(_arg1:String):void{
            var _local2:InventoryUIDatum;
            if (this._context == _arg1){
                return;
            };
            this._context = _arg1;
            if (HIDE_ITEMS_OUT_OF_CONTEXT){
                if (this._items){
                    this.grid.data = this.generateData(this._items);
                };
            } else {
                for each (_local2 in this.grid.data) {
                    _local2.context = this._context;
                };
            };
        }
        private function onGridItemCleared(_arg1:ListItem, _arg2:InventoryUIDatum):void{
            _arg2.selected.remove(this.onItemSelected);
        }
        private function onGridItemDefined(_arg1:ListItem, _arg2:InventoryUIDatum):void{
            _arg2.selected.add(this.onItemSelected);
        }
        private function onItemSelected(_arg1:InventoryItem):void{
            this._selected = _arg1;
            this.clip.item_name.text = _arg1.type.name;
            this.clip.item_description.text = _arg1.type.description;
            this.getMoreButton.isEnabled = true;
            this.useItemButton.isEnabled = true;
        }
        private function onReposition(_arg1:Number):void{
            this.grid.position = _arg1;
        }
        private function generateData(_arg1:Vector.<InventoryItem>):Vector.<ListDatum>{
            var _local4:InventoryItem;
            var _local5:InventoryUIDatum;
            var _local2:uint = _arg1.length;
            var _local3:Vector.<ListDatum> = new Vector.<ListDatum>();
            while (_local2--) {
                _local4 = _arg1[_local2];
                if (((HIDE_ITEMS_OUT_OF_CONTEXT) && ((((_local4.type == null)) || (!(_local4.type.isInContext(this._context))))))){
                } else {
                    _local5 = new InventoryUIDatum(_local4);
                    _local3.push(_local5);
                };
            };
            return (_local3);
        }
        private function onGetMore(_arg1:MovieClipButton):void{
            this._getMore.dispatch(this._selected);
        }
        private function onUseButton(_arg1:MovieClipButton):void{
            this._useItem.dispatch(this._selected, this._moga);
        }
        public function get moga():MonsterModel{
            return (this._moga);
        }
        public function set moga(_arg1:MonsterModel):void{
            this._moga = _arg1;
        }

    }
}//package gaia.moga.inventory.view.ui 
