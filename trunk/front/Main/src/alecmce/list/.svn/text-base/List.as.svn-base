//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.list {
    import flash.display.*;
    import org.osflash.signals.*;
    import __AS3__.vec.*;

    public class List {

        private var container:MovieClip;
        private var _axis:ListAxis;
        private var property:String;
        private var _items:Vector.<ListItem>;
        private var count:uint;
        private var basePosition:int;
        private var _itemOrigin:int;
        private var _itemSpacing:int;
        private var _data:Vector.<ListDatum>;
        private var dataLength:Number;
        private var _position:Number;
        private var _index:int;
        private var _dataChanged:Signal;

        public function List(_arg1:MovieClip, _arg2:ListAxis=null){
            this.container = _arg1;
            this._axis = _arg2;
            this._dataChanged = new Signal(List);
            this.init();
        }
        public function get axis():ListAxis{
            return (this._axis);
        }
        public function get items():Vector.<ListItem>{
            return (this._items);
        }
        public function set data(_arg1:Vector.<ListDatum>):void{
            if (this._data == _arg1){
                return;
            };
            this._data = _arg1;
            this.dataLength = this._data.length;
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
        private function init():void{
            var _local1:Vector.<MovieClip> = this.generateChildren(this.container);
            this._axis = ((this._axis) || (this.determineAxis(_local1)));
            this.property = this._axis.property;
            this.basePosition = this.container[this.property];
            this.configureSpacing(_local1);
            this._items = this.generateItems(_local1);
            this.count = this._items.length;
            this._position = 0;
            this._index = 0;
            this.updateItems();
        }
        private function generateChildren(_arg1:MovieClip):Vector.<MovieClip>{
            var _local5:MovieClip;
            var _local2:Vector.<MovieClip> = new Vector.<MovieClip>();
            var _local3:uint = _arg1.numChildren;
            var _local4:int;
            while (_local4 < _local3) {
                _local5 = (_arg1.getChildAt(_local4) as MovieClip);
                if (_local5){
                    _local2.push(_local5);
                };
                _local4++;
            };
            return (_local2);
        }
        private function determineAxis(_arg1:Vector.<MovieClip>):ListAxis{
            var _local6:int;
            var _local7:int;
            var _local2:int = int.MAX_VALUE;
            var _local3:int = int.MAX_VALUE;
            var _local4:int = -(int.MAX_VALUE);
            var _local5:int = -(int.MAX_VALUE);
            var _local8:int = _arg1.length;
            var _local9:int;
            while (_local9 < _local8) {
                _local6 = (_arg1[_local9].x | 0);
                _local7 = (_arg1[_local9].y | 0);
                if (_local6 < _local2){
                    _local2 = _local6;
                };
                if (_local6 > _local4){
                    _local4 = _local6;
                };
                if (_local7 < _local3){
                    _local3 = _local7;
                };
                if (_local7 > _local5){
                    _local5 = _local7;
                };
                _local9++;
            };
            return ((((_local5 - _local3) > (_local4 - _local2))) ? ListAxis.Y_AXIS : ListAxis.X_AXIS);
        }
        private function configureSpacing(_arg1:Vector.<MovieClip>):void{
            _arg1 = _arg1.sort(this.sort);
            var _local2:uint = _arg1.length;
            var _local3:MovieClip = _arg1[0];
            var _local4:MovieClip = _arg1[(_local2 - 1)];
            var _local5:String = ((this._axis == ListAxis.X_AXIS)) ? "left" : "top";
            var _local6:int = _local4.getRect(_local4.parent)[_local5];
            var _local7:int = _local3.getRect(_local3.parent)[_local5];
            var _local8:int = _local3[this.property];
            var _local9:int = ((_local6 - _local7) / (_local2 - 1));
            var _local10:int;
            while (_local10 < _local2) {
                _arg1[_local10][this.property] = (_local8 + (_local10 * _local9));
                _local10++;
            };
            this._itemSpacing = _local9;
            this._itemOrigin = _local7;
        }
        private function sort(_arg1:MovieClip, _arg2:MovieClip):int{
            return (((_arg1[this.property] < _arg2[this.property])) ? -1 : ((_arg1[this.property] > _arg2[this.property])) ? 1 : 0);
        }
        private function generateItems(_arg1:Vector.<MovieClip>):Vector.<ListItem>{
            var _local2:uint = _arg1.length;
            var _local3:Vector.<ListItem> = new Vector.<ListItem>(_local2, true);
            var _local4:int;
            while (_local4 < _local2) {
                _local3[_local4] = new ListItem(_arg1[_local4]);
                _local4++;
            };
            return (_local3);
        }
        public function updateItems():void{
            var _local2:int;
            var _local3:ListItem;
            var _local1:int = this.count;
            while (_local1--) {
                _local2 = (_local1 + this._index);
                if (_local2 < 0){
                } else {
                    _local3 = this._items[(_local2 % this.count)];
                    _local3.mc[this.property] = (this._itemOrigin + (_local2 * this._itemSpacing));
                    _local3.datum = ((_local2 < this.dataLength)) ? this._data[_local2] : null;
                };
            };
        }

    }
}//package alecmce.list 
