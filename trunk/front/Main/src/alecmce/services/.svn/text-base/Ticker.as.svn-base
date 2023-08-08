//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.services {
    import flash.display.*;
    import flash.events.*;

    public class Ticker {

        private var shape:Shape;
        private var fns:Array;
        private var len:uint;

        public function Ticker(){
            this.shape = new Shape();
            this.fns = [];
            this.len = 0;
        }
        public function add(_arg1:Function):void{
            var _local2:int = this.fns.indexOf(_arg1);
            if (_local2 != -1){
                return;
            };
            var _local3 = this.len++;
            this.fns[_local3] = _arg1;
            if (this.len == 1){
                this.shape.addEventListener(Event.ENTER_FRAME, this.iterate);
            };
        }
        public function remove(_arg1:Function):void{
            var _local2:int = this.fns.indexOf(_arg1);
            if (_local2 == -1){
                return;
            };
            this.fns.splice(_local2, 1);
            if (!--this.len){
                this.shape.removeEventListener(Event.ENTER_FRAME, this.iterate);
            };
        }
        private function iterate(_arg1:Event):void{
            var _local2:int;
            while (_local2 < this.len) {
                var _local3 = this.fns;
                _local3[_local2]();
                _local2++;
            };
        }

    }
}//package alecmce.services 
