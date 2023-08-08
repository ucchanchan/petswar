//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.home {
    import flash.display.*;
    import flash.events.*;
    import __AS3__.vec.*;

    public class DepthSorter {

        private var _container:Sprite;
        private var _elements:Vector.<DisplayObject>;
        private var _length:int;

        public function DepthSorter(_arg1:Sprite){
            this._container = _arg1;
            this._elements = this.generateInitialElements();
            this._length = this._elements.length;
            this._container.addEventListener(Event.ADDED, this.onAdded);
            this._container.addEventListener(Event.REMOVED, this.onRemoved);
            this._container.addEventListener(Event.ENTER_FRAME, this.depthSorting);
        }
        public function dispose(_arg1:Boolean=true):void{
            this._elements.length = 0;
            this._container.removeEventListener(Event.ADDED, this.onAdded);
            this._container.removeEventListener(Event.REMOVED, this.onRemoved);
            this._container.removeEventListener(Event.ENTER_FRAME, this.depthSorting);
        }
        private function generateInitialElements():Vector.<DisplayObject>{
            var _local1:Vector.<DisplayObject> = new Vector.<DisplayObject>();
            var _local2:int = this._container.numChildren;
            var _local3:int;
            while (_local3 < _local2) {
                _local1.push(this._container.getChildAt(_local3));
                _local3++;
            };
            return (_local1);
        }
        private function onAdded(_arg1:Event):void{
            var _local2:DisplayObject = DisplayObject(_arg1.target);
            if (_local2.parent != this._container){
                return;
            };
            this._elements.push(_local2);
            this._length++;
        }
        private function onRemoved(_arg1:Event):void{
            var _local2:DisplayObject = DisplayObject(_arg1.target);
            var _local3:int = this._elements.indexOf(_local2);
            if (_local3 == -1){
                return;
            };
            this._elements.splice(_local3, 1);
            this._length--;
        }
        private function depthSorting(_arg1:Event):void{
            this._elements.sort(this.sort);
            var _local2:int = this._length;
            while (_local2--) {
                this._container.setChildIndex(this._elements[_local2], _local2);
            };
        }
        private function sort(_arg1:DisplayObject, _arg2:DisplayObject):int{
            var _local3:Number = (_arg1.y - _arg2.y);
            return (((_local3 > 0)) ? 1 : ((_local3 < 0)) ? -1 : 0);
        }

    }
}//package com.gaiaonline.monster.view.components.home 
