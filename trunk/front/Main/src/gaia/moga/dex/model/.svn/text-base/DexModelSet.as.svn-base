//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.model {
    import __AS3__.vec.*;

    public class DexModelSet {

        private var generic:Object;
        private var instances:Object;
        private var _list:Vector.<DexMoga>;
        private var _series:uint;

        public function DexModelSet(_arg1:uint){
            this._series = _arg1;
            this.generic = {};
            this.instances = {};
            this._list = new Vector.<DexMoga>();
        }
        public function addMoga(_arg1:DexMoga):void{
            var _local3:DexMogaInstance;
            this.generic[_arg1.id] = _arg1;
            this._list.push(_arg1);
            var _local2:int = _arg1.count;
            while (_local2--) {
                _local3 = _arg1.getInstance(_local2);
                this.instances[_local3.id] = _local3;
            };
        }
        public function getMoga(_arg1:uint):DexMoga{
            return (this.generic[_arg1]);
        }
        public function get list():Vector.<DexMoga>{
            return (this._list);
        }
        public function getInstance(_arg1:uint):DexMogaInstance{
            return (this.instances[_arg1]);
        }
        public function get series():uint{
            return (this._series);
        }

    }
}//package gaia.moga.dex.model 
