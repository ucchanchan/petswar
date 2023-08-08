//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.data.list {
    import flash.display.*;
    import flash.utils.*;
    import __AS3__.vec.*;
    import flash.geom.*;
    import alecmce.ui.data.item.*;
    import alecmce.data.item.*;
    import alecmce.data.list.*;

    public class ShortUIList {

        protected var list:ShortList;
        protected var mapToWrapper:Dictionary;
        protected var mapToItem:Dictionary;
        protected var _positions:Vector.<Rectangle>;
        protected var _container:Sprite;

        public function ShortUIList(_arg1:Vector.<Rectangle>){
            this._positions = _arg1;
            this.list = new ShortList(_arg1.length);
            this.mapToWrapper = new Dictionary();
            this.mapToItem = new Dictionary();
        }
        public function init(_arg1:Sprite):void{
            var _local4:UIDataItemWrapper;
            this._container = _arg1;
            var _local2:uint = this.list.count;
            var _local3:int;
            while (_local3 < _local2) {
                _local4 = UIDataItemWrapper(this.list.get(_local3));
                this.addToContainer(_local4);
                _local3++;
            };
        }
        public function add(_arg1:UIDataItem):Boolean{
            if (this.mapToWrapper[_arg1]){
                return (false);
            };
            var _local2:UIDataItemWrapper = new UIDataItemWrapper(_arg1);
            if (!this.list.add(_local2)){
                return (false);
            };
            this.addToContainer(_local2);
            this.mapToWrapper[_arg1] = _local2;
            this.mapToItem[_local2] = _arg1;
            return (true);
        }
        public function get count():uint{
            return (this.list.count);
        }
        public function getItems():Vector.<UIDataItem>{
            var _local1:Vector.<DataItem> = this.list.getItems();
            var _local2:int = _local1.length;
            var _local3:Vector.<UIDataItem> = new Vector.<UIDataItem>(_local2, true);
            while (_local2--) {
                _local3[_local2] = (_local1[_local2] as UIDataItem);
            };
            return (_local3);
        }
        public function includes(_arg1:UIDataItem):Boolean{
            return (!((this.mapToWrapper[_arg1] == null)));
        }
        public function indexOf(_arg1:UIDataItem):int{
            var _local2:UIDataItemWrapper = this.mapToWrapper[_arg1];
            return (this.list.indexOf(_local2));
        }
        public function insert(_arg1:UIDataItem, _arg2:uint):Boolean{
            if (this.mapToWrapper[_arg1]){
                return (false);
            };
            var _local3:UIDataItemWrapper = new UIDataItemWrapper(_arg1);
            if (!this.list.insert(_local3, _arg2)){
                return (false);
            };
            this.addToContainer(_local3);
            this.mapToWrapper[_arg1] = _local3;
            this.mapToItem[_local3] = _arg1;
            this.updatePositions(_local3);
            return (true);
        }
        public function move(_arg1:UIDataItem, _arg2:uint):Boolean{
            var _local3:UIDataItemWrapper = this.mapToWrapper[_arg1];
            if (((!(_local3)) || ((_arg2 >= this.list.count)))){
                return (false);
            };
            var _local4:int = this.list.indexOf(_local3);
            if (_arg2 == _local4){
                return (true);
            };
            if (!this.list.move(_local3, _arg2)){
                return (false);
            };
            this.updatePositions(_local3);
            return (true);
        }
        public function remove(_arg1:UIDataItem):Boolean{
            var _local2:UIDataItemWrapper = this.mapToWrapper[_arg1];
            if (!_local2){
                return (false);
            };
            var _local3:int = this.list.indexOf(_local2);
            if (!this.list.remove(_local2)){
                return (false);
            };
            this.removeFromContainer(_local2, _local3);
            delete this.mapToWrapper[_arg1];
            delete this.mapToItem[_local2];
            this.updatePositions(_local2);
            return (true);
        }
        public function clear():void{
            var _local1:*;
            for (_local1 in this.mapToWrapper) {
                this.remove(_local1);
            };
        }
        private function updatePositions(_arg1:UIDataItemWrapper):void{
            var _local4:UIDataItemWrapper;
            var _local2:uint = this.list.max;
            var _local3:int;
            while (_local3 < _local2) {
                _local4 = UIDataItemWrapper(this.list.get(_local3));
                if (_local4){
                    this.moveInContainer(_local4, _local3, (_local4 == _arg1));
                };
                _local3++;
            };
        }
        private function addToContainer(_arg1:UIDataItemWrapper):void{
            if (!this._container){
                return;
            };
            var _local2:int = this.list.indexOf(_arg1);
            var _local3:Rectangle = this._positions[_local2];
            _arg1.item.apply(this._container, _local3, UIDataItemState.ADD);
        }
        private function moveInContainer(_arg1:UIDataItemWrapper, _arg2:uint, _arg3:Boolean):void{
            var _local4:UIDataItemState;
            if (!this._container){
                return;
            };
            if (_arg3){
                _local4 = UIDataItemState.PRIMARY;
            } else {
                _local4 = UIDataItemState.MOVE;
            };
            var _local5:Rectangle = this._positions[_arg2];
            _arg1.item.apply(this._container, _local5, _local4);
        }
        private function removeFromContainer(_arg1:UIDataItemWrapper, _arg2:uint):void{
            if (!this._container){
                return;
            };
            var _local3:Rectangle = this._positions[_arg2];
            _arg1.item.apply(this._container, _local3, UIDataItemState.REMOVE);
        }
        public function toString():String{
            return (this.list.toString());
        }
        public function get positions():Vector.<Rectangle>{
            return (this._positions);
        }

    }
}//package alecmce.ui.data.list 
