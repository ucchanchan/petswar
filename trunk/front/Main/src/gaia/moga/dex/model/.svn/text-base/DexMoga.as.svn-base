//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.model {
    import __AS3__.vec.*;
    import gaia.moga.dex.assets.*;
    import gaia.moga.monster.model.*;

    public class DexMoga {

        private var _bundle:DexMogaBundle;
        private var _instances:Vector.<DexMogaInstance>;
        private var _instanceMap:Object;
        private var _length:uint;
        public var series:uint;
        public var id:uint;
        public var zodiac:uint;
        public var genericName:String;
        public var rarity:int;
        public var strengthRating:int;
        public var toughnessRating:int;
        public var zodiacRating:int;
        public var description:String;
        public var effectiveness:MogaEffectiveness;

        public function DexMoga(_arg1:DexMogaBundle){
            this._bundle = _arg1;
            this._instances = new Vector.<DexMogaInstance>();
            this._instanceMap = {};
            this._length = 0;
        }
        public function get bundle():DexMogaBundle{
            return (this._bundle);
        }
        public function addInstance(_arg1:DexMogaInstance):void{
            var _local2:int = _arg1.id;
            if (this._instanceMap[_local2] != null){
                return;
            };
            this._length = this._instances.push(_arg1);
            this._instances.sort(this.compareFunction);
            this._instanceMap[_local2] = _arg1;
        }
        private function compareFunction(_arg1:DexMogaInstance, _arg2:DexMogaInstance):int{
            return ((_arg1.model.level - _arg2.model.level));
        }
        public function getInstance(_arg1:uint):DexMogaInstance{
            return (((_arg1 < this._length)) ? this._instances[_arg1] : null);
        }
        public function getInstanceByID(_arg1:uint):DexMogaInstance{
            return (this._instanceMap[_arg1]);
        }
        public function get count():uint{
            return (this._length);
        }

    }
}//package gaia.moga.dex.model 
