//Created by Action Script Viewer - http://www.buraks.com/asv
package gaia.moga.dex.model {
    import __AS3__.vec.*;
    import org.robotlegs.mvcs.*;

    public class DexModel extends Actor {

        private var mogas:Object;
        private var data:Vector.<DexModelSet>;
        private var _series:uint;
        private var _seriesCount:uint;
        public var isSetup:Boolean;

        public static const DEFAULT:String = "DEFAULT";

        public function DexModel(){
            this.mogas = {};
            this.data = new Vector.<DexModelSet>();
            this._series = 0;
        }
        public function get series():uint{
            return (this._series);
        }
        public function set series(_arg1:uint):void{
            this._series = _arg1;
        }
        public function get currentSeries():DexModelSet{
            return (this.data[this._series]);
        }
        public function setSeries(_arg1:uint):DexModelSet{
            this._series = _arg1;
            return (this.getSeries(_arg1));
        }
        public function getSeries(_arg1:uint):DexModelSet{
            var _local2:uint = (_arg1 + 1);
            if (this.data.length < _local2){
                this.data.length = _local2;
                this._seriesCount = _local2;
            };
            return ((this.data[_arg1] = ((this.data[_arg1]) || (new DexModelSet(_arg1)))));
        }
        public function getMoga(_arg1:uint):DexMoga{
            return (this.mogas[_arg1]);
        }
        public function addMoga(_arg1:DexMoga):void{
            this.mogas[_arg1.id] = _arg1;
            var _local2:DexModelSet = this.getSeries(_arg1.series);
            _local2.addMoga(_arg1);
        }
        public function getInstance(_arg1:uint):DexMogaInstance{
            var _local2:DexModelSet;
            var _local3:DexMogaInstance;
            for each (_local2 in this.data) {
                _local3 = _local2.getInstance(_arg1);
                if (_local3){
                    return (_local3);
                };
            };
            return (null);
        }
        public function get seriesCount():uint{
            return (this._seriesCount);
        }

    }
}//package gaia.moga.dex.model 
