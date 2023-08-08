//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.pool {
    import alecmce.ui.*;
    import __AS3__.vec.*;
    import alecmce.ui.pool.*;

    class AssetPoolItem {

        private var url:String;
        private var max:int;
        private var list:Vector.<PooledAsset>;
        private var count:int;
        private var index:int;

        function AssetPoolItem(_arg1:String, _arg2:int){
            this.url = _arg1;
            this.max = _arg2;
            this.list = new Vector.<PooledAsset>(_arg2, true);
            this.count = 0;
            this.index = 0;
        }
        public function require(_arg1:Boolean=true):Asset{
            var _local2:PooledAsset;
            if (this.index == this.max){
                return (this.generateDynamicAsset(_arg1));
            };
            if (this.index == this.count){
                _local2 = this.generatePooledAsset(_arg1);
            } else {
                _local2 = this.list[this.index++];
            };
            _local2.released.addOnce(this.onReleased);
            return (_local2);
        }
        private function generateDynamicAsset(_arg1:Boolean):Asset{
            var _local2:MovieClipAssetLoader = new MovieClipAssetLoader(this.url);
            if (_arg1){
                _local2.init();
            };
            return (_local2);
        }
        private function generatePooledAsset(_arg1:Boolean):PooledAsset{
            var _local2:Asset = this.generateDynamicAsset(_arg1);
            var _local3:PooledAsset = new PooledAsset(_local2, this.url);
            var _local4 = this.count++;
            this.list[_local4] = _local3;
            this.index = this.count;
            return (_local3);
        }
        public function recycle():void{
            while (this.index--) {
                this.list[this.index].dispose();
            };
            this.index = 0;
            this.count = 0;
        }
        private function onReleased(_arg1:PooledAsset):void{
            var _local2:int = this.list.indexOf(_arg1);
            var _local3:PooledAsset = this.list[--this.index];
            if (_local3 == _arg1){
                return;
            };
            this.list[this.index] = _arg1;
            this.list[_local2] = _local3;
        }
        public function destroy(_arg1:Boolean=true):void{
            while (this.count--) {
                this.list[this.count].destroy(_arg1);
                this.list[this.count] = null;
            };
        }

    }
}//package alecmce.ui.pool 
