//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.collections.view {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import gaia.moga.collections.model.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import alecmce.ui.button.*;
    import flash.geom.*;
    import flash.text.*;
    import alecmce.list.*;
    import gaia.lib.ui.*;

    public class CollectionsManagementPanel extends Panel {

        private var _asset:Asset;
        private var _closeClick:Signal;
        private var _content:MovieClip;
        private var _closeButton:MovieClipButton;
        private var _nameSortButton:MovieClipButton;
        private var _progressSortButton:MovieClipButton;
        private var _progressSortClick:Signal;
        private var _nameSortClick:Signal;
        private var _list:List;
        private var _scrollBar:VScrollBar;
        private var _data:Vector.<MogaCollectionDatum>;
        private var _defaultSortSetting:Function;
        private var _buttonDatumTable:Dictionary;
        private var _listItemButtonTable:Dictionary;
        private var _listItemDatumTable:Dictionary;
        private var _tradeContainerItemTable:Dictionary;
        private var _tradeButtonClick:Signal;
        private var _tradeContainerRollover:Signal;
        private var _tradeContainerRollout:Signal;

        private static const MAX_VIEWABLE_COLLECTIONS:Number = 3.5;

        public function CollectionsManagementPanel(_arg1:Asset){
            this._asset = _arg1;
            this._closeClick = new Signal();
            this._progressSortClick = new Signal();
            this._nameSortClick = new Signal();
            this._tradeButtonClick = new Signal(MogaCollectionDatum);
            this._buttonDatumTable = new Dictionary();
            this._listItemButtonTable = new Dictionary();
            this._listItemDatumTable = new Dictionary();
            this._tradeContainerItemTable = new Dictionary();
            this._tradeContainerRollover = new Signal(ListItem, MogaCollectionDatum);
            this._tradeContainerRollout = new Signal();
        }
        public function get tradeButtonClick():Signal{
            return (this._tradeButtonClick);
        }
        public function get tradeContainerRollover():Signal{
            return (this._tradeContainerRollover);
        }
        public function get tradeContainerRollout():Signal{
            return (this._tradeContainerRollout);
        }
        public function get closeClick():Signal{
            return (this._closeClick);
        }
        public function get progressSortClick():Signal{
            return (this._progressSortClick);
        }
        public function get nameSortClick():Signal{
            return (this._nameSortClick);
        }
        override public function setup():void{
            addChild(this._asset.self);
            this._content = MovieClip(this._asset.content["collectionsManager"]);
            this._content.tooltip.visible = false;
            this.setupButtons();
            this.setupList();
        }
        override public function dispose(_arg1:Boolean=true):void{
            var _local2:*;
            var _local3:*;
            var _local4:*;
            var _local5:MovieClipButton;
            this._closeButton.clicked.remove(this.onCloseClick);
            this._closeButton = null;
            this._progressSortButton.clicked.remove(this.onProgressSortClick);
            this._progressSortButton = null;
            this._nameSortButton.clicked.remove(this.onNameSortClick);
            this._nameSortButton = null;
            this._scrollBar.reposition.remove(this.onScrollReposition);
            this._scrollBar = null;
            this._list = null;
            for (_local2 in this._buttonDatumTable) {
                delete this._buttonDatumTable[_local2];
            };
            for (_local2 in this._listItemDatumTable) {
                delete this._listItemDatumTable[_local2];
            };
            for (_local3 in this._tradeContainerItemTable) {
                _local3.removeEventListener(MouseEvent.MOUSE_OVER, this.onListItemTradeRollover, false);
                delete this._tradeContainerItemTable[_local2];
            };
            for (_local4 in this._listItemButtonTable) {
                ListItem(_local4).defined.remove(this.onItemDefined);
                _local5 = this._listItemButtonTable[_local4];
                _local5.clicked.remove(this.onTradeButtonClick);
                delete this._listItemButtonTable[_local4];
            };
        }
        public function setCollectionsData(_arg1:Vector.<MogaCollectionDatum>):void{
            if (this._list){
                this._list.data = Vector.<ListDatum>(_arg1);
            };
            if (this._scrollBar){
                this._scrollBar.setup(MAX_VIEWABLE_COLLECTIONS, _arg1.length);
                this._scrollBar.isVisible = (MAX_VIEWABLE_COLLECTIONS < _arg1.length);
            };
            this._data = _arg1;
        }
        public function updateCollectionsData(_arg1:Vector.<MogaCollectionVO>):void{
            var _local2:MogaCollectionDatum;
            var _local3:int;
            for each (_local2 in this._list.data) {
                _local3 = _arg1.indexOf(_local2.collection);
                if (-1 < _local3){
                    _local2.update();
                    this.updateDatumButton(_local2);
                };
            };
        }
        private function updateDatumButton(_arg1:MogaCollectionDatum):void{
            var _local3:*;
            var _local2 = (_arg1.progress == 1);
            for (_local3 in this._buttonDatumTable) {
                if (this._buttonDatumTable[_local3] == _arg1){
                    MovieClipButton(_local3).isEnabled = _local2;
                    return;
                };
            };
        }
        public function selectProgressSort():void{
            if (this._progressSortButton){
                this._progressSortButton.isEnabled = false;
                this._nameSortButton.isEnabled = true;
            } else {
                this._defaultSortSetting = this.selectProgressSort;
            };
        }
        public function selectNameSort():void{
            if (this._progressSortButton){
                this._progressSortButton.isEnabled = true;
                this._nameSortButton.isEnabled = false;
            } else {
                this._defaultSortSetting = this.selectNameSort;
            };
        }
        private function setupButtons():void{
            this._closeButton = new MovieClipButton(this._content.closeButton);
            this._closeButton.clicked.addOnce(this.onCloseClick);
            this._progressSortButton = new MovieClipButton(this._content.progressButton);
            this._progressSortButton.clicked.add(this.onProgressSortClick);
            this._nameSortButton = new MovieClipButton(this._content.nameButton);
            this._nameSortButton.clicked.add(this.onNameSortClick);
            if (this._defaultSortSetting != null){
                this._defaultSortSetting();
            };
        }
        private function setupList():void{
            var _local1:ListItem;
            this._list = new List(this._content.collectionCells);
            for each (_local1 in this._list.items) {
                this.setupListItem(_local1);
            };
            this._scrollBar = new VScrollBar(this._content.scrollbar.thumb, this._content.scrollbar.track);
            this._scrollBar.reposition.add(this.onScrollReposition);
            if (this._data){
                this.setCollectionsData(this._data);
            };
        }
        private function setupListItem(_arg1:ListItem):void{
            _arg1.defined.add(this.onItemDefined);
            _arg1.mc.tradeItemContainer.mouseChildren = false;
            _arg1.mc.tradeItemContainer.addEventListener(MouseEvent.MOUSE_OVER, this.onListItemTradeRollover, false, 0, true);
            this._tradeContainerItemTable[_arg1.mc.tradeItemContainer] = _arg1;
            var _local2:MovieClipButton = new MovieClipButton(_arg1.mc.tradeButton);
            _local2.clicked.add(this.onTradeButtonClick);
            this._listItemButtonTable[_arg1] = _local2;
        }
        private function onListItemTradeRollover(_arg1:MouseEvent):void{
            _arg1.currentTarget.addEventListener(MouseEvent.MOUSE_OUT, this.onListItemTradeRollout, false, 0, true);
            var _local2:ListItem = this._tradeContainerItemTable[_arg1.currentTarget];
            var _local3:MogaCollectionDatum = this._listItemDatumTable[_local2];
            this._tradeContainerRollover.dispatch(_local2, _local3);
        }
        public function showTooltip():void{
            this._content.tooltip.visible = true;
        }
        public function hideTooltip():void{
            this._content.tooltip.visible = false;
        }
        public function updateTooltip(_arg1:ListItem, _arg2:String, _arg3:uint, _arg4:String, _arg5:uint, _arg6:Bitmap, _arg7:String):void{
            var _local8:Rectangle = _arg1.mc.getBounds(this._content);
            this._content.tooltip.y = _local8.y;
            var _local9:TextFormat = new TextFormat(null, null, _arg5, true);
            this._content.tooltip.nameField.text = _arg2;
            this._content.tooltip.levelField.text = ("Lvl " + _arg3);
            this._content.tooltip.rarityField.text = _arg4;
            TextField(this._content.tooltip.rarityField).setTextFormat(_local9);
            this._content.tooltip.descriptionField.text = _arg7;
            while (0 < this._content.tooltip.symbolHolder.numChildren) {
                this._content.tooltip.symbolHolder.removeChildAt(0);
            };
            this._content.tooltip.symbolHolder.addChild(_arg6);
        }
        private function onListItemTradeRollout(_arg1:MouseEvent):void{
            _arg1.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT, this.onListItemTradeRollout, false);
            this._tradeContainerRollout.dispatch();
        }
        private function onItemDefined(_arg1:ListItem, _arg2:MogaCollectionDatum):void{
            this._listItemDatumTable[_arg1] = _arg2;
            var _local3:MovieClipButton = this._listItemButtonTable[_arg1];
            _local3.isEnabled = (_arg2.progress == 1);
            this._buttonDatumTable[_local3] = _arg2;
        }
        private function onTradeButtonClick(_arg1:MovieClipButton):void{
            _arg1.isEnabled = false;
            var _local2:MogaCollectionDatum = this._buttonDatumTable[_arg1];
            this._tradeButtonClick.dispatch(_local2);
        }
        private function onScrollReposition(_arg1:Number):void{
            this._list.position = _arg1;
        }
        private function onCloseClick(_arg1:MovieClipButton):void{
            this._closeClick.dispatch();
        }
        private function onProgressSortClick(_arg1:MovieClipButton):void{
            this._progressSortClick.dispatch();
        }
        private function onNameSortClick(_arg1:MovieClipButton):void{
            this._nameSortClick.dispatch();
        }

    }
}//package gaia.moga.collections.view 
