//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.grid {
    import flash.display.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;
    import alecmce.list.*;

    public class Grid {

        private var container:MovieClip;
        private var _axis:ListAxis;
        private var property:String;
        private var _grid:Vector.<Vector.<ListItem>>;
        private var columns:uint;
        private var rows:uint;
        private var _max:uint;
        private var basePosition:int;
        private var _itemOrigin:int;
        private var _itemSpacing:int;
        private var _data:Vector.<ListDatum>;
        private var dataLength:Number;
        private var _position:Number;
        private var _index:int;
        private var _dataChanged:Signal;
        private var _itemCleared:Signal;
        private var _itemDefined:Signal;
        private var updateItems:Function;

        public function Grid(_arg1:MovieClip, _arg2:ListAxis){
            this.container = _arg1;
            this._axis = _arg2;
			//未解决的错误
            this._dataChanged = new Signal();
            this._itemCleared = new Signal(ListItem, ListDatum);
            this._itemDefined = new Signal(ListItem, ListDatum);
            this.init();
        }
        public function get axis():ListAxis{
            return (this._axis);
        }
        public function get grid():Vector.<Vector.<ListItem>>{
            return (this._grid);
        }
        public function set data(_arg1:Vector.<ListDatum>):void{
            if (this._data == _arg1){
                return;
            };
            this._data = _arg1;
            this.dataLength = this._data.length;
            switch (this._axis){
                case ListAxis.X_AXIS:
                    this._max = Math.ceil((this.dataLength / this.rows));
                    break;
                case ListAxis.Y_AXIS:
                    this._max = Math.ceil((this.dataLength / this.columns));
                    break;
            };
            this.updateItems();
            this._dataChanged.dispatch(this);
        }
        public function get data():Vector.<ListDatum>{
            return (this._data);
        }
        public function set position(_arg1:Number):void{
            this._position = ((_arg1)!=_arg1) ? 0 : _arg1;
            this.container[this.property] = (this.basePosition - (this._position * this._itemSpacing));
            var _local2 = (this._position | 0);
            if (this._index == _local2){
                return;
            };
            this._index = _local2;
            this.updateItems();
        }
        public function get position():Number{
            return (this._position);
        }
        public function get index():int{
            return (this._index);
        }
        public function get itemOrigin():int{
            return (this._itemOrigin);
        }
        public function get itemSpacing():int{
            return (this._itemSpacing);
        }
        public function get dataChanged():ISignal{
            return (this._dataChanged);
        }
        public function get itemCleared():ISignal{
            return (this._itemCleared);
        }
        public function get itemDefined():ISignal{
            return (this._itemDefined);
        }
        private function init():void{
            this.property = this._axis.property;
            this.basePosition = this.container[this.property];
            var _local1:Vector.<MovieClip> = this.generateChildren();
            this._grid = this.generateChildrenGrid(_local1);
            this.columns = this._grid.length;
            this.rows = this._grid[0].length;
            this.configureSpacing(this._grid);
            this._position = 0;
            this._index = 0;
            switch (this._axis){
                case ListAxis.X_AXIS:
                    this.updateItems = this.updateItemsX;
                    break;
                case ListAxis.Y_AXIS:
                    this.updateItems = this.updateItemsY;
                    break;
            };
        }
        private function generateChildren():Vector.<MovieClip>{
            var _local4:MovieClip;
            var _local1:Vector.<MovieClip> = new Vector.<MovieClip>();
            var _local2:uint = this.container.numChildren;
            var _local3:int;
            while (_local3 < _local2) {
                _local4 = (this.container.getChildAt(_local3) as MovieClip);
                if (_local4){
                    _local1.push(_local4);
                };
                _local3++;
            };
            return (_local1);
        }
        private function generateChildrenGrid(_arg1:Vector.<MovieClip>):Vector.<Vector.<ListItem>>{
            var _local14:int;
            var _local15:int;
            var _local2:Vector.<Vector.<ListItem>> = new Vector.<Vector.<ListItem>>();
            var _local3:uint = _arg1.length;
            var _local4:uint = (_local3 - 1);
            var _local5:Vector.<MovieClip> = _arg1.concat().sort(this.xSortMethod);
            var _local6:Vector.<MovieClip> = _arg1.concat().sort(this.ySortMethod);
            var _local7:Vector.<int> = new Vector.<int>(_local4, true);
            var _local8:Vector.<int> = new Vector.<int>(_local4, true);
            var _local9:int;
            var _local10:int;
            var _local11:uint = _local4;
            while (_local11--) {
                _local14 = (_local5[(_local11 + 1)].x - _local5[_local11].x);
                _local15 = (_local6[(_local11 + 1)].y - _local6[_local11].y);
                _local7[_local11] = _local14;
                _local8[_local11] = _local15;
                _local9 = (_local9 + _local14);
                _local10 = (_local10 + _local15);
            };
            _local9 = (_local9 / _local4);
            _local10 = (_local10 / _local4);
            var _local12:ListItem = new ListItem(_local5[0]);
            _local12.cleared.add(this.onItemCleared);
            _local12.defined.add(this.onItemDefined);
            var _local13:int = (_local2.push(Vector.<ListItem>([_local12])) - 1);
            _local11 = 0;
            while (_local11 < _local4) {
                _local12 = new ListItem(_local5[(_local11 + 1)]);
                _local12.cleared.add(this.onItemCleared);
                _local12.defined.add(this.onItemDefined);
                if (_local7[_local11] < _local9){
                    _local2[_local13].push(_local12);
                } else {
                    _local13 = (_local2.push(Vector.<ListItem>([_local12])) - 1);
                };
                _local11++;
            };
            return (_local2);
        }
        private function onItemCleared(_arg1:ListItem, _arg2:ListDatum):void{
            this._itemCleared.dispatch(_arg1, _arg2);
        }
        private function onItemDefined(_arg1:ListItem, _arg2:ListDatum):void{
            this._itemDefined.dispatch(_arg1, _arg2);
        }
        private function xSortMethod(_arg1:MovieClip, _arg2:MovieClip):int{
            return ((_arg1.x - _arg2.x));
        }
        private function ySortMethod(_arg1:MovieClip, _arg2:MovieClip):int{
            return ((_arg1.y - _arg2.y));
        }
        private function configureSpacing(_arg1:Vector.<Vector.<ListItem>>):void{
            var _local2:ListItem;
            var _local10:int;
            var _local11:MovieClip;
            _local2 = _arg1[0][0];
            var _local3:int = _local2.mc.x;
            var _local4:int = _local2.mc.y;
            _local2 = _arg1[(this.columns - 1)][(this.rows - 1)];
            var _local5:int = _local2.mc.x;
            var _local6:int = _local2.mc.y;
            var _local7:int = ((_local5 - _local3) / (this.columns - 1));
            var _local8:int = ((_local6 - _local4) / (this.rows - 1));
            switch (this._axis){
                case ListAxis.X_AXIS:
                    this._itemOrigin = _local3;
                    this._itemSpacing = _local7;
                    break;
                case ListAxis.Y_AXIS:
                    this._itemOrigin = _local3;
                    this._itemSpacing = _local7;
                    break;
            };
            var _local9:int;
            while (_local9 < this.columns) {
                _local10 = 0;
                while (_local10 < this.rows) {
                    _local2 = _arg1[_local9][_local10];
                    _local11 = _local2.mc;
                    _local11.x = (_local3 + (_local7 * _local9));
                    _local11.y = (_local4 + (_local8 * _local10));
                    _local10++;
                };
                _local9++;
            };
        }
        public function updateItemsX():void{
            var _local2:int;
            var _local3:int;
            var _local4:ListItem;
            var _local5:int;
            var _local1:int = this.columns;
            while (_local1--) {
                _local2 = this.rows;
                while (_local2--) {
                    _local3 = (_local1 + this._index);
                    if (_local3 < 0){
                    } else {
                        _local4 = this._grid[(_local3 % this.columns)][_local2];
                        _local5 = ((_local3 * this.rows) + _local2);
                        _local4.mc.x = (this._itemOrigin + (_local3 * this._itemSpacing));
                        _local4.datum = ((_local5 < this.dataLength)) ? this._data[_local5] : null;
                    };
                };
            };
        }
        public function updateItemsY():void{
            var _local2:int;
            var _local3:int;
            var _local4:ListItem;
            var _local5:int;
            var _local1:int = this.columns;
            while (_local1--) {
                _local2 = this.rows;
                while (_local2--) {
                    _local3 = (_local2 + this._index);
                    if (_local3 < 0){
                    } else {
                        _local4 = this._grid[_local1][(_local2 % this.rows)];
                        _local5 = ((_local3 * this.columns) + _local1);
                        _local4.mc.y = (this._itemOrigin + (_local3 * this._itemSpacing));
                        _local4.datum = ((_local5 < this.dataLength)) ? this._data[_local5] : null;
                    };
                };
            };
        }
        public function get max():uint{
            return (this._max);
        }

    }
}//package alecmce.grid 
