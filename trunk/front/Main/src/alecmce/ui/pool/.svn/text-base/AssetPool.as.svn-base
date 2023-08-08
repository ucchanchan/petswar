//Created by Action Script Viewer - http://www.buraks.com/asv
package alecmce.ui.pool {
    import alecmce.ui.*;

    public class AssetPool {

        private var pools:Object;

        public function AssetPool(){
            this.pools = {};
        }
        public function register(_arg1:String, _arg2:int):void{
            if (this.pools[_arg1]){
                return;
            };
            var _local3:AssetPoolItem = new AssetPoolItem(_arg1, _arg2);
            this.pools[_arg1] = _local3;
        }
        public function isRegistered(_arg1:String):Boolean{
            return (!((this.pools[_arg1] == null)));
        }
        public function require(_arg1:String, _arg2:Boolean=true):Asset{
            var _local3:AssetPoolItem = this.pools[_arg1];
            if (!_local3){
                return (null);
            };
            return (_local3.require(_arg2));
        }

    }
}//package alecmce.ui.pool 
