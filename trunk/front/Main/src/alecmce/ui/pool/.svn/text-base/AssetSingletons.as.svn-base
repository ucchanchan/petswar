//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.pool {
    import alecmce.ui.*;

    public class AssetSingletons {

        private var elements:Object;

        public function AssetSingletons(){
            this.elements = {};
        }
        public function require(_arg1:String, _arg2:Boolean=true):Asset{
            var _local3:PooledAsset = this.elements[_arg1];
            if (_local3){
                return (null);
            };
            var _local4:MovieClipAssetLoader = new MovieClipAssetLoader(_arg1);
            _local3 = new PooledAsset(_local4, _arg1);
            _local3.destroyed.addOnce(this.onAssetDestroyed);
            _local3.init();
            return (_local3);
        }
        private function onAssetDestroyed(_arg1:PooledAsset):void{
            delete this.elements[_arg1.url];
        }

    }
}//package alecmce.ui.pool 
