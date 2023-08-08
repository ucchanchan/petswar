//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.data.list {
    import __AS3__.vec.*;
    import alecmce.data.item.*;

    public class ShortList {

        private var _list:Vector.<DataItem>;
        private var _max:uint;
        private var _count:uint;

        public function ShortList(_arg1:uint){
            this._list = new Vector.<DataItem>();
            this._max = _arg1;
            this._count = 0;
        }
        public function get(_arg1:uint):DataItem{
            if (_arg1 >= this._count){
                return (null);
            };
            return (this._list[_arg1]);
        }
        public function indexOf(_arg1:DataItem):int{
            return (this._list.indexOf(_arg1));
        }
        public function add(_arg1:DataItem):Boolean{
            var _local2:int = this._list.indexOf(_arg1);
            if ((((this._count == this._max)) || (!((_local2 == -1))))){
                return (false);
            };
            this._list.push(_arg1);
            this._count++;
            return (true);
        }
        public function insert(_arg1:DataItem, _arg2:uint):Boolean{
            if ((((((this._count == this._max)) || ((_arg2 >= this._max)))) || ((_arg2 > this._count)))){
                return (false);
            };
            var _local3:int = this._list.indexOf(_arg1);
            if (_local3 != -1){
                return (false);
            };
            this._list.splice(_arg2, 0, _arg1);
            this._count++;
            return (true);
        }
        public function move(_arg1:DataItem, _arg2:uint):Boolean{
            var _local3:int = this._list.indexOf(_arg1);
            if ((((_local3 == -1)) || ((_arg2 >= this._count)))){
                return (false);
            };
            if (_local3 == _arg2){
                return (true);
            };
            this._list.splice(_local3, 1);
            this._list.splice(_arg2, 0, _arg1);
            return (true);
        }
        public function remove(_arg1:DataItem):Boolean{
            var _local2:int = this._list.indexOf(_arg1);
            if (_local2 == -1){
                return (false);
            };
            this._list.splice(_local2, 1);
            this._count--;
            return (true);
        }
        public function get max():uint{
            return (this._max);
        }
        public function get count():uint{
            return (this._count);
        }
        public function toString():String{
            return (this._list.join(","));
        }
        public function getItems():Vector.<DataItem>{
            return (this._list.concat());
        }

    }
}//package alecmce.data.list 
